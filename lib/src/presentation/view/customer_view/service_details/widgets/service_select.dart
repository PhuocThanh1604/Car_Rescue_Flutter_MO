import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/presentation/elements/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:CarRescue/src/models/service.dart';
import 'package:CarRescue/src/providers/service_provider.dart';
import 'package:intl/intl.dart';

class ServiceSelectionPage extends StatefulWidget {
  @override
  State<ServiceSelectionPage> createState() => _ServiceSelectionPageState();
}

class _ServiceSelectionPageState extends State<ServiceSelectionPage> {
  Future<List<Service>>? availableServices;

  @override
  void initState() {
    availableServices = loadService();
    super.initState();
  }

  Future<List<Service>> loadService() async {
    final serviceProvider = ServiceProvider();
    try {
      return serviceProvider.getAllServicesTowing();
    } catch (e) {
      print('Lỗi khi tải danh sách dịch vụ: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FrontendConfigs.kBackgrColor,
      appBar: customAppBar(context, text: 'Chọn dịch vụ', showText: true),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Service>>(
              future: availableServices,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Không có dữ liệu.'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ServiceCard(service: snapshot.data![index]);
                    },
                  );
                }
              },
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 10),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // Đặt cột để không chiếm quá nhiều không gian
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng cộng:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '0₫', // Số tiền tổng cộng, cần được tính toán hoặc lấy từ state
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20), // Khoảng cách giữa tổng cộng tiền và nút
                SizedBox(
                  width: double.infinity, // Đặt chiều rộng bằng với Container
                  height: 50, // Đặt chiều cao cố định cho nút
                  child: ElevatedButton(
                    child: Text(
                      'Tiếp tục',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: FrontendConfigs
                          .kIconColor, // Đảm bảo rằng màu này được định nghĩa trong FrontendConfigs
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Góc bo tròn cho nút
                      ),
                    ),
                    onPressed: () {
                      // Thực hiện hành động khi nút Continue được nhấn
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final Service service;

  const ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat('#,##0₫', 'vi_VN');
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(64, 158, 158, 158).withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: ListTile(
          leading:
              Icon(Icons.auto_fix_high_rounded), // Replace with actual icon
          title: Text(
            service.name,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          trailing: Text(
            currencyFormat.format(service.price),
            style: TextStyle(
                color: FrontendConfigs.kActiveColor,
                fontWeight: FontWeight.w600),
          ),
          onTap: () {
            // Handle tap event
          },
        ),
      ),
    );
  }
}
