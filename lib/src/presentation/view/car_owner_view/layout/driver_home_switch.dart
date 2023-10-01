import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gillar/src/configuration/frontend_configs.dart';

import '../../../elements/custom_text.dart';

class SwitchWidget extends StatefulWidget {
   SwitchWidget({Key? key,required this.onPressed}) : super(key: key);
   VoidCallback onPressed;
  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool _switchValue=false;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18.0,left:18,top:34),
      child: Card(
        elevation:2,
        shape:OutlineInputBorder(borderRadius:BorderRadius.circular(6),borderSide:BorderSide.none),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              IconButton(
                  onPressed:widget.onPressed,
                  icon: SvgPicture.asset('assets/svg/drawer_icon.svg')),
              CustomText(text: "Online",fontWeight:FontWeight.w600,),
              Transform.scale(
                scale: 0.6,
                transformHitTests: false,
                child: CupertinoSwitch(
                    activeColor:Color(0xff2DBB54),
                    trackColor:FrontendConfigs.kIconColor,
                    value:_switchValue,
                    onChanged: (value) {
                      setState(() {
                        _switchValue = value;
                      });
                    }),
              ),
            ]),
          )),
    )
    ;
  }
}
