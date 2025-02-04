import 'package:flutter/material.dart';

class MyOrdersScreen extends StatelessWidget {
  final String role;

  const MyOrdersScreen({required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        centerTitle: true,
      ),
      body: Center(child: Text('List of orders will be displayed here.')),
    );
  }
}