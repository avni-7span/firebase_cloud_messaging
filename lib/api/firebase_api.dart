import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push_notification/main.dart';

void handleMessage(RemoteMessage? message) {
  if (message == null) return;
  navigatorKey.currentState
      ?.pushNamed('/notification_screen', arguments: message);
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High importance notifications',
  importance: Importance.max,
);

class FirebaseApi {
  final instance = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await instance.requestPermission();
    await initPushNotifications();
    final fcmToken = await instance.getToken();
    print('Token : $fcmToken');
  }

  Future<void> initPushNotifications() async {
    /// background
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? androidNotification =
            message.notification?.android;
        if (notification != null && androidNotification != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  icon: androidNotification.smallIcon),
            ),
          );
        }
      }
      // FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
      handleMessage(message);
    });
  }
}
