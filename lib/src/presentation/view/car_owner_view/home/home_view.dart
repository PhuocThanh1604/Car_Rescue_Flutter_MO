import 'package:flutter/material.dart';
import 'package:gillar/src/presentation/view/car_owner_view/home/layout/body.dart';

import 'drawer_view.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();
class DriverHomeView extends StatelessWidget {
   DriverHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: scaffoldKey,
      body:DriverHomeBody(),
      drawer:const DrawerView(),
    );
  }
}
