import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:push_notification/screens/home_screen.dart';
import 'package:push_notification/screens/notification_screen.dart';
import 'package:push_notification/services/notification_service.dart';

/// NavigatorState : key to find screen , Global : can be used anywhere in app
final navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationService.instance.redirectToNotificationScreen(message);
}

/// terminated
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await NotificationService.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      navigatorKey: navigatorKey,
      routes: {'/notification_screen': (context) => const NotificationScreen()},
    );
  }
}
