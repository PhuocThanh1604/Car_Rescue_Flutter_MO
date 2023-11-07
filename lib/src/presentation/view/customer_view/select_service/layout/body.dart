import 'package:CarRescue/src/configuration/show_toast_notify.dart';
import 'package:CarRescue/src/presentation/elements/booking_status.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';
import 'package:CarRescue/src/presentation/view/customer_view/chat_with_driver/chat_view.dart';
import 'package:CarRescue/src/presentation/view/customer_view/select_service/widget/selection_location_widget.dart';
import 'package:dotted_line/dotted_line.dart';
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
import 'package:CarRescue/src/providers/google_map_provider.dart';

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

  Future<String> getPlaceDetails(String latLng) async {
    try {
      final locationProvider = LocationProvider();
      String address = await locationProvider.getAddressDetail(latLng);
      // Sau khi có được địa chỉ, bạn có thể xử lý nó tùy ý ở đây
      print("Địa chỉ từ tọa độ: $address");
      return address;
    } catch (e) {
      // Xử lý lỗi nếu có
      print("Lỗi khi lấy địa chỉ: $e");
      return "Không tìm thấy";
    }
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
                        String formattedStartTime =
                            DateFormat('dd/MM/yyyy | HH:mm')
                                .format(order.createdAt ?? DateTime.now());

                        return Card(
                            child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color.fromARGB(86, 115, 115, 115),
                                    width: 2.0,
                                  ),
                                  color: Color.fromARGB(0, 255, 255, 255),
                                ),
                                child: CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(115, 47, 47, 47),
                                  backgroundImage: AssetImage(
                                      'assets/images/logocarescue.png'),
                                  radius: 20,
                                ),
                              ),
                              title: CustomText(
                                text: formattedStartTime,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              subtitle: Text(order.rescueType!),
                              trailing: BookingStatus(
                                  status: order
                                      .status), // Use the BookingStatusWidget here
                            ),
                            Divider(
                              color: FrontendConfigs.kIconColor,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/svg/location_icon.svg",
                                              color: FrontendConfigs
                                                  .kPrimaryColor),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          CustomText(
                                            text: "6.5 km",
                                            fontWeight: FontWeight.w600,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/svg/watch_icon.svg"),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          CustomText(
                                            text: "15 mins",
                                            fontWeight: FontWeight.w600,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/svg/wallet_icon.svg",
                                            color:
                                                FrontendConfigs.kPrimaryColor,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          CustomText(
                                            text: "\$56.00",
                                            fontWeight: FontWeight.w600,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: FrontendConfigs.kIconColor,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                FutureBuilder<String>(
                                  future: getPlaceDetails(order.departure!),
                                  builder: (context, addressSnapshot) {
                                    if (addressSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      // Display loading indicator or placeholder text
                                      return CircularProgressIndicator();
                                    } else if (addressSnapshot.hasError) {
                                      // Handle error
                                      return Text(
                                          'Error: ${addressSnapshot.error}');
                                    } else {
                                      String departureAddress =
                                          addressSnapshot.data ?? '';
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: RideSelectionWidget(
                                          icon: 'assets/svg/pickup_icon.svg',
                                          title:
                                              "Địa điểm hiện tại", // Add your title here
                                          body: departureAddress,
                                          onPressed: () {},
                                        ),
                                      );
                                    }
                                  },
                                ),
                                if(order.destination != '')
                                const Padding(
                                  padding: EdgeInsets.only(left: 29),
                                  child: DottedLine(
                                    direction: Axis.vertical,
                                    lineLength: 30,
                                    lineThickness: 1.0,
                                    dashLength: 4.0,
                                    dashColor: Colors.black,
                                    dashRadius: 2.0,
                                    dashGapLength: 4.0,
                                    dashGapRadius: 0.0,
                                  ),
                                ),
                                if(order.destination != '')
                                FutureBuilder<String>(
                                  future: getPlaceDetails(order.destination!),
                                  builder: (context, addressSnapshot) {
                                    if (addressSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      // Display loading indicator or placeholder text
                                      return CircularProgressIndicator();
                                    } else if (addressSnapshot.hasError) {
                                      // Handle error
                                      return Text(
                                          'Error: ${addressSnapshot.error}');
                                    } else {
                                      String destinationAddress =
                                          addressSnapshot.data ?? '';
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: RideSelectionWidget(
                                          icon: 'assets/svg/location_icon.svg',
                                          title: "Địa điểm muốn đến",
                                          body: destinationAddress,
                                          onPressed: () {},
                                        ),
                                      );
                                    }
                                  },
                                ),
                                ButtonBar(
                                  children: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ChatView(),
                                          ),
                                        );
                                      },
                                      child: CustomText(
                                        text: 'Chi tiết',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
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
                                backgroundColor: FrontendConfigs.kActiveColor,
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
                        ));
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
