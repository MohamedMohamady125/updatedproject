import 'package:flutter/material.dart';

class MyChildrenScreen extends StatefulWidget {
  @override
  _MyChildrenScreenState createState() => _MyChildrenScreenState();
}

class _MyChildrenScreenState extends State<MyChildrenScreen> {
  final List<Map<String, String>> _children = [];
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();

  void _addChild() {
    if (_nameController.text.isNotEmpty && _ageController.text.isNotEmpty && _genderController.text.isNotEmpty) {
      setState(() {
        _children.add({
          'name': _nameController.text,
          'age': _ageController.text,
          'gender': _genderController.text,
        });
      });
      _nameController.clear();
      _ageController.clear();
      _genderController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Children'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Child's Name"),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _genderController,
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addChild,
              child: Text('Add Child'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _children.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_children[index]['name'] ?? ''),
                    subtitle: Text('Age: ${_children[index]['age']}, Gender: ${_children[index]['gender']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}