import 'package:flutter/material.dart';

import '../../configuration/frontend_configs.dart';

class AppButton extends StatelessWidget {
  VoidCallback onPressed;
  String btnLabel;
  double width;
  double height;
  Color ?color;
  bool showIcon;
  Color ?borderColor;

  AppButton(
      {required this.onPressed,
      required this.btnLabel,
      this.showIcon = false,
      this.color  ,
      this.width = double.infinity,
        this.borderColor=Colors.green,
      this.height = 51});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
<<<<<<< Updated upstream
          primary: const Color(0xFF2DBB54),
=======
          primary: Color(0xfff1cd00),
>>>>>>> Stashed changes
          fixedSize: Size(width, height),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor!),
            borderRadius: BorderRadius.circular(8),
          )),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            btnLabel,
            style: TextStyle(
              color: FrontendConfigs.kTextButton,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
