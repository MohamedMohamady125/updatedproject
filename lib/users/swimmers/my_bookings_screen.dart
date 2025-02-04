// lib/users/swimmers/my_bookings_screen.dart
import 'package:flutter/material.dart';

class MyBookingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings'),
        centerTitle: true,
      ),
      body: Center(child: Text('List of bookings will be displayed here.')),
    );
  }
}
