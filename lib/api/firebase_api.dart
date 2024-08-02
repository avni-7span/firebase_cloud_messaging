import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notification/main.dart';

void handleMessage(RemoteMessage? message) {
  if (message == null) return;
  navigatorKey.currentState
      ?.pushNamed('/notification_screen', arguments: message);
}

class FirebaseApi {
  final instance = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await instance.requestPermission();
    await initPushNotifications();
    final fcmToken = await instance.getToken();
    print('Token : $fcmToken');
  }

  Future<void> initPushNotifications() async {
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  }
}
