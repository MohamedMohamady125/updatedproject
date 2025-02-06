// lib/users/swimmers/my_bookings_screen.dart
import 'package:flutter/material.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        centerTitle: true,
      ),
      body: const Center(child: Text('List of bookings will be displayed here.')),
    );
  }
}
