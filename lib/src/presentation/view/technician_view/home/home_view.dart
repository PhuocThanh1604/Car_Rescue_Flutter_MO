import 'package:CarRescue/src/presentation/view/technician_view/home/layout/body.dart';
import 'package:flutter/material.dart';

import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();

class TechnicianHomeView extends StatelessWidget {
  TechnicianHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                  'assets/images/logo-no-background.png',
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
          fontWeight: FontWeight.bold,
          text: 'Trang chủ',
          fontSize: 16,
          color: FrontendConfigs.kPrimaryColor,
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Center(
              child: CustomText(
                text: 'Xin chào, Hieu',
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Màu chữ nâu
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 126, 61, 61),
        child: TechncianHomePageBody(),
      ),
    );
  }
}
