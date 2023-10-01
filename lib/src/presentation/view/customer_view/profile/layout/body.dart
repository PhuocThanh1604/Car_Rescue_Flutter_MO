import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gillar/src/presentation/elements/custom_text.dart';

import '../../../../../configuration/frontend_configs.dart';
import 'row_widget.dart';

class ProfileBody extends StatefulWidget {
  ProfileBody({Key? key}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final Color redColor = const Color(0xffFF455B);

  bool isFirstSelected = false;

  bool isSecondSelected = false;

  bool isThirdSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 37,
                      child: Padding(
                        padding: const EdgeInsets.all(0.20),
                        child: Image.asset(
                          "assets/images/profile.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    CustomText(
                      text: "Andrew Johns",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    CustomText(
                      text: '+1 343-234-4544',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SettingWidget(
              icon: "assets/svg/user.svg",
              title: "John_wick",
              name: 'Edit profile',
              onTap: () {},
            ),
            const SizedBox(
              height: 24,
            ),
            SettingWidget(
              icon: "assets/svg/notification_icon.svg",
              title: "+966 1114141",
              name: 'Notification',
              onTap: () {},
            ),
            const SizedBox(
              height: 24,
            ),
            SettingWidget(
              icon: "assets/svg/wallet_icon.svg",
              title: "Payment",
              name: 'Payment',
              height: 16,
              weight: 16,
              onTap: () {},
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SettingWidget(
                    icon: "assets/svg/language.svg",
                    title: "",
                    name: 'Language',
                    isShow: true,
                    onTap: () {},
                  ),
                  Row(
                    children: const [
                      Text("English (US)",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                      SizedBox(
                        width: 3,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            SettingWidget(
              icon: "assets/svg/privacy.svg",
              title: "John_wick",
              name: 'Privacy Policy',
              onTap: () {},
            ),
            const SizedBox(
              height: 24,
            ),
            SettingWidget(
              icon: "assets/svg/help_center.svg",
              title: "",
              name: 'Help Center',
              onTap: () {},
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg/exit.svg",
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Text(
                    "Log out",
                    style: TextStyle(
                        color: redColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
