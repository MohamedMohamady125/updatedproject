import 'package:flutter/material.dart';
import '../auth/forgot_password_email_screen.dart';

class ForgotPasswordCodeScreen extends StatelessWidget {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 79, 165, 245), // Background color
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
                "ENTER RESET CODE",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 79, 165, 245),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              // Instruction Text
              Text(
                "Enter the 6-digit code sent to your email.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Code Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: 40,
                    child: TextField(
                      controller: _controllers[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(255, 240, 240, 240), // Light gray background
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 79, 165, 245), // Visible blue border
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 79, 165, 245), // Blue border on focus
                            width: 2.0,
                          ),
                        ),
                        counterText: '', // Remove the counter
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Verify Code Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final code = _controllers.map((e) => e.text).join();
                    if (code.length == 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Code Verified")),
                      );
                      // Navigate back to email screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordEmailScreen(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please enter a valid 6-digit code")),
                      );
                    }
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
                    'VERIFY CODE',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Make the text white
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Go Back Button
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordEmailScreen(),
                    ),
                  );
                },
                child: Text(
                  "Go Back to Email Screen",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 79, 165, 245),
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