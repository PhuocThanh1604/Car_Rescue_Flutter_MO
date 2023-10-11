import 'package:CarRescue/src/presentation/view/technician_view/auth/log_in/log_in_view.dart';
import 'package:flutter/material.dart';
import 'package:CarRescue/src/presentation/elements/app_button.dart';

import 'layout/body.dart';

class AccountCreatedView extends StatelessWidget {
  const AccountCreatedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:customAppBar(context),
      body: const AccountCreatedBody(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 18.0, left: 18, bottom: 10),
        child: AppButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TechnicianLogInView()));
          },
          btnLabel: 'Got it!',
        ),
      ),
    );
  }
}
