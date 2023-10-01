import 'package:flutter/material.dart';
import 'package:gillar/src/presentation/elements/custom_text.dart';
class DriverProfileWidget extends StatelessWidget {
  DriverProfileWidget({Key? key,required this.onTapped}) : super(key: key);
  VoidCallback onTapped;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTapped,
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 26,
                  child: Image.asset(
                    "assets/images/profile.png",
                    fit: BoxFit.fill,
                  )),
              const SizedBox(width:11,),
              Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Daniel Austin",
                    color: const Color(0xff3F3D56),
                    fontWeight:FontWeight.w600,
                  ),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment:CrossAxisAlignment.end,
            children: [
              CustomText(text: '\$15.00',fontSize:15,fontWeight:FontWeight.w600,),
              const SizedBox(height:3,),
              Row(
                children: [
                  CustomText(text: '10.3 km',fontSize:12,),
                  const SizedBox(width:3,),
                  CustomText(text: '14 min',fontSize:12),
                ],
              )
            ],)
        ],
      ),
    );
  }
}
