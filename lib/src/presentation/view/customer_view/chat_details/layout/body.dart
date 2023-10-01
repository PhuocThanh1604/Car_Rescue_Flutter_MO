import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../configuration/frontend_configs.dart';
import '../../../../../utils/utils.dart';
import '../../chat_with_driver/chat_view.dart';
import 'widgets/profile_card_widget.dart';

class ChatBody extends StatelessWidget {
  ChatBody({Key? key}) : super(key: key);
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(children: [
            const SizedBox(height: 8,),
            SizedBox(
              height: 49,
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset('assets/svg/search_icon.svg'),
                  ),
                  hintText: 'Search driver',
                  hintStyle: TextStyle(
                      color: FrontendConfigs.kIconColor,
                      fontSize: 14,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none),
                  fillColor: FrontendConfigs.kAuthColor,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 14,),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: Utils.profileCard.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: ProfileCardWidget(
                      profileImage: Utils.profileCard[i].profileImage,
                      name: Utils.profileCard[i].name,
                      details: Utils.profileCard[i].details,
                      time: Utils.profileCard[i].time,
                      isShow: true,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ChatView()));
                      },),
                  );
                }),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: Utils.profileCard.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: ProfileCardWidget(
                      profileImage: Utils.profileCard[i].profileImage,
                      name: Utils.profileCard[i].name,
                      details: Utils.profileCard[i].details,
                      time: Utils.profileCard[i].time,
                      onPressed: () {},),
                  );
                })

          ],),
        ),
      ),
    );
  }
}
