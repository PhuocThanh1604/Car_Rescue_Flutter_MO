import 'package:CarRescue/src/configuration/show_toast_notify.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/models/customer.dart';
import 'package:CarRescue/src/models/order.dart';
import 'package:CarRescue/src/presentation/view/customer_view/home/home_view.dart';
import 'package:CarRescue/src/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:slider_button/slider_button.dart';

class ServiceBody extends StatefulWidget {
  const ServiceBody({super.key});

  @override
  State<ServiceBody> createState() => _ServiceBodyState();
}

class _ServiceBodyState extends State<ServiceBody> {
  Customer customer = Customer.fromJson(GetStorage().read('customer') ?? {});
  NotifyMessage notifyMessage = NotifyMessage();
  TextEditingController _reasonCacelController = TextEditingController();
  bool isConfirmed = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getAllOrders("NEW");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: FrontendConfigs.kAuthColor,
            ),
            child: Center(
              child: Image.asset(
                'assets/images/repairr.png',
                fit: BoxFit
                    .fill, // Đặt để hình ảnh có chiều rộng đầy đủ // Màu của hình ảnh
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Phần tiêu đề "Chọn dịch vụ"
          Container(
            height: 30, // Độ cao của phần tiêu đề
            alignment: Alignment.center,
            child: Text(
              'Chọn dịch vụ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Màu tiêu đề
              ),
            ),
          ),
          // Phần chứa hai loại dịch vụ
          Container(
            height: 200, // Độ cao của phần chứa loại dịch vụ
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Loại dịch vụ 1
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => HomeView(
                                services: "Towing",
                              )),
                    );
                  },
                  child: Container(
                    width: 150, // Độ rộng của loại dịch vụ
                    height: 150, // Độ cao của loại dịch vụ
                    decoration: BoxDecoration(
                      color: Colors.white, // Màu nền trắng
                      borderRadius: BorderRadius.circular(15), // Bo góc
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey
                              .withOpacity(0.5), // Màu đổ bóng và độ mờ
                          spreadRadius: 5, // Kích thước đổ bóng
                          blurRadius: 7, // Độ mờ đổ bóng
                          offset: Offset(
                              0, 3), // Vị trí đổ bóng (thay đổi theo cần)
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.directions_car,
                          size: 48,
                          color: Colors.green, // Màu biểu tượng
                        ),
                        Text(
                          'Kéo xe',
                          style: TextStyle(
                            color: Colors.black, // Màu văn bản
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Loại dịch vụ 2

                GestureDetector(
                  onTap: () {
                    //  Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(
                    //       builder: (context) => HomeView(services: "repair",)),
                    // );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => HomeView(
                                services: "Fixing",
                              )),
                    );
                  },
                  child: Container(
                    width: 150, // Độ rộng của loại dịch vụ
                    height: 150, // Độ cao của loại dịch vụ
                    decoration: BoxDecoration(
                      color: Colors.white, // Màu nền trắng
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey
                              .withOpacity(0.5), // Màu đổ bóng và độ mờ
                          spreadRadius: 5, // Kích thước đổ bóng
                          blurRadius: 7, // Độ mờ đổ bóng
                          offset: Offset(
                              0, 3), // Vị trí đổ bóng (thay đổi theo cần)
                        ),
                      ], // Bo góc
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.build,
                          size: 48,
                          color: Colors.green, // Màu biểu tượng
                        ),
                        Text(
                          'Sửa chữa',
                          style: TextStyle(
                            color: Colors.black, // Màu văn bản
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 30, // Độ cao của phần tiêu đề
            alignment: Alignment.center,
            child: Text(
              'Đơn đang chờ xét duyệt',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Màu tiêu đề
              ),
            ),
          ),
          Container(
            height: 300,
            child: SingleChildScrollView(
              child: FutureBuilder<List<Order>>(
                future: getAllOrders("NEW"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final orders = snapshot.data ?? [];

                    return Column(
                      children: orders.map((order) {
                        return Card(
                          child: ListTile(
                            title: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Hình ảnh ở đầu
                                    Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: Image.asset(
                                        'assets/images/logo-color.png',
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit
                                            .cover, // Optional, you can adjust the BoxFit as needed
                                      ),
                                    ),
                                    // ListTile (nội dung)
                                    Expanded(
                                      child: ListTile(
                                        title: Text("Ngày: ${order.createdAt}"),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  child: SliderButton(
                                    alignLabel: Alignment.center,
                                    shimmer: true,
                                    baseColor: Colors.white,
                                    buttonSize: 45,
                                    height: 60,
                                    backgroundColor:
                                        FrontendConfigs.kActiveColor,
                                    action: () {
                                      showCancelOrderDialog(context, order.id);
                                    },
                                    label: const Text(
                                      "Hủy đơn",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    icon: SvgPicture.asset(
                                        "assets/svg/cancel_icon.svg"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showCancelOrderDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hủy đơn"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Bạn có chắc muốn hủy đơn không?"),
                TextFormField(
                  controller: _reasonCacelController,
                  decoration: InputDecoration(labelText: "Lý do hủy đơn"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lý do hủy đơn không được để trống';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Hủy"),
              onPressed: () {
                setState(() {
                  _reasonCacelController.clear();
                  getAllOrders("NEW");
                });
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
            ),
            TextButton(
              child: Text("Xác nhận"),
              onPressed: () {
                // Kiểm tra hợp lệ của form
                if (_formKey.currentState!.validate()) {
                  // Ở đây bạn có thể xử lý hành động hủy đơn
                  cancelOrder(id, _reasonCacelController.text).then((success) {
                    if (success) {
                      notifyMessage.showToast("Đã hủy đơn");
                      // Sau khi hủy đơn, cập nhật lại danh sách đơn
                      setState(() {
                        getAllOrders("NEW");
                      });
                    } else {
                      notifyMessage.showToast("Hủy đơn lỗi");
                    }
                  });
                  _reasonCacelController.clear();
                  Navigator.of(context).pop(); // Đóng hộp thoại
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> cancelOrder(String orderID, String cancellationReason) async {
    try {
      final orderProvider =
          await OrderProvider().cancelOrder(orderID, cancellationReason);
      if (orderProvider) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      notifyMessage.showToast("Huỷ đơn lỗi.");
      return false;
    }
  }

  Future<List<Order>> getAllOrders(String status) async {
    final orderProvider = OrderProvider();
    print("Status: $status");
    try {
      final orders = await orderProvider.getAllOrders(customer.id);
      final filteredOrders =
          orders.where((order) => order.status == status).toList();
      return filteredOrders;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
