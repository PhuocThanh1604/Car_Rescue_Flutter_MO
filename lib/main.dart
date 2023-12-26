<<<<<<< HEAD
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
    theme: ThemeData(fontFamily: "Poppins"),
    home: const SplashView(),
  ));
=======
import 'package:CarRescue/src/models/customer.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/auth/log_in/log_in_view.dart';
import 'package:CarRescue/src/presentation/view/customer_view/auth/log_in/log_in_view.dart';
import 'package:CarRescue/src/presentation/view/customer_view/notify/notify_view.dart';
import 'package:CarRescue/src/presentation/view/technician_view/auth/log_in/log_in_view.dart';
import 'package:CarRescue/src/providers/firebase_message_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:CarRescue/src/presentation/view/splash_screen/splash_view.dart';

import 'package:get_storage/get_storage.dart';

final navigatorKey = GlobalKey<NavigatorState>();
String? userRole = GetStorage().read('role');
Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Đảm bảo rằng Flutter đã sẵn sàng.
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission();
  await FireBaseMessageProvider().initLocalNotifications();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: "Inter"),
    navigatorKey: navigatorKey,
    initialRoute: userRole != null
        ? userRole!.contains('Technician')
            ? '/technician/home'
            : userRole!.contains('Customer')
                ? '/customer/home'
                : userRole!.contains('Rescuevehicleowner')
                    ? '/vehicleowner/home'
                    : '/roles'
        : '/',
    routes: {
      "/":(context) => SplashView(),
      "/notify": (context) => NotifyView(),
      "/customer/home":(context) => PassengerLogInView(),
      "/technician/home":(context) => TechnicianLogInView(),
      "/vehicleowner/home":(context) => CarOwnerLogInView(),
    },
  ));
  print("user role: $userRole");
>>>>>>> origin/MinhAndHieu6
}
