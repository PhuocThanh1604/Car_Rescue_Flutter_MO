import 'package:flutter/material.dart';

class LogInWidget extends StatelessWidget {
  LogInWidget({Key? key, required this.logo, required this.onPressed}) : super(key: key);
  final String logo;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 61,
        width: 98,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xff9B9B9B), width: 0.2),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              logo,
            ),
          ),
        ),
      ),
    );
  }
}
