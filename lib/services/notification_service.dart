import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push_notification/main.dart';

class NotificationService {
  NotificationService._internal();
  static final instance = NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High importance notifications',
    importance: Importance.max,
  );

  void redirectToNotificationScreen(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

  Future<void> init() async {
    final firebaseMessagingInstance = FirebaseMessaging.instance;
    await firebaseMessagingInstance.requestPermission();
    final fcmToken = await firebaseMessagingInstance.getToken();
    log('token: $fcmToken');
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  Future<void> listenForForegroundNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        RemoteNotification? notification = message.notification;
        final androidNotification = message.notification?.android;
        if (notification != null && androidNotification != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                _channel.id,
                _channel.name,
                icon: androidNotification.smallIcon,
              ),
            ),
          );
        }
      }
      redirectToNotificationScreen(message);
    });
  }

  Future<void> listenForBackgroundNotification() async {
    /// background
    FirebaseMessaging.instance
        .getInitialMessage()
        .then(redirectToNotificationScreen);
  }
}
