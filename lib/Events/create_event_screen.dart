import 'package:flutter/material.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedPhoto;
  String? _eventType;
  String? _location;
  String? _duration;
  String? _deadline;
  String? _dateTime;
  int? _spotsAvailable;
  String? _price;
  bool _isOneTimeEvent = true;

  final List<String> _eventTypes = ['Workshop', 'Seminar', 'Competition'];
  final List<String> _locations = ['Sports Complex', 'Community Center'];
  final List<String> _durations = ['1 hour', '2 hours', '3 hours'];
  final List<String> _skillLevels = ['Beginner', 'Intermediate', 'Advanced'];
  Map<String, bool> _skillSelection = {};

  @override
  void initState() {
    super.initState();
    _skillLevels.forEach((level) {
      _skillSelection[level] = false;
    });
  }

  void _onCreateEvent() {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Title and Description are required')),
      );
      return;
    }
    // Handle event creation logic here
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Event created successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Event Title'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedPhoto = "Uploaded Photo"; // Placeholder for photo upload
                });
              },
              child: Text(_selectedPhoto == null ? 'Upload Photo' : 'Photo Uploaded'),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField(
              items: _eventTypes.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (value) => setState(() => _eventType = value as String?),
              decoration: InputDecoration(labelText: 'Event Type'),
            ),
            // Additional fields for Date, Duration, Location, etc.
            // Add similar dropdowns, checkboxes for skill levels, and toggle for event availability
            ElevatedButton(
              onPressed: _onCreateEvent,
              child: Text('Post Event'),
            ),
          ],
        ),
      ),
    );
  }
}
