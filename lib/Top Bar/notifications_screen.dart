import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> notifications = [
      'Booking confirmed for Swimming Lesson!',
      'New event: Swimming Championship 2023!',
      'Order #1234 has been shipped!',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.notifications_active),
            title: Text(notifications[index]),
          );
        },
      ),
    );
  }
}
