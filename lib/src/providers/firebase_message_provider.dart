import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingProvider {
  final _firebaseMessaging = FirebaseMessaging.instance;
  String? deviceToken;

  Future<String?> getDeviceToken() async {
    try {
      deviceToken = await _firebaseMessaging.getToken();
      print('Device Token: ${deviceToken}');
      return deviceToken;
    } catch (e) {
      print('Loi vcl');
      return null;
    }
  }
}
