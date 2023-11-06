import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/models/customer.dart';
import 'package:CarRescue/src/models/order.dart';
import 'package:CarRescue/src/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  String selectedStatus = "Assigned";
  Customer customer = Customer.fromJson(GetStorage().read('customer') ?? {});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              child: TabBar(
                indicatorColor: FrontendConfigs.kPrimaryColor,
                tabs: [
                  Tab(
                    child: Center(
                      child: Text(
                        'Sữa chữa tại chỗ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Center(
                      child: Text(
                        'Kéo xe',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: FrontendConfigs.kBackgrColor,
                child: TabBarView(
                  children: [
                    _buildTabView('Fixing'),
                    _buildTabView('Towing'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabView(String type) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildFilterButton('ASSIGNING', Colors.blue),
            _buildFilterButton('COMPLETED', Colors.green),
            _buildFilterButton('CANCELLED', Colors.red),
          ],
        ),
        FutureBuilder<List<Order>>(
          future: getAllOrders(selectedStatus, type),
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
                      title: Text("Mã đơn hàng: ${order.id}"),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildFilterButton(String type, Color textColor) {
    String translatedText = type; 

  if (type == 'ASSIGNING') {
    translatedText = 'Đã duyệt';
  } else if (type == 'COMPLETED') {
    translatedText = 'Hoàn Thành';
  } else if (type == 'CANCELLED') {
    translatedText = 'Đã hủy';
  }
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(textColor),
      ),
      onPressed: () {
        setState(() {
          selectedStatus = type;
        });
      },
      child: Text(
        translatedText,
      ),
    );
  }

//   Widget _buildStatusDropdown(String status, String type, bool isExpanded) {
//   return Container(
//     height: 200,
//     child: SingleChildScrollView(
//       child: ExpansionTile(
//         title: Text('Danh sách đơn hàng $type - $status'),
//         initiallyExpanded: isExpanded,
//         onExpansionChanged: (expanded) {
//           // Track the expansion state
//           if (status == 'CANCELLED') {
//             setState(() {
//               _cancelPanelExpanded = expanded;
//             });
//           } else if (status == 'COMPLETED') {
//             setState(() {
//               _completePanelExpanded = expanded;
//             });
//           } else if (status == 'ASSIGNING') {
//             setState(() {
//               _assignedPanelExpanded = expanded;
//             });
//           }
//         },
//         children: [
//           FutureBuilder<List<Order>>(
//             future: getAllOrders(status, type),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else {
//                 final orders = snapshot.data ?? [];
//                 return Column(
//                   children: orders.map((order) {
//                     return Card(
//                       child: ListTile(
//                         title: Text(order.status),
//                       ),
//                     );
//                   }).toList(),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     ),
//   );
// }

  Future<List<Order>> getAllOrders(String status, String type) async {
    final orderProvider = OrderProvider();
    print("Status: $status");
    try {
      final orders = await orderProvider.getAllOrders(customer.id);
      final filteredOrders = orders
          .where((order) => order.status == status && order.rescueType == type)
          .toList();
      return filteredOrders;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
