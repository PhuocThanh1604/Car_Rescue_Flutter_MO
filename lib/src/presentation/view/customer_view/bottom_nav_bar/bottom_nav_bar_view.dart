
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gillar/src/configuration/frontend_configs.dart';
import 'package:gillar/src/presentation/view/customer_view/profile/profile_view.dart';
import 'package:gillar/src/presentation/view/customer_view/wallet/wallet_view.dart';
import '../chat_details/chat_view.dart';
import '../home/home_view.dart';

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({Key? key}) : super(key: key);

  @override
  _BottomNavBarViewState createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  int _currentIndex = 0;
  final List<Widget> _children = [
     HomeView(),
    const ChatDetailsView(),
    const WalletView(),
    const ProfileView()
   ];

  // void onTabTapped(int index, BuildContext context) {
  //   // var bottomIndex = Provider.of<BottomIndexProvider>(context, listen: false);
  //   bottomIndex.setIndex(index);
  // }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // var bottomIndex = Provider.of<BottomIndexProvider>(context);
    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.green,
        unselectedItemColor: FrontendConfigs.kIconColor,
        backgroundColor: Colors.white,
        selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 10,
            fontFamily: "Poppins",
            color: FrontendConfigs.kPrimaryColor,),
        unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 10,
            fontFamily: "Poppins",
            color: FrontendConfigs.kIconColor,),
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        // currentIndex:getIndex,
        items: [
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: SvgPicture.asset(
                  height: 18,
                  width: 18,
                  'assets/svg/home_icon.svg',
                  // ignore: deprecated_member_use
                  color: _currentIndex == 0
                      ? Colors.green
                      : FrontendConfigs.kIconColor,
                ),
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: SvgPicture.asset(
                  height: 18,
                  width: 18,
                  'assets/svg/message.svg',
                  // ignore: deprecated_member_use
                  color:_currentIndex == 1
                      ? Colors.green
                      : FrontendConfigs.kIconColor,
                ),
              ),
              label: "Chat"),
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: SvgPicture.asset(
                  height: 16,
                  width: 16,
                  'assets/svg/wallet_icon.svg',
                  // ignore: deprecated_member_use
                  color: _currentIndex== 2
                      ? Colors.green
                      : FrontendConfigs.kIconColor,
                ),
              ),
              label: "Wallet"),
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: SvgPicture.asset(
                  'assets/svg/person_icon.svg',
                  // ignore: deprecated_member_use
                  color: _currentIndex == 3
                      ? Colors.green
                      : FrontendConfigs.kIconColor,
                  height: 18,
                  width: 18,
                ),
              ),
              label: "Profile"),
        ],
      ),
    );
  }
}
