import 'package:flutter/material.dart';
import 'package:CarRescue/src/configuration/frontend_configs.dart';

class CustomText extends StatelessWidget {
<<<<<<< HEAD
  CustomText(
      {Key? key,
      required this.text,
      this.color,
      this.fontSize = 14,
      this.fontWeight = FontWeight.w400,
      this.letterSpacing})
      : super(key: key);
  String text;
  FontWeight fontWeight;
  double fontSize;
  Color? color = FrontendConfigs.kPrimaryColor;
  double? letterSpacing;
=======
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
>>>>>>> origin/MinhAndHieu6

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
<<<<<<< HEAD
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
          letterSpacing: letterSpacing),
=======
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color ?? FrontendConfigs.kAuthColor,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
      ),
      maxLines: 2, // Set the maximum number of lines to 2
      overflow: TextOverflow.ellipsis,
>>>>>>> origin/MinhAndHieu6
    );
  }
}
