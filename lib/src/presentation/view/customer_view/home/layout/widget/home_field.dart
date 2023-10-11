import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_place/google_place.dart';

// ignore: must_be_immutable
class HomeField extends StatefulWidget {
  HomeField({
    Key? key,
    required this.svg,
    required this.hint,
    required this.controller,
    required this.inputType,
    required this.onTextChanged,
  }) : super(key: key);

  final String svg;
  final String hint;
  TextInputType inputType;
  TextEditingController controller;
  final Function(String) onTextChanged;

  @override
  _HomeFieldState createState() => _HomeFieldState();
}

class _HomeFieldState extends State<HomeField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 49,
      child: TextFormField(
        keyboardType: widget.inputType,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: FrontendConfigs.kIconColor, // Đổi màu hint text
            fontSize: 14,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
          ),
          fillColor: FrontendConfigs.kAuthColor, // Đổi màu nền
          filled: true,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(widget.svg),
          ),
        ),
        onChanged: (value) {
          widget.onTextChanged(value); // Gọi hàm callback khi người dùng thay đổi văn bản
        },
      ),
      
    );
  }
}
