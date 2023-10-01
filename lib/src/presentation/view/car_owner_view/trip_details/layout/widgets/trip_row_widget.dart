import 'package:flutter/material.dart';
import 'package:gillar/src/presentation/elements/custom_text.dart';

class TripRowWidget extends StatelessWidget {
  const TripRowWidget({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:MainAxisAlignment.spaceBetween,
      children: [
        CustomText(text: title,fontSize:16,fontWeight:FontWeight.w300,),
        CustomText(text: value,fontSize:16,fontWeight:FontWeight.w600,),
      ],
    );
  }
}
