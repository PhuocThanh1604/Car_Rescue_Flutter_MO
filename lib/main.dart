import 'package:flutter/material.dart';
// import 'package:CarRescue/presentation/view/driver_view/auth/car_registration/car_registration_view.dart';
// import 'package:CarRescue/presentation/view/driver_view/auth/log_in/log_in_view.dart';
// import 'package:CarRescue/presentation/view/driver_view/auth/number_verification/number_verification_view.dart';
// import 'package:CarRescue/presentation/view/driver_view/trip_details/trip_details_view.dart';
// import 'package:CarRescue/presentation/view/pessenger_view/auth/log_in/log_in_view.dart';
// import 'package:CarRescue/presentation/view/pessenger_view/chat_with_driver/chat_view.dart';
// import 'package:CarRescue/presentation/view/pessenger_view/home/home_view.dart';
// import 'package:CarRescue/presentation/view/pessenger_view/profile/profile_view.dart';
// import 'package:CarRescue/presentation/view/pessenger_view/top-up/top_up_view.dart';
// import 'package:CarRescue/presentation/view/pessenger_view/wallet/wallet_view.dart';
// import 'package:CarRescue/presentation/view/select_mode/select_mode_view.dart';
// import 'package:CarRescue/presentation/view/splash_screen/layout/body.dart';
import 'package:CarRescue/src/presentation/view/splash_screen/splash_view.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: "Montserrat"),
    home: const SplashView(),
  ));
}
