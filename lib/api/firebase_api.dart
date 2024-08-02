import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notification/main.dart';

class FirebaseApi {
  final instance = FirebaseMessaging.instance;

  /// function to initialize notification
  Future<void> initNotification() async {
    /// request permission from user
    await instance.requestPermission();
    await initPushNotifications();

    /// fetch the FCM(firebase cloud messaging) token for this device
    final fcmToken = await instance.getToken();

    /// send token to server
    print('Token : $fcmToken');
  }

  /// handling received messages and user taps notifications
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState
        ?.pushNamed('/notification_screen', arguments: message);
  }

  /// function to initialize background settings
  Future<void> initPushNotifications() async {
    /// attach event listeners for when tapping on notification opens the app
    /// background state
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    /// handle notification if the app was terminated and now open
    /// terminated state
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  }
}

/// - APNSToken is the Apple Push Notification Service token.
/// It is a token (think of it like a password) that authenticates your app and
/// device onto the Apple Push service and allows for communications to be sent.

/// - FCMToken is the Firebase Cloud Messaging token.
/// This is googles version of the APNS Token however works for both iOS and
/// Android (Google do proxying on their end when sending a
/// push notification to iOS devices).
