import 'package:flutter/material.dart';
import 'package:gillar/src/presentation/elements/custom_appbar.dart';
import 'layout/body.dart';
class NumberVerificationView extends StatelessWidget {
  const NumberVerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:customAppBar(context),
      body:const NumberVerificationBody(),
    );
  }
}
