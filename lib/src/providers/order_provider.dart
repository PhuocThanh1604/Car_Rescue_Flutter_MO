import 'dart:convert' as convert;
import 'package:CarRescue/src/enviroment/env.dart';
import 'package:CarRescue/src/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:CarRescue/src/models/order_booking.dart';

class OrderProvider {
  final String apiUrlCreateFixing =
      Environment.API_URL + 'api/Order/CreateFixingOrderForCustomer';
  final String apiUrlCreateTowing =
      Environment.API_URL + 'api/Order/CreateTowingOrderForCustomer';
  final String apiUrlGetAll =
      Environment.API_URL + 'api/Order/GetOrdersOfCustomer';
  final String apiUrlGetAllOfCustomer =
      Environment.API_URL + 'api/Order/GetOrdersOfCustomer';
  final String apiUrlCancelOrder =
      Environment.API_URL + '/api/Order/CustomerCancelOrder';    

  Future<int?> createOrderFixing(OrderBookServiceFixing order) async {
    try {
      final String orderJson = convert.jsonEncode(order.toJson());

      // Thực hiện cuộc gọi POST bằng thư viện http
      final response = await http.post(
        Uri.parse(apiUrlCreateFixing),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: orderJson,
      );

      if (response.statusCode == 200) {
        print('Đơn hàng đã được tạo thành công');
        return response.statusCode;
      } else if (response.statusCode == 500) {
        print('External Error');
        return response.statusCode;
      } else {
        print('Đã xảy ra lỗi khi tạo đơn hàng. Mã lỗi: ${response.statusCode}');
        print('Đã xảy ra lỗi khi tạo đơn hàng. Body: ${response.body}');
        return response.statusCode;
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> cancelOrder(String orderID, String cancellationReason) async {

  final Map<String, dynamic> requestBody = {
    "orderID": orderID,
    "cancellationReason": cancellationReason,
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrlCancelOrder),
      headers: {
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(requestBody),
    );
    print("Body: ${response.body}");
    if (response.statusCode == 201) {
      print('Đã hủy đơn hàng thành công');
      return true;
    } else {
      print('Lỗi khi hủy đơn hàng: ${response.body}');
      return false;
    }
  } catch (e) {
    print('Lỗi khi gửi yêu cầu hủy đơn hàng: $e');
    return false;
  }
}

  Future<int?> createOrderTowing(OrderBookServiceTowing order) async {
    try{
      final String orderJson = convert.jsonEncode(order.toJson());

    // Thực hiện cuộc gọi POST bằng thư viện http
    final response = await http.post(
      Uri.parse(apiUrlCreateTowing),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: orderJson,
    );

    if (response.statusCode == 200) {
      print('Đơn hàng đã được tạo thành công');
      return response.statusCode;
    } else if (response.statusCode == 500) {
      print('External Error');
      return response.statusCode;
    } else if(response.statusCode == 201){
      return response.statusCode;
    }else{
      throw Exception('Create failed');
    }
    }catch(e){
      throw Exception('Error: $e');
    }
  }

  Future<List<Order>> getAllOrders(String id) async {
  try {
    final response = await http.get(Uri.parse("${apiUrlGetAllOfCustomer}?id=${id}"));
    if (response.statusCode == 200) {
      final dynamic data =  convert.json.decode(response.body);

      if (data != null && data['data'] != null) {
        final List<dynamic> orderData = data['data'];
        List<Order> orders = orderData.map((data) => Order.fromJson(data)).toList();
        return orders;
      } else {
        // Handle empty or invalid response
        throw Exception('Empty or invalid response data');
      }

    } else {
      throw Exception('Failed to load orders');
    }
  } catch (e) {
    // Handle other exceptions or errors
    print('Error: $e');
    throw e;
  }
}
}
