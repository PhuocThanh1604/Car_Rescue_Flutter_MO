import 'package:CarRescue/src/presentation/view/customer_view/notify/notify_view.dart';
import 'package:CarRescue/src/presentation/view/customer_view/profile/edit_profile/edit_profile_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:CarRescue/src/presentation/view/splash_screen/splash_view.dart';

final navigatorKey = GlobalKey<NavigatorState>();
// Customer customer = Customer.fromJson(GetStorage().read('customer') ?? {});
// FirebaseOptions options = new FirebaseOptions.Builder()
//         .setApplicationId("com.infusibleCoder.raido") // Required for Analytics.
//         .setProjectId("car-rescue-399511") // Required for Firebase Installations.
//         .setApiKey("AIzaSyBZmPE0cCErk-nZtza3mDsXwIKLhS2s8Jg") // Required for Auth.
//         .build();
Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Đảm bảo rằng Flutter đã sẵn sàng.
  await Firebase.initializeApp();

  await FirebaseMessaging.instance.requestPermission();
  // await FireBaseMessageProvider().initLocalNotifications();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: "Inter"),
    navigatorKey: navigatorKey,
    home: const SplashView(),
    routes: {
      "/notify": (context) => NotifyView(),
      "/editProfile": (context) => EditProfileViewCustomer(),
    },
  ));
}
