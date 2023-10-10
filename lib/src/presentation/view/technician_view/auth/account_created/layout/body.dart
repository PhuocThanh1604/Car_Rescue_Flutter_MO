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
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/svg/driver_account.svg"),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Thành Công",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Chào mừng bạn đến với hệ thống của chúng tôi! \n",
                  style: TextStyle(
                      color: FrontendConfigs.kPrimaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      height: 1.5),
                )),
          ],
        ),
      ),
    );
  }
}
