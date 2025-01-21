import 'package:flutter/material.dart';
import 'verification_page.dart';

class ProfileCompletionPage extends StatefulWidget {
  final String fullName;
  final String email;
  final String role;

  ProfileCompletionPage({
    required this.fullName,
    required this.email,
    required this.role,
  });

  @override
  _ProfileCompletionPageState createState() => _ProfileCompletionPageState();
}

class _ProfileCompletionPageState extends State<ProfileCompletionPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  String? _selectedLanguage;
  String? _selectedCountry;
  String? _selectedGender;
  String? _selectedSkillLevel;
  DateTime? _selectedDateOfBirth;
  String? _profilePhoto;

  final List<String> _languages = ['English', 'Spanish', 'French']; // Example
  final List<String> _countries = ['USA', 'Canada', 'UK']; // Example
  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _skillLevels = ['Beginner', 'Intermediate', 'Advanced'];

  bool get isSwimmer => widget.role == 'Swimmer';
  bool get isParentOrCoach =>
      widget.role == 'Parent' || widget.role == 'Coach';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Your Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Full Name (Read-Only)
                TextFormField(
                  initialValue: widget.fullName,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                // Email (Editable with verification)
                TextFormField(
                  initialValue: widget.email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    // If email is changed, navigate to verification
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VerificationPage()),
                    );
                  },
                ),
                SizedBox(height: 16),
                // Role (Read-Only)
                TextFormField(
                  initialValue: widget.role,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Role',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                // Gender (Swimmer, Parent, Coach)
                if (isSwimmer || isParentOrCoach)
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedGender,
                    items: _genders.map((gender) {
                      return DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your gender';
                      }
                      return null;
                    },
                  ),
                SizedBox(height: 16),
                // Date of Birth (Swimmer, Parent, Coach)
                if (isSwimmer || isParentOrCoach)
                  DropdownButtonFormField<DateTime>(
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      border: OutlineInputBorder(),
                    ),
                    items: List.generate(100, (index) {
                      final year = DateTime.now().year - index;
                      return DropdownMenuItem(
                        value: DateTime(year),
                        child: Text(year.toString()),
                      );
                    }),
                    onChanged: (value) {
                      setState(() {
                        _selectedDateOfBirth = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select your date of birth';
                      }
                      return null;
                    },
                  ),
                SizedBox(height: 16),
                // Skill Level (Swimmer only)
                if (isSwimmer)
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Skill Level',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedSkillLevel,
                    items: _skillLevels.map((skill) {
                      return DropdownMenuItem(
                        value: skill,
                        child: Text(skill),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedSkillLevel = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your skill level';
                      }
                      return null;
                    },
                  ),
                SizedBox(height: 16),
                // Phone Number
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Language
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Language',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedLanguage,
                  items: _languages.map((lang) {
                    return DropdownMenuItem(
                      value: lang,
                      child: Text(lang),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedLanguage = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                // Country
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedCountry,
                  items: _countries.map((country) {
                    return DropdownMenuItem(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCountry = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                // Profile Photo (Placeholder for now)
                TextButton(
                  onPressed: () {
                    // Handle photo upload
                    setState(() {
                      _profilePhoto = "Uploaded"; // Placeholder
                    });
                  },
                  child: Text('Upload Profile Photo'),
                ),
                SizedBox(height: 20),
                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle profile saving logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Profile Updated!')),
                        );
                      }
                    },
                    child: Text('Save Profile'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
