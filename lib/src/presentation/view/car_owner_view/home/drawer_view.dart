import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gillar/src/configuration/frontend_configs.dart';
import 'package:gillar/src/presentation/elements/custom_text.dart';
import 'package:gillar/src/presentation/view/car_owner_view/history/history_view.dart';
import 'package:gillar/src/presentation/view/car_owner_view/home/home_view.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Drawer(
        backgroundColor:Colors.white,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 43,
                      child: Image.asset("assets/images/profile.png"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      text: 'Daniel Austin',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      text: '+1 343-234-4544',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                )),
            SizedBox(
              height:40,
              child: ListTile(
                minLeadingWidth: 2,
                leading: SvgPicture.asset("assets/svg/home_icon.svg",height:20,width:20,),
                title: CustomText(
                  text: 'Home',
                  color: FrontendConfigs.kIconColor,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              height:40,
              child: ListTile(
                minLeadingWidth: 2,
                leading: SvgPicture.asset("assets/svg/person_icon.svg",height:18,width:18,),
                title: CustomText(
                  text: 'Profile',
                  color: FrontendConfigs.kIconColor,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              height:40,
              child: ListTile(
                minLeadingWidth: 2,
                leading: SvgPicture.asset(
                  "assets/svg/message.svg",
                  color: FrontendConfigs.kIconColor,
                  height: 20,
                  width: 20,
                ),
                title: CustomText(
                  text: 'Chat',
                  color: FrontendConfigs.kIconColor,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              height:40,
              child: ListTile(
                minLeadingWidth: 2,
                leading: SvgPicture.asset(
                  "assets/svg/wallet_icon.svg",
                  color: FrontendConfigs.kIconColor,
                  height: 16,
                  width: 16,
                ),
                title: CustomText(
                  text: 'Wallet',
                  color: FrontendConfigs.kIconColor,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              height:40,
              child: ListTile(
                minLeadingWidth: 2,
                leading: SvgPicture.asset(
                  "assets/svg/trip_history.svg",
                  color: FrontendConfigs.kIconColor,
                  height: 20,
                  width: 20,
                ),
                title: CustomText(
                  text: 'Trip History',
                  color: FrontendConfigs.kIconColor,
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const HistoryView()));
                },
              ),
            ),
            SizedBox(
              height:40,
              child: ListTile(
                minLeadingWidth: 2,
                leading: SvgPicture.asset(
                  "assets/svg/notification_icon.svg",
                  color: FrontendConfigs.kIconColor,
                  height: 20,
                  width: 20,
                ),
                title: CustomText(
                  text: 'Notification',
                  color: FrontendConfigs.kIconColor,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              height:40,
              child: ListTile(
                minLeadingWidth: 2,
                leading: SvgPicture.asset(
                  "assets/svg/language.svg",
                  color: FrontendConfigs.kIconColor,
                  height: 20,
                  width: 20,
                ),
                title: CustomText(
                  text: 'Language',
                  color: FrontendConfigs.kIconColor,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              height:40,
              child: ListTile(
                minLeadingWidth: 2,
                leading: SvgPicture.asset(
                  "assets/svg/privacy.svg",
                  color: FrontendConfigs.kIconColor,
                  height: 20,
                  width: 20,
                ),
                title: CustomText(
                  text: 'Privacy Policy',
                  color: FrontendConfigs.kIconColor,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              height:40,
              child: ListTile(
                minLeadingWidth: 2,
                leading: SvgPicture.asset(
                  "assets/svg/help_center.svg",
                  color: FrontendConfigs.kIconColor,
                  height: 20,
                  width: 20,
                ),
                title: CustomText(
                  text: 'Help Center',
                  color: FrontendConfigs.kIconColor,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),

            SizedBox(
              height:40,
              child: ListTile(
                minLeadingWidth: 2,
                leading: SvgPicture.asset(
                  "assets/svg/exit.svg",
                  color:Colors.red,
                  height: 20,
                  width: 20,
                ),
                title: CustomText(
                  text: 'Lout out',
                  color: Colors.red,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
