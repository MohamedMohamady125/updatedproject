import 'package:flutter/material.dart';

class JoinGroupScreen extends StatelessWidget {
  final List<Map<String, dynamic>> _groups = [
    {'name': 'Swimming Enthusiasts', 'description': 'A group for swimmers'},
    {'name': 'Parents Circle', 'description': 'A group for parents'},
  ];

  const JoinGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 79, 165, 245),
        elevation: 0,
        title: const Text(
          'Join Group',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 79, 165, 245),
              Colors.white,
            ],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemCount: _groups.length,
          itemBuilder: (context, index) {
            final group = _groups[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                title: Text(
                  group['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 79, 165, 245),
                  ),
                ),
                subtitle: Text(
                  group['description'],
                  style: TextStyle(color: Colors.grey[700]),
                ),
                trailing: PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert,
                      color: Color.fromARGB(255, 79, 165, 245)),
                  onSelected: (value) {
                    if (value == 'Invite') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Group URL copied!')),
                      );
                    } else if (value == 'Leave') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Left the group!')),
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'Invite',
                      child: Text('Invite'),
                    ),
                    const PopupMenuItem(
                      value: 'Leave',
                      child: Text('Leave Group'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
