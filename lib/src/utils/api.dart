import 'dart:convert';
import 'dart:io';
import 'package:CarRescue/src/models/feedback.dart';
import 'package:CarRescue/src/models/service_detailed.dart';
import 'package:CarRescue/src/models/vehicle_item.dart';

import 'package:CarRescue/src/models/booking.dart';

import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

class LoginResult {
  final String userId;
  final String accountId;
  final String fullname;
  final String? avatar;
  LoginResult({
    required this.userId,
    required this.accountId,
    required this.fullname,
    required this.avatar,
  });
}

class AuthService {
  //TECHNICIAN API
  Future<LoginResult?> login(
      String email, String password, String deviceToken) async {
    try {
      // Your existing login logic here
      final response = await http.post(
        Uri.parse(
            'https://rescuecapstoneapi.azurewebsites.net/api/Login/Login'),
        body: jsonEncode(
            {'email': email, 'password': password, 'devicetoken': deviceToken}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 200) {
          final technician = data['data']['technician'];
          if (technician != null) {
            final userId = technician['id'];
            final accountId = technician['accountId'];
            final fullname = technician['fullname'];
            final avatar = technician['avatar'] ?? '';
            // Fetch user profile information using the user ID
            final userProfile = await fetchTechProfile(userId);

            if (userProfile != null) {
              // Now you have the user profile data
              print('PROFILE: $userProfile');
            } else {
              // Handle the case where profile fetching failed
            }

            return LoginResult(
                userId: userId,
                accountId: accountId,
                fullname: fullname,
                avatar: avatar);
          }
        } else {
          return null; // Return null for failed login (adjust as needed)
        }
      } else {
        // Handle non-200 status code
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
    return null;
  }

  Future<Map<String, dynamic>?> fetchTechProfile(String userId) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://rescuecapstoneapi.azurewebsites.net/api/Technician/Get?id=$userId'), // Replace with your actual API endpoint
      );

      if (response.statusCode == 200) {
        print(response.statusCode);
        return json.decode(response.body);
      } else {
        // Handle non-200 status code when fetching the user profile
        return null;
      }
    } catch (e) {
      print('Error fetching user profile1: $e');
      return null;
    }
  }

  Future<List<Booking>> fetchBookings(String userId, String excludedId) async {
    try {
      final apiUrl = Uri.parse(
          'https://rescuecapstoneapi.azurewebsites.net/api/Order/GetOrdersOfTechnician?id=$userId');
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // Kiểm tra xem dữ liệu JSON chứa mảng 'data' hay không
        if (jsonData.containsKey('data')) {
          List<dynamic> data = jsonData['data'];

          // Filter the data to exclude the specified ID
          List<Booking> bookings = data
              .where((json) => json['id'] != 'a') // Exclude a specific ID
              .map((json) => Booking.fromJson(json))
              .toList();

          return bookings;
        } else {
          throw Exception('API ');
        }
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      throw Exception('Error fetching bookings: $e');
    }
  }

  // CAR OWNER API
  Future<LoginResult?> loginCarOwner(
      String email, String password, String deviceToken) async {
    try {
      // Your existing login logic here
      final response = await http.post(
        Uri.parse(
            'https://rescuecapstoneapi.azurewebsites.net/api/Login/Login'),
        body: jsonEncode(
            {'email': email, 'password': password, 'deviceToken': deviceToken}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 200) {
          final rescueVehicleOwner = data['data']['rescueVehicleOwner'];
          if (rescueVehicleOwner != null) {
            final rescueVehicleOwnerId = rescueVehicleOwner['id'];
            final accountId = rescueVehicleOwner['accountId'];
            final fullname = rescueVehicleOwner['fullname'];
            final avatar = rescueVehicleOwner['avatar'];
            // Fetch user profile information using the user ID

            return LoginResult(
                userId: rescueVehicleOwnerId,
                accountId: accountId,
                fullname: fullname,
                avatar: avatar);
          }
        } else {
          return null; // Return null for failed login (adjust as needed)
        }
      } else {
        // Handle non-200 status code
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
    return null;
  }

  Future<Map<String, dynamic>?> fetchRescueCarOwnerProfile(
      String userId) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://rescuecapstoneapi.azurewebsites.net/api/RescueVehicleOwner/Get?id=$userId'), // Replace with your actual API endpoint
      );

      if (response.statusCode == 200) {
        print(response.statusCode);
        return json.decode(response.body);
      } else {
        // Handle non-200 status code when fetching the user profile
        return null;
      }
    } catch (e) {
      print('Error fetching user profile1: $e');
      return null;
    }
  }

  Future<List<Booking>> fetchCarOwnerBookings(String userId) async {
    try {
      final apiUrl = Uri.parse(
          'https://rescuecapstoneapi.azurewebsites.net/api/Order/GetOrdersOfRVO?id=$userId');
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // Kiểm tra xem dữ liệu JSON chứa mảng 'data' hay không
        if (jsonData.containsKey('data')) {
          List<dynamic> data = jsonData['data'];

          // Filter the data to exclude the specified ID
          List<Booking> bookings = data
              // Exclude a specific ID
              .map((json) => Booking.fromJson(json))
              .toList();

          return bookings;
        } else {
          throw Exception('Loi');
        }
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      throw Exception('Error fetching booking1s: $e');
    }
  }

  Future<Booking> fetchCarOwnerBookingById(String orderId) async {
    try {
      final apiUrl = Uri.parse(
          'https://rescuecapstoneapi.azurewebsites.net/api/Order/GetOrder?id=$orderId');
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // If 'data' key exists and it's not null
        if (jsonData.containsKey('data') && jsonData['data'] != null) {
          return Booking.fromJson(jsonData['data']);
        } else {
          throw Exception('Invalid data format in response.');
        }
      } else {
        throw Exception('Failed to load booking');
      }
    } catch (e) {
      throw Exception('Error fetching booking: $e');
    }
  }

  Future<List<Booking>> fetchCarOwnerBookingByCompleted(String userId) async {
    try {
      final apiUrl = Uri.parse(
          'https://rescuecapstoneapi.azurewebsites.net/api/Order/GetAllOrderCompletedOfRVO?id=$userId');
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // If 'data' key exists and it's not null
        if (jsonData.containsKey('data') && jsonData['data'] != null) {
          List<dynamic> bookingsData = jsonData['data'];
          return bookingsData
              .map((booking) => Booking.fromJson(booking))
              .toList();
        } else {
          throw Exception('Invalid data format in response.');
        }
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      throw Exception('Error fetching bookings: $e');
    }
  }

  Future<List<Booking>> fetchCarOwnerBookingByCanceled(String userId) async {
    try {
      final apiUrl = Uri.parse(
          'https://rescuecapstoneapi.azurewebsites.net/api/Order/GetAllOrderCancelledOfRVO?id=$userId');
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // If 'data' key exists and it's not null
        if (jsonData.containsKey('data') && jsonData['data'] != null) {
          List<dynamic> bookingsData = jsonData['data'];
          return bookingsData
              .map((booking) => Booking.fromJson(booking))
              .toList();
        } else {
          throw Exception('Invalid data format in response.');
        }
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      throw Exception('Error fetching bookings: $e');
    }
  }

  Future<List<Booking>> fetchCarOwnerBookingByAssigning(String userId) async {
    try {
      final apiUrl = Uri.parse(
          'https://rescuecapstoneapi.azurewebsites.net/api/Order/GetAllOrderAssigningOfRVO?id=$userId');
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // If 'data' key exists and it's not null
        if (!jsonData.containsKey('data') || jsonData['data'] == null) {
          return []; // Return an empty list if 'data' key is missing or null
        } else {
          List<dynamic> bookingsData = jsonData['data'];
          return bookingsData
              .map((booking) => Booking.fromJson(booking))
              .toList();
        }
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      throw Exception('Error fetching bookings: $e');
    }
  }

  Future<List<Booking>> fetchCarOwnerBookingByAssigned(String userId) async {
    try {
      final apiUrl = Uri.parse(
          'https://rescuecapstoneapi.azurewebsites.net/api/Order/GetAllOrderAssignedOfRVO?id=$userId');
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // If 'data' key exists and it's not null
        if (!jsonData.containsKey('data') || jsonData['data'] == null) {
          return []; // Return an empty list if 'data' key is missing or null
        } else {
          List<dynamic> bookingsData = jsonData['data'];
          return bookingsData
              .map((booking) => Booking.fromJson(booking))
              .toList();
        }
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      throw Exception('Error fetching bookings: $e');
    }
  }

  Future<List<Booking>> fetchTechBookingByAssigned(String userId) async {
    try {
      final apiUrl = Uri.parse(
          'https://rescuecapstoneapi.azurewebsites.net/api/Order/GetAllOrderAssignedOfTech?id=$userId');
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // If 'data' key exists and it's not null
        if (!jsonData.containsKey('data') || jsonData['data'] == null) {
          return []; // Return an empty list if 'data' key is missing or null
        } else {
          List<dynamic> bookingsData = jsonData['data'];
          return bookingsData
              .map((booking) => Booking.fromJson(booking))
              .toList();
        }
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      throw Exception('Error fetching bookings: $e');
    }
  }

  Future<List<Booking>> fetchCarOwnerBookingByInprogress(String userId) async {
    try {
      final apiUrl = Uri.parse(
          'https://rescuecapstoneapi.azurewebsites.net/api/Order/GetAllOrderInprogressOfRVO?id=$userId');
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // If 'data' key exists and it's not null
        if (!jsonData.containsKey('data') || jsonData['data'] == null) {
          return []; // Return an empty list if 'data' key is missing or null
        } else {
          List<dynamic> bookingsData = jsonData['data'];
          return bookingsData
              .map((booking) => Booking.fromJson(booking))
              .toList();
        }
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      throw Exception('Error fetching bookings: $e');
    }
  }

  Future<Vehicle> fetchVehicleInfo(String vehicleId) async {
    try {
      final apiUrl = Uri.parse(
          'https://rescuecapstoneapi.azurewebsites.net/api/Vehicle/Get?id=$vehicleId');
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // Check if the JSON contains the vehicle info
        if (jsonData.containsKey('data')) {
          final dynamic data = jsonData['data'];

          // Create a VehicleInfo object from the JSON data
          final Vehicle vehicleInfo = Vehicle.fromJson(data);
          print('day la ${vehicleInfo}');
          return vehicleInfo;
        } else {
          throw Exception('Vehicle info not found');
        }
      } else {
        throw Exception('Failed to load vehicle info');
      }
    } catch (e) {
      throw Exception('Error fetching vehicle info: $e');
    }
  }

  Future<void> fetchServiceData(String orderId) async {
    final apiUrl =
        'https://rescuecapstoneapi.azurewebsites.net/api/OrderDetail/GetDetailsOfOrder?id=$orderId';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> responseData =
          json.decode(response.body);

      for (var orderDetail in responseData) {
        // Get the serviceId from each order detail
        final String serviceId = orderDetail['serviceId'];

        // Fetch service detail
        final Map<String, dynamic> serviceDetail =
            await fetchServiceDetail(serviceId);

        // Access the 'name' field from the service detail
        if (serviceDetail.containsKey('name')) {
          final String serviceName = serviceDetail['name'];
          print('Service Name: $serviceName');
        }

        // Now, you can work with the service detail data as needed
      }
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  Future<Map<String, dynamic>> fetchServiceDetail(String serviceId) async {
    final apiUrl =
        'https://rescuecapstoneapi.azurewebsites.net/api/Service/Get?id=$serviceId';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey('data') && data['data'] is Map<String, dynamic>) {
        final Map<String, dynamic> responseData = data['data'];
        return responseData;
      }
    }
    throw Exception('Failed to load data from API');
  }

  Future<Map<String, String>> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      final List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final Placemark firstPlacemark = placemarks[0];
        final String street = firstPlacemark.street ?? '';
        final String subAddress =
            '${firstPlacemark.thoroughfare}, ${firstPlacemark.subAdministrativeArea}, ${firstPlacemark.country}';
        final String address = '$street';

        final Map<String, String> result = {
          'address': address,
          'subAddress': subAddress,
        };

        return result;
      } else {
        return {
          'address': 'Không tìm thấy địa chỉ',
          'subAddress': '',
        };
      }
    } catch (e) {
      print('Error getting address from coordinates: $e');
      return {
        'address': 'Lỗi khi lấy địa chỉ',
        'subAddress': '',
      };
    }
  }

  // Future<void> getAddressesForBookings(
  //     List<Booking> bookings,
  //     void Function(VoidCallback) setState,
  //     Map<String, String> addresses,
  //     Map<String, String> subAddresses) async {
  //   // Use Future.wait to initiate all requests in parallel.
  //   var results =
  //       await Future.wait(bookings.map((booking) => getAddressInfo(booking)));

  //   // Update the state once with all the results.
  //   setState(() {
  //     for (var result in results) {
  //       addresses[result['bookingId']] = result['address'];
  //       subAddresses[result['bookingId']] = result['subAddress'];
  //     }
  //   });
  // }

  Future<Map<String, dynamic>> getAddressInfo(Booking booking) async {
    // Extract departure latitude and longitude
    final latMatchDeparture =
        RegExp(r'lat:\s?([\-0-9.]+)').firstMatch(booking.departure);
    final longMatchDeparture =
        RegExp(r'long:\s?([\-0-9.]+)').firstMatch(booking.departure);
    final double? latDeparture =
        double.tryParse(latMatchDeparture?.group(1) ?? '');
    final double? longDeparture =
        double.tryParse(longMatchDeparture?.group(1) ?? '');

    // Extract destination latitude and longitude
    final latMatchDestination =
        RegExp(r'lat:\s?([\-0-9.]+)').firstMatch(booking.destination);
    final longMatchDestination =
        RegExp(r'long:\s?([\-0-9.]+)').firstMatch(booking.destination);
    final double? latDestination =
        double.tryParse(latMatchDestination?.group(1) ?? '');
    final double? longDestination =
        double.tryParse(longMatchDestination?.group(1) ?? '');

    // Check if we successfully extracted both departure and destination coordinates
    if (latDeparture == null ||
        longDeparture == null ||
        latDestination == null ||
        longDestination == null) {
      return {
        'bookingId': booking.id,
        'address': 'Không xác định',
        'subAddress': 'Không xác định',
        'destinationAddress': 'Unknown Destination Address',
        'destinationSubAddress': 'Unknown Destination SAddress',
      };
    }

    // Use Google Geocoding API to fetch addresses
    const String apiKey =
        'AIzaSyBD-XWuT_W1Mx98xPV7hQEjSSeGHGnm2mY'; // Replace with your actual API key
    final String urlDeparture =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latDeparture,$longDeparture&key=$apiKey';
    final String urlDestination =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latDestination,$longDestination&key=$apiKey';

    // Get departure address
    final responseDeparture = await http.get(Uri.parse(urlDeparture));
    if (responseDeparture.statusCode != 200) {
      return {
        'bookingId': booking.id,
        'address': 'Error fetching address',
        'subAddress': 'Error fetching subAddress',
        'destinationAddress': 'Error fetching destination address',
        'destinationSubAddress': 'Error fetching Sdestination address',
      };
    }

    // Get destination address
    final responseDestination = await http.get(Uri.parse(urlDestination));
    if (responseDestination.statusCode != 200) {
      // Handle the error or add additional error handling logic here
    }

    var jsonResponseDeparture = json.decode(responseDeparture.body);
    var jsonResponseDestination = json.decode(responseDestination.body);

    if (jsonResponseDeparture['status'] != 'OK' ||
        jsonResponseDeparture['results'].isEmpty) {
      // Handle the error or add additional error handling logic here
    }

    if (jsonResponseDestination['status'] != 'OK' ||
        jsonResponseDestination['results'].isEmpty) {
      // Handle the error or add additional error handling logic here
    }

    var addressComponentsDeparture = jsonResponseDeparture['results'][0]
        ['address_components'] as List<dynamic>;
    var addressComponentsDestination = jsonResponseDestination['results'][0]
        ['address_components'] as List<dynamic>;

    // Format address by extracting street number and route for departure
    String formattedAddressDeparture =
        formatStreetAndRoute(addressComponentsDeparture);
    // Format subAddress by extracting additional details for departure
    String formattedSubAddressDeparture =
        formatSubAddress(addressComponentsDeparture);

    // Format address for destination (You would create similar functions for destination)
    String formattedAddressDestination =
        formatStreetAndRoute(addressComponentsDestination);
    String formattedSubAddressDestination =
        formatSubAddress(addressComponentsDestination);

    return {
      'bookingId': booking.id,
      'address': formattedAddressDeparture,
      'subAddress': formattedSubAddressDeparture,
      'destinationAddress': formattedAddressDestination,
      'destinationSubAddress': formattedSubAddressDestination,
    };
  }

  String formatStreetAndRoute(List<dynamic> addressComponents) {
    String pointOfInterest = '';
    String park = '';
    String route = '';
    String street = '';
    String neighborhood = '';
    String admin1 = '';

    for (var component in addressComponents) {
      if (component['types'].contains('point_of_interest')) {
        pointOfInterest = component['long_name'];
      }
      if (component['types'].contains('park')) {
        park = component['long_name'];
      }
      if (component['types'].contains('route')) {
        route = component[
            'short_name']; // You had long_name here, I'm keeping your newer preference for short_name.
      }
      if (component['types'].contains('street_number')) {
        street = component['long_name'];
      }
      if (component['types'].contains('neighborhood')) {
        neighborhood = component['long_name'];
      }
      if (component['types'].contains('administrative_area_level_1')) {
        admin1 = component[
            'long_name']; // Fixed key from 'administrative_area_level_1' to 'long_name'.
      }
    }

    // Constructing the address based on the presence of different components
    if (pointOfInterest.isNotEmpty || park.isNotEmpty) {
      return '$pointOfInterest${park.isNotEmpty ? " $park" : ""}';
    } else if (street.isNotEmpty && route.isNotEmpty && park.isEmpty) {
      return '$street $route';
    } else if (neighborhood.isNotEmpty && street.isEmpty && route.isEmpty) {
      return neighborhood;
    } else if (route.isNotEmpty && street.isEmpty && park.isEmpty) {
      return route;
    } else if (neighborhood.isNotEmpty &&
        street.isNotEmpty &&
        route.isNotEmpty) {
      return '$neighborhood, $street $route';
    } else if (admin1.isNotEmpty) {
      return '${neighborhood.isNotEmpty ? "$neighborhood, " : ""}${pointOfInterest.isNotEmpty ? "$pointOfInterest, " : ""}${street.isNotEmpty ? "$street " : ""}${route.isNotEmpty ? "$route" : ""}'
          .trim();
    }

    return 'Unknown Address';
  }

  String formatSubAddress(List<dynamic> addressComponents) {
    String? route;
    String? street;
    String? neighborhood;
    String? admin2;
    String? admin1;
    String? locality;

    for (var component in addressComponents) {
      if (component['types'].contains('route')) {
        route = component['long_name'];
      }
      if (component['types'].contains('street_number')) {
        street = component['long_name'];
      }
      if (component['types'].contains('neighborhood')) {
        neighborhood = component['long_name'];
      }
      if (component['types'].contains('administrative_area_level_2')) {
        admin2 = component['long_name'];
      }
      if (component['types'].contains('administrative_area_level_1')) {
        admin1 = component['long_name'];
      }
      if (component['types'].contains('locality')) {
        locality = component['long_name'];
      }
    }

    if (street != null && route != null && admin2 != null) {
      return '$street $route, $admin2, ${admin1 ?? ''}'.trim();
    } else if (street == null &&
        route == null &&
        neighborhood != null &&
        admin2 != null) {
      return '${street ?? ''} ${route ?? ""} $admin2, ${admin1 ?? ''}'.trim();
    } else if (admin1 != null) {
      return '${route ?? ''} ${locality ?? ''} $admin1'.trim();
    }

    return 'Unknown Address';
  }

  // This function fetches address and subaddress for departure locations.
  Future<void> getAddressesForBookings(
      List<Booking> bookings,
      void Function(VoidCallback) setState,
      Map<String, String> addresses,
      Map<String, String> subAddresses) async {
    var results =
        await Future.wait(bookings.map((booking) => getAddressInfo(booking)));

    // Update the state once with all the results.
    setState(() {
      for (var result in results) {
        addresses[result['bookingId']] = result['address'];
        subAddresses[result['bookingId']] = result['subAddress'];
      }
    });
  }

