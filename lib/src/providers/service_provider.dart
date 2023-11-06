import 'dart:convert' as convert;
import 'package:CarRescue/src/enviroment/env.dart';
import 'package:CarRescue/src/models/service.dart';
import 'package:http/http.dart' as http;
import 'package:CarRescue/src/models/order_booking.dart';

class ServiceProvider {
  final String apiUrl = Environment.API_URL + 'api/Service/GetAll';

  Future<List<Service>> getAllServicesFixing() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = convert.jsonDecode(response.body);
        final List<dynamic> serviceList = data['data'] as List<dynamic>;

        List<Service> services = serviceList
            .map((serviceData) => Service.fromJson(serviceData))
            .toList();

        List<Service> towingServices = services.where((service) => service.type == "Fixing").toList();

        return towingServices;
      } else {
        throw Exception('Failed to load services');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Service>> getAllServicesTowing() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = convert.jsonDecode(response.body);
        final List<dynamic> serviceList = data['data'] as List<dynamic>;

        List<Service> services = serviceList
            .map((serviceData) => Service.fromJson(serviceData))
            .toList();

        List<Service> towingServices = services.where((service) => service.type == "Towing").toList();

        return towingServices;
      } else {
        throw Exception('Failed to load services');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
