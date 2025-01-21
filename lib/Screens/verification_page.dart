import 'package:flutter/material.dart';

class VerificationPage extends StatelessWidget {
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Verification'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Check your email!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "We've sent you a verification code to your email. Please enter the code below to continue.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            // Verification Code Field
            TextFormField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Verification Code',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the verification code';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle verification code submission logic
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NextPage()),
                  );
                },
                child: Text('Verify and Continue'),
              ),
            ),
            SizedBox(height: 10),
            // Resend Code Option
            Center(
              child: GestureDetector(
                onTap: () {
                  // Logic to resend verification code
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Verification code resent!')),
                  );
                },
                child: Text(
                  "Didn't receive the code? Resend",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder for the next page after verification
class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome to the App!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
