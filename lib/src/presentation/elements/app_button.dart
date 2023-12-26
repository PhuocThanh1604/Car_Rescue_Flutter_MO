<<<<<<< HEAD
import 'package:flutter/material.dart';

import '../../configuration/frontend_configs.dart';

=======
import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
>>>>>>> origin/MinhAndHieu6
class AppButton extends StatelessWidget {
  VoidCallback onPressed;
  String btnLabel;
  double width;
  double height;
<<<<<<< HEAD
  Color ?color;
  bool showIcon;
  Color ?borderColor;
=======
  Color? color;
  bool showIcon;
  Color? borderColor;
>>>>>>> origin/MinhAndHieu6

  AppButton(
      {required this.onPressed,
      required this.btnLabel,
      this.showIcon = false,
<<<<<<< HEAD
      this.color  ,
      this.width = double.infinity,
        this.borderColor=Colors.green,
=======
      this.color,
      this.width = double.infinity,
      this.borderColor = const Color(0xffE0AC69),
>>>>>>> origin/MinhAndHieu6
      this.height = 51});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
<<<<<<< HEAD
          primary: const Color(0xFF2DBB54),
=======
          primary: FrontendConfigs.kIconColor,
>>>>>>> origin/MinhAndHieu6
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
<<<<<<< HEAD
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 14,
=======
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
>>>>>>> origin/MinhAndHieu6
            ),
          ),
        ],
      ),
    );
  }
}
