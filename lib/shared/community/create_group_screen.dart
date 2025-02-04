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
        backgroundColor: Color.fromARGB(255, 79, 165, 245),
        elevation: 0,
        title: Text(
          'Create Group',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 79, 165, 245),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Group Name
              TextFormField(
                controller: _groupNameController,
                decoration: InputDecoration(
                  labelText: 'Group Name',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Group Photo Upload
              TextButton(
                onPressed: () {
                  // Handle photo upload
                  setState(() {
                    _groupPhoto =
                        "Uploaded Photo"; // Placeholder for photo upload
                  });
                },
                child: Text(
                  _groupPhoto == null ? 'Upload Group Photo' : 'Photo Uploaded',
                  style: TextStyle(
                    color: Color.fromARGB(255, 79, 165, 245),
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Roles Selection
              Text(
                "Roles Allowed to Join:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 79, 165, 245),
                ),
              ),
              CheckboxListTile(
                title: Text(
                  "Everyone",
                  style: TextStyle(color: Colors.black),
                ),
                activeColor: Color.fromARGB(255, 79, 165, 245),
                value: _everyoneSelected,
                onChanged: _onEveryoneSelected,
              ),
              ..._roles.map((role) {
                return CheckboxListTile(
                  title: Text(
                    role,
                    style: TextStyle(color: Colors.black),
                  ),
                  activeColor: Color.fromARGB(255, 79, 165, 245),
                  value: _roleSelection[role],
                  onChanged: (value) {
                    setState(() {
                      _roleSelection[role] = value ?? false;
                      _everyoneSelected =
                          _roles.every((role) => _roleSelection[role]!);
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 79, 165, 245),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Create Group',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
