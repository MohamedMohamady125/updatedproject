import 'package:flutter/material.dart';
import 'booking_details_screen.dart';

class MyBookingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Example bookings data (replace with backend data later)
    final List<Map<String, String>> bookings = [
      {
        'eventName': 'Swimming Championship',
        'date': 'March 10, 2023',
        'time': '10:00 AM',
        'status': 'Confirmed',
        'location': 'Olympic Swimming Pool, New York',
        'price': '\$50',
        'organizer': 'NY Swim Academy',
      },
      {
        'eventName': 'Yoga Class',
        'date': 'March 15, 2023',
        'time': '6:00 PM',
        'status': 'Pending',
        'location': 'Wellness Center, Los Angeles',
        'price': '\$20',
        'organizer': 'Wellness LA',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings'),
      ),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return Card(
            margin: EdgeInsets.all(16),
            child: ListTile(
              title: Text(booking['eventName']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date: ${booking['date']}'),
                  Text('Time: ${booking['time']}'),
                  Text('Status: ${booking['status']}'),
                ],
              ),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Navigate to BookingDetailsScreen with booking details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingDetailsScreen(
                      bookingDetails: booking,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
