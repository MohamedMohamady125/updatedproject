import 'package:flutter/material.dart';
import '../auth/verification_page.dart';

class LoginPage extends StatefulWidget {
  final bool isResetPasswordMode;

  LoginPage({this.isResetPasswordMode = false});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool get isResetPasswordMode => widget.isResetPasswordMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isResetPasswordMode ? 'Reset Password' : 'Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isResetPasswordMode
                    ? "Enter your new password"
                    : "Login to your account",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                readOnly: isResetPasswordMode, // Email is not editable in reset mode
              ),
              SizedBox(height: 16),
              // Password or New Password Field
              if (!isResetPasswordMode)
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              // New Password Field (Reset Password Mode)
              if (isResetPasswordMode)
                TextFormField(
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              SizedBox(height: 16),
              // Confirm Password Field (Reset Password Mode)
              if (isResetPasswordMode)
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              SizedBox(height: 10),
              // Forgot Password Link (Only in Normal Login Mode)
              if (!isResetPasswordMode)
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerificationPage(
                            forPasswordReset: true,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 20),
              // Login or Reset Password Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (isResetPasswordMode) {
                      if (_newPasswordController.text !=
                          _confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Passwords do not match')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Password Reset Successful!')),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LoginPage(isResetPasswordMode: false)),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Logged In Successfully')),
                      );
                    }
                  },
                  child: Text(isResetPasswordMode ? 'Reset Password' : 'Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
