import 'package:flutter/material.dart';
import 'home_page.dart';
import 'create_account_screen.dart';
import '../screens/ForgotPasswordEmailScreen.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 79, 165, 245), // Background color
      body: Center(
        child: Container(
          width: 350, // Adjust width to make the card centered
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(31, 0, 0, 0), // Light shadow
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                "SIGN IN TO YOUR ACCOUNT",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 79, 165, 245),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              // Email Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: const Color.fromARGB(
                      255, 240, 240, 240), // Light gray background
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                        color: Colors.transparent), // Transparent border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: const Color.fromARGB(
                          255, 79, 165, 245), // Blue border on focus
                      width: 2.0,
                    ),
                  ),
                  labelStyle: TextStyle(color: Colors.grey), // Default color
                  floatingLabelStyle: TextStyle(
                    color: const Color.fromARGB(
                        255, 79, 165, 245), // Label color on focus
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none, // No border
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              // Password Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: const Color.fromARGB(
                      255, 240, 240, 240), // Light gray background
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                        color: Colors.transparent), // Transparent border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: const Color.fromARGB(
                          255, 79, 165, 245), // Blue border on focus
                      width: 2.0,
                    ),
                  ),
                  labelStyle: TextStyle(color: Colors.grey), // Default color
                  floatingLabelStyle: TextStyle(
                    color: const Color.fromARGB(
                        255, 79, 165, 245), // Label color on focus
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none, // No border
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              // Sign In Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to HomePage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                            userRole:
                                'Swimmer'), // Pass user role or relevant data
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 79, 165, 245), // Match the background color
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Make the text white
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Forgot Password
              GestureDetector(
                onTap: () {
                  // Navigate to Forgot Password Email Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordEmailScreen(),
                    ),
                  );
                },
                child: Text(
                  "Forgot your password?",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 79, 165, 245),
                    
                  ),
                ),
              ),
              SizedBox(height: 24),
              Divider(color: const Color.fromARGB(255, 158, 158, 158)),
              SizedBox(height: 24),
              // Create Account Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateAccountPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 79, 165, 245), // Match the background color
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'CREATE ACCOUNT',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Make the text white
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