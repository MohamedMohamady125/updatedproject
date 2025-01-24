import 'package:flutter/material.dart';

class EventDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> event;

  EventDetailsScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(event['photo'], height: 200, fit: BoxFit.cover),
            SizedBox(height: 16),
            Text(
              event['title'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Location: ${event['location']}'),
            Text('Price: ${event['price']}'),
            SizedBox(height: 16),
            Text(
              'Description: This is a placeholder description for the event.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Booking logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Event booked successfully!')),
                );
              },
              child: Text('Book Event'),
            ),
          ],
        ),
      ),
    );
  }
}
