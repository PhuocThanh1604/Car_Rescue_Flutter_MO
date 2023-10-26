import 'package:CarRescue/src/enviroment/env.dart';
import 'package:CarRescue/src/models/location_info.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationProvider {
  final String key = Environment.API_KEY_MAPS;
  final String url = Environment.API_URL_PLACES_NEW;
  final String keyPredictions = Environment.API_KEY_PREDICTIONS;
  
  Future<LatLng> searchPlaces(String searchText) async {

    var headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': key,
      'X-Goog-FieldMask':
          'places.displayName,places.formattedAddress,places.location,places.priceLevel',
    };

    var body = {
      'textQuery': '$searchText',
    };

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: convert.jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var responseData = convert.jsonDecode(response.body);
      var locationMap = responseData['places'][0]['location'];
      var latitude = locationMap['latitude'];
      var longitude = locationMap['longitude'];
      LatLng newPosition = LatLng(latitude, longitude);
      print(newPosition);
      return newPosition;
    } else {
      print('Error: ${response.statusCode}');
      throw Exception('Failed to fetch location');
    }
  }

  Future<PlacesAutocompleteResponse> getPlacePredictions(String input) async {
    try {
      final places = GoogleMapsPlaces(apiKey: keyPredictions,apiHeaders: await const GoogleApiHeaders().getHeaders());
      final response = await places.autocomplete(
        input,
        language: 'vn',
        components: [Component(Component.country, 'vn')], // Thay thế bằng quốc gia 
      );

      if (response.isOkay) {
        return response;
      } else {
        return PlacesAutocompleteResponse(status: 'ZERO_RESULTS', predictions: []);
      }
    } catch (e) {
      print('Error fetching place predictions: $e');
      return PlacesAutocompleteResponse(status: 'ERROR', predictions: []);
    }
  }

//   Future<List<LocationInfo>> getDisplayNames(String searchText) async {
//   final Map<String, String> params = {
//     'q': searchText,
//     'format': 'json',
//     'addressdetails': '1',
//     'polygon_geojson': '0',
//   };
//   final Uri uri = Uri.https('nominatim.openstreetmap.org', '/search', params);

//   final Map<String, String> headers = {
//     'Content-Type': 'application/json',
//   };

//   try {
//     final response = await http.get(uri, headers: headers);

//     if (response.statusCode == 200) {
//       final List<dynamic> data = convert.json.decode(response.body);
//       if (data.isNotEmpty) {
//         final locationInfoList = data.map((result) {
//           return LocationInfo.fromJson(result);
//         }).toList();
//         return locationInfoList;
//       } else {
//         // Return an empty list if data is empty
//         return [];
//       }
//     } else {
//       throw Exception('Lỗi kết nối');
//     }
//   } catch (e) {
//     throw Exception('Lỗi: $e');
//   }
// }

Future<List<LocationInfo>> getDisplayNamesByVietMap(String searchText) async {
  final Map<String, String> params = {
    'apikey': 'c3d0f188ff669f89042771a20656579073cffec5a8a69747',
    'cityId': '12',
    'text': searchText,
    'circle_center': '10.8760856947,106.801249981',
    'circle_radius': '40000',
    'layers': 'POI',
  };

  final Uri uri = Uri.https('maps.vietmap.vn', '/api/autocomplete/v3', params);

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> data = convert.json.decode(response.body);
      if (data.isNotEmpty) {
        final locationInfoList = data.map((result) {
          return LocationInfo.fromJson(result);
        }).toList();
        return locationInfoList;
      } else {
        // Return an empty list if data is empty
        return [];
      }
    } else {
      throw Exception('Lỗi kết nối');
    }
  } catch (e) {
    throw Exception('Lỗi: $e');
  }
}

Future<List<LocationInfo>> getLocationsWithLatLng(String searchText) async {
  // Gọi API vietmap.vn để lấy địa chỉ (display)
  final vietMapLocations = await getDisplayNamesByVietMap(searchText);

  // Tạo danh sách mới để lưu các LocationInfo với latitude và longitude
  final locationsWithLatLng = <LocationInfo>[];

  // Lặp qua danh sách địa chỉ (display) từ API vietmap.vn
  for (final locationInfo in vietMapLocations) {
    // Gọi API của Google Maps Places để lấy latitude và longitude dựa trên địa chỉ (display)
    final latLng = await searchPlaces(locationInfo.display);

    // Tạo một LocationInfo mới với thông tin từ API vietmap.vn và latitude, longitude từ Google Maps Places
    final locationWithLatLng = LocationInfo(
      refId: locationInfo.refId,
      distance: locationInfo.distance,
      address: locationInfo.address,
      name: locationInfo.name,
      display: locationInfo.display,
      latitude: latLng.latitude,
      longitude: latLng.longitude,
    );

    // Thêm LocationInfo mới vào danh sách locationsWithLatLng
    locationsWithLatLng.add(locationWithLatLng);
  }

  return locationsWithLatLng;
}



  
}
