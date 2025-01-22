import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _postContentController = TextEditingController();
  String? _selectedPhoto;

  bool get isPostButtonEnabled =>
      _postContentController.text.isNotEmpty || _selectedPhoto != null;

  void _onPost() {
    // Handle post creation logic here
    Navigator.pop(context); // Redirect back to Community Screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Post created successfully!')),
    );
  }

  void _onSelectPhoto() {
    // Logic to select a photo
    setState(() {
      _selectedPhoto = 'Sample Photo'; // Placeholder for photo upload
    });
  }

  @override
  void dispose() {
    _postContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
        actions: [
          TextButton(
            onPressed: isPostButtonEnabled ? _onPost : null,
            child: Text(
              'Post',
              style: TextStyle(
                color: isPostButtonEnabled ? Colors.blue : Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text('Y'), // Placeholder for user's initials
                ),
                SizedBox(width: 10),
                Text(
                  'Yehia El Marghany', // Replace with actual user name
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _postContentController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "What is on your mind...",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {}); // Refresh to enable/disable Post button
              },
            ),
            Spacer(),
            TextButton.icon(
              onPressed: _onSelectPhoto,
              icon: Icon(Icons.photo, color: Colors.green),
              label: Text(
                'Photo',
                style: TextStyle(color: Colors.green),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
