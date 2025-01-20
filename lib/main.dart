import 'package:flutter/material.dart';
import 'screens/welcome_page.dart'; // Import the WelcomePage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swimming App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(), // Set WelcomePage as the home screen
    );
  }
}
