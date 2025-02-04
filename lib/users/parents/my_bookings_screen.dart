import 'package:flutter/material.dart';

class BookingDetailsScreen extends StatelessWidget {
  final Map<String, String> bookingDetails;

  BookingDetailsScreen({required this.bookingDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bookingDetails['eventName']!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Date: ${bookingDetails['date']}', style: TextStyle(fontSize: 18)),
            Text('Time: ${bookingDetails['time']}', style: TextStyle(fontSize: 18)),
            Text('Status: ${bookingDetails['status']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Location:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(bookingDetails['location']!, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Organizer:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(bookingDetails['organizer']!, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Price:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(bookingDetails['price']!, style: TextStyle(fontSize: 16)),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back to My Bookings'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
