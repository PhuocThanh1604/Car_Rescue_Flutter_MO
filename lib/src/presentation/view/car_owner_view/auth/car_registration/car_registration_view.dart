import 'package:flutter/material.dart';
import 'package:CarRescue/src/presentation/elements/app_button.dart';
import 'package:CarRescue/src/presentation/elements/custom_appbar.dart';
import 'package:CarRescue/src/presentation/view/customer_view/auth/verify_number/verify_number_view.dart';

import '../number_verification/number_verification_view.dart';
import 'layout/body.dart';

class CarRegistrationView extends StatelessWidget {
  const CarRegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: CarRegistrationBody(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 18, left: 18, bottom: 10),
        child: AppButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NumberVerificationView()));
            },
            btnLabel: 'Continue'),
      ),
    );
  }
}
