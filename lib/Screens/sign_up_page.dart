import 'package:flutter/material.dart';
import 'role_based_home.dart'; // Import the role-based home screen
import '../models/user_role.dart'; // Import the UserRole enum

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final _phoneController = TextEditingController(); // Controller for phone number
  final _passwordController = TextEditingController(); // Controller for password
  final _confirmPasswordController = TextEditingController(); // Controller for confirm password
  UserRole? _selectedRole; // Selected role from the dropdown

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      // Check if passwords match
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      // Check if a role is selected
      if (_selectedRole == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a role')),
        );
        return;
      }

      // Simulate a sign-up process
      String phone = _phoneController.text;
      String password = _passwordController.text;
      String role = _selectedRole.toString();

      // Print sign-up details (replace with actual backend call)
      print('Phone: $phone');
      print('Password: $password');
      print('Role: $role');

      // Navigate to the role-based home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RoleBasedHome(role: role),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Phone number field
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
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
              SizedBox(height: 20), // Spacer

              // Password field
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20), // Spacer

              // Confirm password field
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20), // Spacer

              // Role dropdown
              DropdownButtonFormField<UserRole>(
                value: _selectedRole,
                decoration: InputDecoration(
                  labelText: 'Select Role',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                items: UserRole.values.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a role';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30), // Spacer

              // Sign Up button
              ElevatedButton(
                onPressed: _signUp,
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}