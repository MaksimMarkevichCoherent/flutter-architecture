import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'logger.dart';

class PushNotificationHandler {
  final FirebaseMessaging _firebaseMessaging;

  PushNotificationHandler({
    required FirebaseMessaging firebaseMessaging,
  }) : _firebaseMessaging = firebaseMessaging;

  Future<void> init(BuildContext context) async {
    var token = await _firebaseMessaging.getToken();
    print('FCM: $token');

    if (Platform.isIOS) {
      final settings = await _firebaseMessaging.requestPermission();
      logger.d('New settings registered: $settings');
    }

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
