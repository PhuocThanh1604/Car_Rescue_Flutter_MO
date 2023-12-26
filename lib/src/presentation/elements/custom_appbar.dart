<<<<<<< HEAD
import 'package:flutter/material.dart';
import '../../configuration/frontend_configs.dart';
=======
import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:flutter/material.dart';

>>>>>>> origin/MinhAndHieu6
customAppBar(
  BuildContext context, {
  String? text,
  bool showText = false,
}) {
  return AppBar(
    centerTitle: true,
<<<<<<< HEAD
    leading:
    IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size:20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
=======
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
        size: 20,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
>>>>>>> origin/MinhAndHieu6
    title: showText
        ? Text(
            text!,
            style: TextStyle(
<<<<<<< HEAD
                color:FrontendConfigs.kPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600),
=======
                color: FrontendConfigs.kPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
>>>>>>> origin/MinhAndHieu6
          )
        : const SizedBox(),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
