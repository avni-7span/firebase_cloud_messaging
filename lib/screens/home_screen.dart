import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
}
