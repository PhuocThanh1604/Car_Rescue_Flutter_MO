import 'package:flutter/material.dart';
// import 'package:CarRescue/src/presentation/view/car_owner_view/auth/sign_up/sign_up_view.dart';

import '../../../../../configuration/frontend_configs.dart';
import '../../../../elements/custom_appbar.dart';
import 'layout/body.dart';

class CarOwnerLogInView extends StatelessWidget {
  const CarOwnerLogInView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
      ),
      body: CarOwnerLogInBody(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const SignUpView()));
              },
              child: RichText(
                  text: TextSpan(
                      text: "Don’t have an account? ",
                      style: TextStyle(
                          color: FrontendConfigs.kAuthColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                      children: [
                    TextSpan(
                      text: " Sign up.",
                      style: TextStyle(
                          color: FrontendConfigs.kAuthColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
