import 'package:flutter/material.dart';
import 'package:CarRescue/src/configuration/frontend_configs.dart';

class CustomText extends StatelessWidget {
  CustomText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.letterSpacing,
    this.fontFamily, // Add fontFamily parameter
  }) : super(key: key);

  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color? color;
  final double? letterSpacing;
  final String? fontFamily; // Define fontFamily parameter

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(

        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color ??
            FrontendConfigs.kPrimaryColor, // Use default color if color is null
        letterSpacing: letterSpacing,
        fontFamily: fontFamily, // Set fontFamily
      ),
      maxLines: 10,

    );
  }
}
