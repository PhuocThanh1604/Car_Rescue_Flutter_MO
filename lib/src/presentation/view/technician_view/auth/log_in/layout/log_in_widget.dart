import 'package:flutter/material.dart';

class LogInWidget extends StatelessWidget {
  const LogInWidget({Key? key, required this.logo}) : super(key: key);
  final String logo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:61,
      width:98,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xff9B9B9B),width:0.2),),
      child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
        logo,
      ),
          )),
    );
  }
}
