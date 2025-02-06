import 'package:flutter/material.dart';

class MyOrdersScreen extends StatelessWidget {
  final String role;

  const MyOrdersScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        centerTitle: true,
      ),
      body: const Center(child: Text('List of orders will be displayed here.')),
    );
  }
}