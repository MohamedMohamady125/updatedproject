import 'package:flutter/material.dart';

class CreateGroupScreen extends StatefulWidget {
  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _groupNameController = TextEditingController();
  String? _groupPhoto;
  final List<String> _roles = [
    'Swimmer',
    'Parent',
    'Coach',
    'Academy',
    'Online Academy',
    'Store',
    'Online Store',
    'Clinic',
    'Event Organizer'
  ];
  Map<String, bool> _roleSelection = {};
  bool _everyoneSelected = false;

  @override
  void initState() {
    super.initState();
    _roles.forEach((role) {
      _roleSelection[role] = false;
    });
  }

  void _onEveryoneSelected(bool? value) {
    setState(() {
      _everyoneSelected = value ?? false;
      _roles.forEach((role) {
        _roleSelection[role] = _everyoneSelected;
      });
    });
  }

  void _onCreateGroup() {
    if (_groupNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Group name is required')),
      );
      return;
    }
    // Handle group creation logic here
    Navigator.pop(context); // Return to Community Screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Group created successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Group'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Group Name
              TextFormField(
                controller: _groupNameController,
                decoration: InputDecoration(
                  labelText: 'Group Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Group Photo Upload
              TextButton(
                onPressed: () {
                  // Handle photo upload
                  setState(() {
                    _groupPhoto = "Uploaded Photo"; // Placeholder for photo upload
                  });
                },
                child: Text(
                  _groupPhoto == null ? 'Upload Group Photo' : 'Photo Uploaded',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(height: 16),
              // Roles Selection
              Text(
                "Roles Allowed to Join:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              CheckboxListTile(
                title: Text("Everyone"),
                value: _everyoneSelected,
                onChanged: _onEveryoneSelected,
              ),
              ..._roles.map((role) {
                return CheckboxListTile(
                  title: Text(role),
                  value: _roleSelection[role],
                  onChanged: (value) {
                    setState(() {
                      _roleSelection[role] = value ?? false;
                      _everyoneSelected = _roles.every((role) => _roleSelection[role]!);
                    });
                  },
                );
              }).toList(),
              SizedBox(height: 20),
              // Create Group Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onCreateGroup,
                  child: Text('Create Group'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
