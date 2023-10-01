import 'package:flutter/material.dart';
import 'package:CarRescue/src/configuration/frontend_configs.dart';

class RegistrationFieldWidget extends StatelessWidget {
  RegistrationFieldWidget(
      {Key? key,
      required this.controller,
      required this.keyBoardType,
      required this.text})
      : super(key: key);
  TextInputType keyBoardType;
  String text;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 49,
      child: TextFormField(
        keyboardType: keyBoardType,
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(
              color: FrontendConfigs.kIconColor,
              fontSize: 14,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none),
          fillColor: FrontendConfigs.kAuthColor,
          filled: true,
        ),
      ),
    );
  }
}
