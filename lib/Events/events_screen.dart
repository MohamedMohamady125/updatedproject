import 'package:flutter/material.dart';
import 'create_event_screen.dart';
import 'event_details_screen.dart';

class EventsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> _events = [
    {
      'photo': 'https://via.placeholder.com/150',
      'title': 'Swimming Workshop',
      'location': 'Sports Complex',
      'price': '\$50'
    },
    {
      'photo': 'https://via.placeholder.com/150',
      'title': 'Parent Coaching Seminar',
      'location': 'Community Center',
      'price': '\$20'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _events.length,
        itemBuilder: (context, index) {
          final event = _events[index];
          return Card(
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(event['photo'], height: 150, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event['title'],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text('Location: ${event['location']}'),
                      Text('Price: ${event['price']}'),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventDetailsScreen(event: event),
                            ),
                          );
                        },
                        child: Text('Show More Details'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Ensure roles other than swimmers/parents can access
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateEventScreen()),
          );
        },
        label: Text('Create Event'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
