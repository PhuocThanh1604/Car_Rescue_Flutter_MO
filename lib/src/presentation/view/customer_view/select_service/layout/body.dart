import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/presentation/view/customer_view/home/home_view.dart';
import 'package:flutter/material.dart';


class ServiceBody extends StatefulWidget {
  const ServiceBody({super.key});

  @override
  State<ServiceBody> createState() => _ServiceBodyState();
}

class _ServiceBodyState extends State<ServiceBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
          height: 400, // Độ cao của phần chứa loại dịch vụ
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Loại dịch vụ 1
              GestureDetector(
                onTap: () {
                 Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => HomeView(services: "Towing",)),
                );
                },
                child: Container(
                  width: 150, // Độ rộng của loại dịch vụ
                  height: 150, // Độ cao của loại dịch vụ
                  decoration: BoxDecoration(
                    color: Colors.white, // Màu nền trắng
                    borderRadius: BorderRadius.circular(8), // Bo góc
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
                      builder: (context) => HomeView(services: "Fixing",)),
                );
                },
                child: Container(
                  width: 150, // Độ rộng của loại dịch vụ
                  height: 150, // Độ cao của loại dịch vụ
                  decoration: BoxDecoration(
                    color: Colors.white, // Màu nền trắng
                    borderRadius: BorderRadius.circular(8), // Bo góc
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
      ],
    );
  }
}
