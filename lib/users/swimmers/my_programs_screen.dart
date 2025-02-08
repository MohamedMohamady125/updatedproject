import 'package:flutter/material.dart';

class MyProgramsScreen extends StatelessWidget {
  MyProgramsScreen({super.key});

  final List<Map<String, String>> programs = [
    {
      'name': 'Advanced Swimming Techniques',
      'price': '\$100',
      'duration': '6 Weeks',
      'description': 'Improve your strokes and endurance with our expert trainers.',
    },
    {
      'name': 'Beginner Swimming Course',
      'price': '\$50',
      'duration': '4 Weeks',
      'description': 'A step-by-step guide for beginners to learn swimming safely.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Programs'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: programs.length,
              itemBuilder: (context, index) {
                final program = programs[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      program['name']!,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('⏳ Duration: ${program['duration']}'),
                          Text('💰 Price: ${program['price']}'),
                          const SizedBox(height: 8),
                          Text(
                            program['description']!,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                    onTap: () {
                      // Implement navigation or action on tap
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Implement Add Program Functionality
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Add New Program',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
