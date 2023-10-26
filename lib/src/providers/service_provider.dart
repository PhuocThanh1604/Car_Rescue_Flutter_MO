import 'dart:convert' as convert;
import 'package:CarRescue/src/enviroment/env.dart';
import 'package:CarRescue/src/models/service.dart';
import 'package:http/http.dart' as http;
import 'package:CarRescue/src/models/order_booking.dart';

class ServiceProvider {
  final String apiUrl = Environment.API_GETALL_SERVICE_CUSTOMER;

  Future<List<Service>> getAllServices() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = convert.jsonDecode(response.body);
        final List<dynamic> serviceList = data['data'] as List<dynamic>;

        List<Service> services = serviceList
            .map((serviceData) => Service.fromJson(serviceData))
            .toList();

        return services;
      } else {
        throw Exception('Failed to load services');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
