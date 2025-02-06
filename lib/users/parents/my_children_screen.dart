import 'package:flutter/material.dart';

class MyChildrenScreen extends StatefulWidget {
  const MyChildrenScreen({super.key});

  @override
  _MyChildrenScreenState createState() => _MyChildrenScreenState();
}

class _MyChildrenScreenState extends State<MyChildrenScreen> {
  List<Map<String, String>> children = [
    {
      'name': 'Emily Johnson',
      'dob': 'Jan 5, 2015',
      'skillLevel': 'Intermediate',
      'gender': 'Female',
    },
    {
      'name': 'Michael Johnson',
      'dob': 'March 12, 2018',
      'skillLevel': 'Beginner',
      'gender': 'Male',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Children'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: children.length,
              itemBuilder: (context, index) {
                final child = children[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(child['name']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date of Birth: ${child['dob']}'),
                        Text('Skill Level: ${child['skillLevel']}'),
                        Text('Gender: ${child['gender']}'),
                      ],
                    ),
                    trailing: const Icon(Icons.edit),
                    onTap: () {
                      // Implement Edit Functionality
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Implement Add Child Functionality
              },
              child: const Text('Add Child'),
            ),
          ),
        ],
      ),
    );
  }
}
