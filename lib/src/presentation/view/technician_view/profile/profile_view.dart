import 'package:flutter/material.dart';

import '../../../../configuration/frontend_configs.dart';
import '../../../elements/custom_text.dart';
import 'layout/body.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key, required this.userId, required this.accountId})
      : super(key: key);
  final String userId;
  final String accountId;
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding:
              const EdgeInsets.only(left: 18.0, top: 11, bottom: 11, right: 4),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Color.fromARGB(0, 0, 0, 0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/logo-color.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit
                      .cover, // Optional, you can adjust the BoxFit as needed
                ),
              ),
            ),
          ),
        ),
        title: CustomText(
          text: 'Cá nhân',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: FrontendConfigs.kPrimaryColor,
        ),
        centerTitle: true,
      ),
      body: ProfileBody(
        userId: widget.userId,
        accountId: widget.accountId,
      ),
    );
  }
}
