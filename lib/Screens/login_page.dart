import 'package:flutter/material.dart';
import 'role_based_home.dart'; // Import the role-based home screen

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final _phoneController = TextEditingController(); // Controller for phone number
  final _passwordController = TextEditingController(); // Controller for password

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Simulate a login process
      String phone = _phoneController.text;
      String password = _passwordController.text;

      // Print login details (replace with actual backend call)
      print('Phone: $phone');
      print('Password: $password');

      // Navigate to the role-based home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RoleBasedHome(role: 'swimmer'), // Replace with actual role from backend
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30), // Spacer

              // Login button
              ElevatedButton(
                onPressed: _login,
                child: Text(
                  'Login',
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