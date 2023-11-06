import 'package:CarRescue/src/models/customer.dart';
import 'package:CarRescue/src/presentation/view/customer_view/home/home_view.dart';
import 'package:CarRescue/src/presentation/view/customer_view/notify/notify_view.dart';
import 'package:CarRescue/src/presentation/view/customer_view/profile/edit_profile/edit_profile_view.dart';
import 'package:CarRescue/src/providers/firebase_message_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:CarRescue/src/presentation/view/splash_screen/splash_view.dart';
import 'package:get_storage/get_storage.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Customer customer = Customer.fromJson(GetStorage().read('customer') ?? {});

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Đảm bảo rằng Flutter đã sẵn sàng.
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission();
  await FireBaseMessageProvider().initLocalNotifications();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: "Poppins"),
    navigatorKey: navigatorKey,
    home: const SplashView(),
    routes: {
      "/notify":(context) => NotifyView(),
    },
  ));
}
