import 'package:CarRescue/src/presentation/view/technician_view/home/layout/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              color: Color.fromARGB(255, 126, 65, 0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/images/logo-no-background.png',
                width: 50,
                height: 50,
              ),
            ),
          ),
        ),
        title: CustomText(
          fontWeight: FontWeight.bold,
          text: 'Home',
          fontSize: 16,
          color: FrontendConfigs.kPrimaryColor,
        ),
        centerTitle: true,
      ),
      body: Container(
          color: const Color.fromARGB(255, 126, 61, 61),
          child: TechncianHomePageBody()),
    );
  }
}
