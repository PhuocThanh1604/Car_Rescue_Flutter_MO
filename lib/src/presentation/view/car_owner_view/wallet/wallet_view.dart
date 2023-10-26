import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../configuration/frontend_configs.dart';
import '../../../elements/custom_text.dart';
import 'layout/body.dart';

class WalletView extends StatelessWidget {
  const WalletView({Key? key}) : super(key: key);

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
              color: const Color(0xFF2DBB54),
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
          text: 'Ví của tôi',
          fontSize: 18,
          color: FrontendConfigs.kPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: WalletBody(),
    );
  }
}
