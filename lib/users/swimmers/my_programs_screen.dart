import 'package:flutter/material.dart';

class MyProgramsScreen extends StatelessWidget {
  final List<Map<String, String>> programs = [
    {
      'name': 'Advanced Swimming Techniques',
      'price': '\$100',
      'duration': '6 Weeks',
      'description':
          'Improve your strokes and endurance with our expert trainers.',
    },
    {
      'name': 'Beginner Swimming Course',
      'price': '\$50',
      'duration': '4 Weeks',
      'description':
          'A step-by-step guide for beginners to learn swimming safely.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Programs'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: programs.length,
              itemBuilder: (context, index) {
                final program = programs[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(program['name']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Duration: ${program['duration']}'),
                        Text('Price: ${program['price']}'),
                        Text('Description: ${program['description']}'),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Implement Add Program Functionality
              },
              child: Text('Add New Program'),
            ),
          ),
        ],
      ),
    );
  }
}
