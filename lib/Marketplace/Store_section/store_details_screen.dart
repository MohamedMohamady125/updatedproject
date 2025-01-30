import 'package:flutter/material.dart';

class StoreDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> store;

  StoreDetailsScreen({required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${store['name']} Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(store['photo'], height: 200, fit: BoxFit.cover),
            SizedBox(height: 16),
            Text(
              store['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Location: ${store['location']}'),
            SizedBox(height: 16),
            Text('Branches:'),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Branch Location URL Copied!')),
                );
              },
              child: Text('Show Branch Location'),
            ),
            SizedBox(height: 16),
            Text('Social Media:'),
            Row(
              children: [
                Icon(Icons.facebook, color: Colors.blue),
                SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
