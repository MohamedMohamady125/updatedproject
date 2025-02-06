import 'package:flutter/material.dart';
import 'package:egy_app/auth/welcome_page.dart'; // Ensure correct path

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(), // Starting with the Welcome Page
    );
  }
}
