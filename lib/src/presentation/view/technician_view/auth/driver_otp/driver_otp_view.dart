import 'package:flutter/material.dart';

import '../../../../elements/custom_appbar.dart';
import 'layout/body.dart';

class DriverOTPView extends StatelessWidget {
  const DriverOTPView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:customAppBar(context),
      body:DriverOTPBody(),
    );
  }
}
