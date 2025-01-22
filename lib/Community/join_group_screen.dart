import 'package:flutter/material.dart';

class JoinGroupScreen extends StatelessWidget {
  final List<Map<String, dynamic>> _groups = [
    {'name': 'Swimming Enthusiasts', 'description': 'A group for swimmers'},
    {'name': 'Parents Circle', 'description': 'A group for parents'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join Group'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _groups.length,
        itemBuilder: (context, index) {
          final group = _groups[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(group['name']),
              subtitle: Text(group['description']),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'Invite') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Group URL copied!')),
                    );
                  } else if (value == 'Leave') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Left the group!')),
                    );
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(value: 'Invite', child: Text('Invite')),
                  PopupMenuItem(value: 'Leave', child: Text('Leave Group')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
