
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotifications {

  static void firebaseCloudMessagingListeners(FirebaseMessaging firebaseMessaging) {

    if (Platform.isIOS) iosPermission(firebaseMessaging);

    firebaseMessaging.getToken().then((token) {
      print("FCM ID: $token");
    });

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  static void iosPermission(FirebaseMessaging firebaseMessaging) {

    firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

}