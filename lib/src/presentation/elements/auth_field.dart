import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:CarRescue/src/configuration/frontend_configs.dart';

<<<<<<< HEAD
=======
// ignore: must_be_immutable
>>>>>>> origin/MinhAndHieu6
class CustomTextField extends StatefulWidget {
  CustomTextField({
    Key? key,
    this.controller,
    required this.icon,
    required this.text,
    this.isSecure = true,
    this.isPassword = false,
    required this.onTap,
    required this.keyBoardType,
  }) : super(key: key);
  final String icon;
  final String text;
  bool isSecure;
  final TextInputType keyBoardType;

  bool isPassword;
  TextEditingController? controller;
<<<<<<< HEAD
  final VoidCallback onTap;
=======
  final Function onTap;
>>>>>>> origin/MinhAndHieu6

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 49,
      child: TextFormField(
        keyboardType: widget.keyBoardType,
        controller: widget.controller,
        obscureText: widget.isSecure,
        decoration: InputDecoration(
          hintText: widget.text,
          hintStyle: TextStyle(
<<<<<<< HEAD
              color: FrontendConfigs.kIconColor,
              fontSize: 14,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none),
          fillColor: FrontendConfigs.kAuthColor,
=======
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none),
          fillColor: FrontendConfigs.kIconColor,
>>>>>>> origin/MinhAndHieu6
          suffixIcon: widget.isPassword
              ? InkWell(
                  onTap: () {
                    setState(() {
                      widget.isSecure = !widget.isSecure;
                    });
                    return widget.onTap();
                  },
                  child: widget.isSecure
                      ? Icon(Icons.visibility_off_outlined,
<<<<<<< HEAD
                          color: FrontendConfigs.kIconColor, size: 20)
                      : Icon(
                          Icons.remove_red_eye_outlined,
                          color: FrontendConfigs.kIconColor,
=======
                          color: FrontendConfigs.kAuthColor, size: 20)
                      : Icon(
                          Icons.remove_red_eye_outlined,
                          color: FrontendConfigs.kAuthColor,
>>>>>>> origin/MinhAndHieu6
                          size: 20,
                        ))
              : null,
          filled: true,
          prefixIcon: Padding(
<<<<<<< HEAD
            padding: const EdgeInsets.all(15.0),
=======
            padding: const EdgeInsets.all(16.0), // Adjust the padding as needed
>>>>>>> origin/MinhAndHieu6
            child: SvgPicture.asset(
              widget.icon,
            ),
          ),
        ),
      ),
    );
  }
}
