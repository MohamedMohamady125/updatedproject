import 'package:flutter/material.dart';
import 'package:egy_app/auth/welcome_page.dart'; // Ensure correct path

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(), // Starting with the Welcome Page
    );
  }
}
