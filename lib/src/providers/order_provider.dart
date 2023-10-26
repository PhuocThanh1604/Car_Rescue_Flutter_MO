import 'dart:convert' as convert;
import 'package:CarRescue/src/enviroment/env.dart';
import 'package:http/http.dart' as http;
import 'package:CarRescue/src/models/order_booking.dart';

class OrderProvider {
  final String apiUrl = Environment.API_CREATE_ORDER_CUSTOMER;

  Future<int?> createOrder(OrderBookService order) async {
    // Chuyển đối tượng Order thành định dạng JSON
    final String orderJson = convert.jsonEncode(order.toJson());

    // Thực hiện cuộc gọi POST bằng thư viện http
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: orderJson,
    );

    if (response.statusCode == 201) {
      print('Đơn hàng đã được tạo thành công');
      return response.statusCode;
    } else if (response.statusCode == 500) {
      print('External Error');
      return response.statusCode;
    } else {
      print('Đã xảy ra lỗi khi tạo đơn hàng. Mã lỗi: ${response.statusCode}');
      return response.statusCode;
    }
  }
}
