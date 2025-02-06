import 'package:flutter/material.dart';

class BookingDetailsScreen extends StatelessWidget {
  final Map<String, String> bookingDetails;

  const BookingDetailsScreen({super.key, required this.bookingDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bookingDetails['eventName']!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Date: ${bookingDetails['date']}', style: const TextStyle(fontSize: 18)),
            Text('Time: ${bookingDetails['time']}', style: const TextStyle(fontSize: 18)),
            Text('Status: ${bookingDetails['status']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            const Text('Location:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(bookingDetails['location']!, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            const Text('Organizer:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(bookingDetails['organizer']!, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            const Text('Price:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(bookingDetails['price']!, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to My Bookings'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
