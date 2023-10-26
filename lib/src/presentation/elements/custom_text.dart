import 'package:flutter/material.dart';
import 'package:CarRescue/src/configuration/frontend_configs.dart';

class CustomText extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
<<<<<<< Updated upstream
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
          letterSpacing: letterSpacing),
=======
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color ??
            FrontendConfigs.kIconColor, // Use default color if color is null
        letterSpacing: letterSpacing,
        fontFamily: fontFamily, // Set fontFamily
      ),
>>>>>>> Stashed changes
    );
  }
}
