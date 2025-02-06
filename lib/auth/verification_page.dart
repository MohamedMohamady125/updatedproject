import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../users/swimmers/home_page.dart';
import '../users/coaches/home_page.dart';
import '../users/academies/home_page.dart';
import '../users/vendors/home_page.dart';

class VerificationPage extends StatelessWidget {
  final bool forPasswordReset;
  final VoidCallback? onVerificationSuccess;

  VerificationPage({super.key, this.forPasswordReset = false, this.onVerificationSuccess});

  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 79, 165, 245),
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(31, 0, 0, 0),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "EMAIL VERIFICATION",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 79, 165, 245),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Text(
                "We've sent you a verification code to your email. Please enter the code below to continue.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
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
                        fillColor: const Color.fromARGB(255, 240, 240, 240),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 79, 165, 245),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 79, 165, 245),
                            width: 2.0,
                          ),
                        ),
                        counterText: '',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final code = _controllers.map((e) => e.text).join();
                    if (code.length == 6) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? userRole = prefs.getString('user_role');

                      print(
                          "Retrieved user role: \$userRole"); // Debugging print

                      if (userRole != null && userRole.isNotEmpty) {
                        _navigateToHomePage(context, userRole);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  "User role not found. Please log in again.")),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter a valid code.")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 79, 165, 245),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'VERIFY CODE',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
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

  void _navigateToHomePage(BuildContext context, String userRole) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'user_role', userRole); // Ensure it's stored correctly

    print("Navigating to home page with role: $userRole");

    Widget homePage;
    switch (userRole) {
      case 'Swimmer or Parent': // ✅ Handle both as one
        homePage = SwimmerHomePage(userRole: userRole);
        break;
      case 'Coach':
        homePage = CoachHomePage();
        break;
      case 'Academy':
        homePage = AcademyHomePage();
        break;
      case 'Vendor':
        homePage = VendorHomePage();
        break;
      default:
        print("User role not found!"); // Debugging
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User role not found. Please log in again.")),
        );
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => homePage),
    );
  }
}
