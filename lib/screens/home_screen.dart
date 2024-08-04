import 'package:flutter/material.dart';
import 'package:push_notification/services/notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    listenForNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(
        child: Text(
          'Home Page',
          style: TextStyle(fontSize: 40, color: Colors.deepPurple),
        ),
      ),
    );
  }

  Future<void> listenForNotifications() async {
    await NotificationService.instance.listenForForegroundNotification();
    await NotificationService.instance.listenForBackgroundNotification();
  }
}
