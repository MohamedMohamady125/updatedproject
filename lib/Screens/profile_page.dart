import 'package:flutter/material.dart';
import 'verification_page.dart';
import 'home_page.dart';

class ProfilePage extends StatefulWidget {
  final String fullName;
  final String email;
  final String role;

  ProfilePage({
    required this.fullName,
    required this.email,
    required this.role,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
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

  bool _hasUnsavedChanges = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.fullName)
      ..addListener(_trackChanges);
    _emailController = TextEditingController(text: widget.email)
      ..addListener(_trackChanges);
    _phoneController.addListener(_trackChanges);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _trackChanges() {
    setState(() {
      _hasUnsavedChanges = true;
    });
  }

  Future<bool> _onWillPop() async {
    if (_hasUnsavedChanges) {
      final discardChanges = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Unsaved Changes'),
          content: Text(
              'You have unsaved changes. Do you want to discard them and leave the page?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('Discard'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      );
      return discardChanges ?? false;
    }
    return true;
  }

  void _onSavePressed() {
    if (_emailController.text != widget.email) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationPage(
            onVerificationSuccess: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(userRole: widget.role),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Profile updated successfully')),
              );
            },
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
      setState(() {
        _hasUnsavedChanges = false;
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Full Name
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Email
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
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
                          _hasUnsavedChanges = true;
                        });
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
                          _hasUnsavedChanges = true;
                        });
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
                          _hasUnsavedChanges = true;
                        });
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
                        _hasUnsavedChanges = true;
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
                        _hasUnsavedChanges = true;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  // Profile Photo
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _profilePhoto = "Uploaded"; // Placeholder for logic
                        _hasUnsavedChanges = true;
                      });
                    },
                    child: Text('Upload Profile Photo'),
                  ),
                  SizedBox(height: 20),
                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onSavePressed,
                      child: Text('Save Profile'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