// This function fetches address and subaddress for destination locations.
  Future<void> getDestiForBookings(
      List<Booking> bookings,
      void Function(VoidCallback) setState,
      Map<String, String> addressesDesti,
      Map<String, String> subAddressesDesti) async {
    var results =
        await Future.wait(bookings.map((booking) => getAddressInfo(booking)));

    // Update the state once with all the results.
    setState(() {
      for (var result in results) {
        addressesDesti[result['bookingId']] = result['destinationAddress'];
        subAddressesDesti[result['bookingId']] =
            result['destinationSubAddress'];
      }
    });
  }

  Future<Map<String, dynamic>?> fetchCustomerInfo(String customerId) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://rescuecapstoneapi.azurewebsites.net/api/Customer/Get?id=$customerId'), // Replace with your actual API endpoint
      );

      if (response.statusCode == 200) {
        print(response.statusCode);
        return json.decode(response.body);
      } else {
        // Handle non-200 status code when fetching the user profile
        return null;
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }

  Future<String?> uploadImageToFirebase(
      File imageFile, String storagePath) async {
    try {
      // Generate a unique id for the image
      String filename = DateTime.now().millisecondsSinceEpoch.toString();

      // Create a custom storage reference
      final Reference storageReference =
          FirebaseStorage.instance.ref().child(storagePath + '/$filename');

      UploadTask uploadTask = storageReference.putFile(imageFile);

      // Get the download URL
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> createCarApproval(String? id,
      {required String rvoid,
      required String licensePlate,
      required String manufacturer,
      required String status,
      required String vinNumber,
      required String type,
      required String color,
      required int manufacturingYear,
      required File carRegistrationFontImage,
      required File carRegistrationBackImage,
      required File vehicleImage}) async {
    var uuid = Uuid();
    id ??= uuid.v4();

    String? frontImageUrl = await uploadImageToFirebase(
        carRegistrationFontImage, 'vehicle_verify/images');
    String? backImageUrl = await uploadImageToFirebase(
        carRegistrationBackImage, 'vehicle_verify/images');
    String? vehicleUrl =
        await uploadImageToFirebase(vehicleImage, 'vehicle/images');

    if (frontImageUrl == null || backImageUrl == null || vehicleUrl == null) {
      // Hiển thị lỗi
      print('ko co hinh');
      return false;
    } // If id is null, generate a random UUID
    final String apiUrl =
        "https://rescuecapstoneapi.azurewebsites.net/api/Vehicle/CreateApproval"; // Replace with your endpoint URL

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        // Add other headers if needed, like authorization headers
      },
      body: json.encode({
        'id': id,
        'rvoid': rvoid,
        'licensePlate': licensePlate,
        'manufacturer': manufacturer,
        'status': status,
        'vinNumber': vinNumber,
        'type': type,
        'color': color,
        'manufacturingYear': manufacturingYear,
        "carRegistrationFont": frontImageUrl,
        "carRegistrationBack": backImageUrl,
        'image': vehicleUrl
        // Note: Handling image uploads would require a multipart request.
        // For simplicity, this example does not cover image uploads.
        // You might need a separate API or endpoint to handle the image upload.
      }),
    );
    final List userImage = [frontImageUrl, backImageUrl, vehicleUrl];
    print(userImage);
    if (response.statusCode == 200) {
      print('Successfully created the car ${response.body}');
      return true; //
    } else {
      print('Failed to create the car: ${response.body}');
      return false; // Failed to create the car
    }
  }

  Future<bool> updateCarApproval(
      {required String rvoid,
      required String licensePlate,
      required String manufacturer,
      required String status,
      required String vinNumber,
      required String type,
      required String color,
      required int manufacturingYear,
      required File carRegistrationFontImage,
      required File carRegistrationBackImage,
      required File vehicleImage}) async {
    String? frontImageUrl = await uploadImageToFirebase(
        carRegistrationFontImage, 'vehicle_verify/images');
    String? backImageUrl = await uploadImageToFirebase(
        carRegistrationBackImage, 'vehicle_verify/images');
    String? vehicleUrl =
        await uploadImageToFirebase(vehicleImage, 'vehicle/images');

    if (frontImageUrl == null || backImageUrl == null || vehicleUrl == null) {
      // Hiển thị lỗi
      print('ko co hinh');
      return false;
    } // If id is null, generate a random UUID
    final String apiUrl =
        "https://rescuecapstoneapi.azurewebsites.net/api/Vehicle/UpdateApproval"; // Replace with your endpoint URL

    final response = await http.put(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        // Add other headers if needed, like authorization headers
      },
      body: json.encode({
        'rvoid': rvoid,
        'licensePlate': licensePlate,
        'manufacturer': manufacturer,
        'status': status,
        'vinNumber': vinNumber,
        'type': type,
        'color': color,
        'manufacturingYear': manufacturingYear,
        "carRegistrationFont": frontImageUrl,
        "carRegistrationBack": backImageUrl,
        'image': vehicleUrl
        // Note: Handling image uploads would require a multipart request.
        // For simplicity, this example does not cover image uploads.
        // You might need a separate API or endpoint to handle the image upload.
      }),
    );
    final List userImage = [frontImageUrl, backImageUrl, vehicleUrl];
    print(userImage);
    if (response.statusCode == 200) {
      print('Successfully created the car ${response.body}');
      return true; //
    } else {
      print('Failed to create the car: ${response.body}');
      return false; // Failed to create the car
    }
  }

  Future<String?> getDeviceToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String? token;
    try {
      token = await messaging.getToken();
      print('Device Token: $token');
      return token;
    } catch (e) {
      print('Failed to get FCM token: $e');
      return null;
    }
  }

  Future<bool> acceptOrder(String orderId, bool decision) async {
    final String apiUrl =
        "https://rescuecapstoneapi.azurewebsites.net/api/Order/AcceptOrder?id=$orderId&decision=$decision";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        // Add other headers if needed, like authorization headers
      },
      body: json.encode({'id': orderId, 'decision': decision}),
    );
    if (response.statusCode == 201) {
      print('Successfully accept order ${response.body}');
      return true;
    } else {
      print('Failed to accept order: ${response.body}');
      // Failed to create the car
    }
    return false;
  }

  Future<bool> startOrder(String orderId) async {
    final String apiUrl =
        "https://rescuecapstoneapi.azurewebsites.net/api/Order/StartOrder?id=$orderId";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        // Add other headers if needed, like authorization headers
      },
      body: json.encode({'id': orderId}),
    );
    if (response.statusCode == 201) {
      print('Successfully starting order ${response.body}');
      return true;
    } else {
      print('Failed to start order: ${response.body}');
      // Failed to create the car
    }
    return false;
  }

  Future<bool> endOrder(String orderId) async {
    final String apiUrl =
        "https://rescuecapstoneapi.azurewebsites.net/api/Order/EndOrder?id=$orderId";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        // Add other headers if needed, like authorization headers
      },
      body: json.encode({'id': orderId}),
    );
    if (response.statusCode == 201) {
      print('Successfully ending the order ${response.body}');
      return true;
    } else {
      print('Failed to end the order: ${response.body}');
      // Failed to create the car
    }
    return false;
  }

  Future<Map<String, Map<String, dynamic>>> fetchFeedbackRatings(
      String userId) async {
    final String apiUrl =
        "https://rescuecapstoneapi.azurewebsites.net/api/Feedback/GetFeedbacksOfRVO?id=$userId"; // Your API endpoint

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var feedbacks = jsonResponse['data']['feedbacks'] as List;

        Map<String, Map<String, dynamic>> feedbackData = {};

        for (var feedback in feedbacks) {
          String orderId = feedback['orderId'];
          int? rating = feedback['rating'];
          String? note = feedback['note'];

          feedbackData[orderId] = {'rating': rating, 'note': note};
        }

        return feedbackData;
      } else {
        print("Failed to fetch ratings. Status code: ${response.statusCode}");
        return {};
      }
    } catch (error) {
      print("Error fetching feedback ratings: $error");
      return {};
    }
  }

  Future<FeedbackData?> fetchFeedbackRatingCountofRVO(String userId) async {
    final String apiUrl =
        "https://rescuecapstoneapi.azurewebsites.net/api/Feedback/GetFeedbacksOfRVO?id=$userId"; // Replace with your API endpoint

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var dataField = jsonResponse['data'];
        FeedbackData feedbackData = FeedbackData.fromJson(dataField);
        print('Rating: ${feedbackData.rating}, Count: ${feedbackData.count}');
        return feedbackData;
      } else {
        print("Failed to fetch ratings. Status code: ${response.statusCode}");
        return null;
      }
    } catch (error) {
      print("Error fetching feedback ratings: $error");
      return null;
    }
  }

  Future<FeedbackData?> fetchFeedbackRatingCountofTech(String userId) async {
    final String apiUrl =
        "https://rescuecapstoneapi.azurewebsites.net/api/Feedback/GetFeedbacksOfTeachnician?id=$userId"; // Replace with your API endpoint

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var dataField = jsonResponse['data'];
        FeedbackData feedbackData = FeedbackData.fromJson(dataField);
        print('Rating: ${feedbackData.rating}, Count: ${feedbackData.count}');
        return feedbackData;
      } else {
        print("Failed to fetch ratings. Status code: ${response.statusCode}");
        return null;
      }
    } catch (error) {
      print("Error fetching feedback ratings: $error");
      return null;
    }
  }

  Future<List<String>> fetchImageUrls(String orderId) async {
    final String apiUrl =
        "https://rescuecapstoneapi.azurewebsites.net/api/Order/GetImagesOfOrder?id=$orderId";
    // Make the HTTP GET request to the API
    final response = await http.get(Uri.parse(apiUrl));

    // Check if the response is successful
    if (response.statusCode == 200) {
      // Parse the JSON response
      final jsonResponse = json.decode(response.body);

      // Check if the 'status' is 'Success' and there's data
      if (jsonResponse['status'] == 'Success' && jsonResponse['data'] != null) {
        // Iterate over the data and collect all the URLs
        List<String> imageUrls = [];
        for (var item in jsonResponse['data']) {
          if (item['url'] != null) {
            imageUrls.add(item['url']);
          }
        }

        return imageUrls;
      } else {
        // Handle the case where there is no 'data' or status is not 'Success'
        throw Exception('Failed to load image URLs');
      }
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data from the API');
    }
  }
}
