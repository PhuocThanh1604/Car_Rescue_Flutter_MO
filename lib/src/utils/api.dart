import 'dart:convert';
import 'dart:io';
import 'package:CarRescue/src/models/vehicle_item.dart';
import 'package:CarRescue/src/models/customer.dart';
import 'package:CarRescue/src/models/booking.dart';
import 'package:CarRescue/src/models/booking.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginResult {
  final String userId;
  final String accountId;
  final String fullname;
  final String avatar;
  LoginResult({
    required this.userId,
    required this.accountId,
    required this.fullname,
    required this.avatar,
  });
}

class AuthService {
  //TECHNICIAN API
  Future<LoginResult?> login(String email, String password) async {
    try {
      // Your existing login logic here
      final response = await http.post(
        Uri.parse(
            'https://rescuecapstoneapi.azurewebsites.net/api/Login/Login'),
        body: jsonEncode({'email': email, 'password': password}),
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
            final avatar = technician['avatar'];
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
            final userProfile = await fetchTechProfile(rescueVehicleOwnerId);

            if (userProfile != null) {
              // Now you have the user profile data
              print('PROFILE: $userProfile');
            } else {
              // Handle the case where profile fetching failed
            }

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

  Future<List<Booking>> fetchCarOwnerBookings(
      String userId, String excludedId) async {
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
              .where(
                  (json) => json['id'] != excludedId) // Exclude a specific ID
              .map((json) => Booking.fromJson(json))
              .toList();
          // for (var item in data) {
          //   item.forEach((key, value) {
          //     if (value == null) {
          //       print('Field "$key" is null for item with id: ${item['id']}');
          //     }
          //   });
          // }
          return bookings;
        } else {
          throw Exception('abc');
        }
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      throw Exception('Error fetching booking1s: $e');
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

  Future<void> getAddressesForBookings(
      List<Booking> bookings,
      void Function(VoidCallback) setState,
      Map<String, String> addressesDepart,
      Map<String, String> subAddressesDepart) async {
    for (Booking booking in bookings) {
      final String departure = booking.departure;

      // Extract latitude and longitude from the departure string
      final latMatch = RegExp(r'lat:\s?([\-0-9.]+)').firstMatch(departure);
      final longMatch = RegExp(r'long:\s?([\-0-9.]+)').firstMatch(departure);

      if (latMatch != null && longMatch != null) {
        final double? lat = double.tryParse(latMatch.group(1) ?? '');
        final double? long = double.tryParse(longMatch.group(1) ?? '');

        if (lat != null && long != null) {
          final addressInfo = await getAddressFromCoordinates(lat, long);
          setState(() {
            addressesDepart[booking.id] =
                addressInfo['address'] ?? 'Address not found';
            subAddressesDepart[booking.id] =
                addressInfo['subAddress'] ?? 'Subaddress not found';
          });
        }
      }
    }
  }

  Future<void> getDestiForBookings(
      List<Booking> bookings,
      void Function(VoidCallback) setState,
      Map<String, String> addressesDesti,
      Map<String, String> subAddressesDesti) async {
    for (Booking booking in bookings) {
      final String destination = booking.destination;

      // Extract latitude and longitude from the destination string
      final latMatch = RegExp(r'lat:\s?([\-0-9.]+)').firstMatch(destination);
      final longMatch = RegExp(r'long:\s?([\-0-9.]+)').firstMatch(destination);

      if (latMatch != null && longMatch != null) {
        final double? lat = double.tryParse(latMatch.group(1) ?? '');
        final double? long = double.tryParse(longMatch.group(1) ?? '');

        if (lat != null && long != null) {
          final addressInfo = await getAddressFromCoordinates(lat, long);
          setState(() {
            addressesDesti[booking.id] =
                addressInfo['address'] ?? 'Address not found';
            subAddressesDesti[booking.id] =
                addressInfo['subAddress'] ?? 'Subaddress not found';
          });
        }
      }
    }
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

  Future<String?> uploadImageToFirebase(File imageFile) async {
    try {
      // generate a unique id for the image
      String filename = DateTime.now().millisecondsSinceEpoch.toString();

      // upload the image
      final Reference storageReference =
          FirebaseStorage.instance.ref().child('profile_images/$filename');
      UploadTask uploadTask = storageReference.putFile(imageFile);

      // get the download URL
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> createCarApproval(
    String? id, {
    required String rvoid,
    required String licensePlate,
    required String manufacturer,
    required String status,
    required String vinNumber,
    required String type,
    required String color,
    required int manufacturingYear,
    required File carRegistrationFontImage,
    required File carRegistrationBackImage,
  }) async {
    var uuid = Uuid();
    id ??= uuid.v4();

    String? frontImageUrl =
        await uploadImageToFirebase(carRegistrationFontImage);
    String? backImageUrl =
        await uploadImageToFirebase(carRegistrationBackImage);

    if (frontImageUrl == null || backImageUrl == null) {
      // Hiển thị lỗi
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
        // Note: Handling image uploads would require a multipart request.
        // For simplicity, this example does not cover image uploads.
        // You might need a separate API or endpoint to handle the image upload.
      }),
    );
    final List userImage = [frontImageUrl, backImageUrl];
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
    } catch (e) {
      print('Failed to get FCM token: $e');
    }

    return token;
  }
}
