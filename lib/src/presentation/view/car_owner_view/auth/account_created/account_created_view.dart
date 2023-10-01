import 'package:flutter/material.dart';
import 'package:CarRescue/src/presentation/elements/app_button.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/home/home_view.dart';
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
                MaterialPageRoute(builder: (context) => DriverHomeView()));
          },
          btnLabel: 'Got it!',
        ),
      ),
    );
  }
}
