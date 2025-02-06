import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddListingScreen extends StatefulWidget {
  @override
  _AddListingScreenState createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  final _formKey = GlobalKey<FormState>();

  String? title;
  File? selectedImage;
  String? description;
  String? serviceName;
  String? price;
  String? duration;

  final List<Map<String, dynamic>> listings = [];

  final List<String> availableServices = [
    'Private Coaching',
    'Group Training',
    'Online Consultation',
    'Swimming Lessons',
  ];

  final List<String> durationOptions = [
    '30 minutes',
    '1 hour',
    '2 hours',
    'Half-day',
    'Full-day',
  ];

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  void _submitListing() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        listings.add({
          'title': title,
          'image': selectedImage,
          'description': description,
          'serviceName': serviceName,
          'price': price,
          'duration': duration,
        });
      });
      // Clear the form after submission
      _formKey.currentState!.reset();
      selectedImage = null;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Listing added successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Listing')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Expanded(
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Title'),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a title' : null,
                      onSaved: (value) => title = value,
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 150,
                        color: Colors.grey[200],
                        child: selectedImage == null
                            ? Icon(Icons.image, size: 50, color: Colors.grey)
                            : Image.file(selectedImage!, fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      onSaved: (value) => description = value,
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Service Name'),
                      value: serviceName,
                      onChanged: (value) => setState(() => serviceName = value),
                      items: availableServices
                          .map((service) => DropdownMenuItem(
                                value: service,
                                child: Text(service),
                              ))
                          .toList(),
                      validator: (value) =>
                          value == null ? 'Please select a service' : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Price'),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a price' : null,
                      onSaved: (value) => price = value,
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Duration'),
                      value: duration,
                      onChanged: (value) => setState(() => duration = value),
                      items: durationOptions
                          .map((dur) => DropdownMenuItem(
                                value: dur,
                                child: Text(dur),
                              ))
                          .toList(),
                      validator: (value) =>
                          value == null ? 'Please select duration' : null,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitListing,
                      child: Text('Submit Listing'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: listings.isEmpty
                  ? Center(child: Text("No listings added yet."))
                  : ListView.builder(
                      itemCount: listings.length,
                      itemBuilder: (context, index) {
                        final listing = listings[index];
                        return Card(
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            leading: listing['image'] != null
                                ? Image.file(listing['image'], width: 50, height: 50, fit: BoxFit.cover)
                                : Icon(Icons.image, size: 50),
                            title: Text(listing['title']),
                            subtitle: Text(
                                "${listing['serviceName']} - ${listing['price']} - ${listing['duration']}"),
                          ),
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
