import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../configuration/frontend_configs.dart';
import '../../../../../elements/custom_text.dart';
class AccountCreatedBody extends StatelessWidget {
  const AccountCreatedBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:18.0),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/svg/driver_account.svg"),
            const SizedBox(height:18,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Account Created",
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                  letterSpacing:1.2,
                ),
              ],
            ),
            RichText(
                textAlign:TextAlign.center,
                text:  TextSpan(
                    text: "Your form has been submitted successfully. Approving \n",

                    style: TextStyle(
                        color: FrontendConfigs.kPrimaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        height:1.5
                    ),
                    children:   [
                      TextSpan(
                          text: " prcess usually takes us about 3 - 5 days  but we will do\n ",
                          style: TextStyle(
                            color: FrontendConfigs.kPrimaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            decoration:TextDecoration.none,
                          )),
                      TextSpan(
                          text: " our best to get back to you sooner.",
                          style: TextStyle(
                              color: FrontendConfigs.kPrimaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              decoration:TextDecoration.none
                          ))

                    ])),

          ],),
      ),
    );
  }
}
