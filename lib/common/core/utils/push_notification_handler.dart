import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'logger.dart';

abstract class IPushNotificationHandler {
  Future<void> init(BuildContext context);
}

class PushNotificationHandler implements IPushNotificationHandler {
  final FirebaseMessaging _firebaseMessaging;

  PushNotificationHandler({
    required FirebaseMessaging firebaseMessaging,
  }) : _firebaseMessaging = firebaseMessaging;

  @override
  Future<void> init(BuildContext context) async {
    var token = await _firebaseMessaging.getToken();
    print('FCM: $token');

    if (Platform.isIOS) {
      final settings = await _firebaseMessaging.requestPermission();
      logger.d('New settings registered: $settings');
    }

    // await FlutterLocalNotificationsPlugin()
    //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(const AndroidNotificationChannel(
    //   'high_importance_channel',
    //   'High Importance Notifications',
    //   description: 'This channel is used for important notifications.',
    //   importance: Importance.high,
    //   playSound: true,
    // ));
    //
    // await FirebaseMessaging.instance
    //     .setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage');
      _onMessage(context, message.data);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp');
      _onMessageOpenedApp(context, message.data);
    });

    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }

  /// Invoked when the app is in foreground
  Future<void> _onMessage(
    BuildContext context,
    Map<String, dynamic> message,
  ) async {
    //logger.d('onMessage: ${message.toString()}');
  }

  /// Invoked on push notification click when app is opened.
  Future<void> _onMessageOpenedApp(
    BuildContext context,
    Map<String, dynamic> message,
  ) async {
    //logger.d('onMessageOpenedApp: ${message.toString()}');
  }

  static Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    print('_backgroundMessageHandler');
    //logger.d('onBackgroundMessage: ${message.data.toString()}');
    return;
  }
}
