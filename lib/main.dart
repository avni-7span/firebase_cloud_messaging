import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:push_notification/api/firebase_api.dart';
import 'package:push_notification/firebase_options.dart';
import 'package:push_notification/screens/home_screen.dart';
import 'package:push_notification/screens/notification_screen.dart';

/// NavigatorState : key to find screen , Global : can be used anywhere in app
final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotification();
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

/// navigatorKey : GPS , /notification_screen : address , routes : map ,
