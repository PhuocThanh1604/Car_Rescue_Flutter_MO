import 'package:CarRescue/src/presentation/view/car_owner_view/homepage/layout/body.dart';
import 'package:flutter/material.dart';

class CarOwnerHomeView extends StatefulWidget {
  final String fullname;
  final String userId;
  final String accountId;
  final String avatar;
  CarOwnerHomeView(
      {Key? key,
      required this.fullname,
      required this.userId,
      required this.accountId,
      required this.avatar})
      : super(key: key);

  @override
  State<CarOwnerHomeView> createState() => _CarOwnerHomeViewState();
}

class _CarOwnerHomeViewState extends State<CarOwnerHomeView> {
  Future<bool> _onWillPop(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Cảnh báo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text('Bạn có chắc chắn muốn đăng xuất?',
            style: TextStyle(fontSize: 16)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Huỷ',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () {
              // Perform logout action here
              Navigator.of(context).pop(true);
            },
            child: Text(
              'Đồng ý',
              style: TextStyle(
                  color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: _handleRefresh, // Call setState to reload the screen

          child: SingleChildScrollView(
            child: Container(
              child: CarOwnerHomePageBody(
                userId: widget.userId,
                fullname: widget.fullname,
                avatar: widget.avatar,
                accountId: widget.accountId,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    // Call setState to reload the screen or perform other refresh logic
    setState(() {});
    // Wait for a short delay to simulate network refresh
    await Future.delayed(Duration(seconds: 2));
  }
}
