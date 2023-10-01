import 'package:gillar/src/enviroment/env.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService {
  final String key = Environment.API_KEY_MAPS;

  Future<LatLng> searchPlaces(String searchText) async {
    final String url = Environment.API_URL_PLACES_NEW;

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
}
