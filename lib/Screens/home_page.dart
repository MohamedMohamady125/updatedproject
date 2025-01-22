import 'package:flutter/material.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  final String userRole;

  HomePage({required this.userRole});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Welcome to the Home Page!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Marketplace',
          ),
        ],
        onTap: (index) {
          // Navigate based on selected tab
          switch (index) {
            case 0:
              // Stay on Home
              break;
            case 1:
              // Navigate to Profile Page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    fullName: 'John Doe', // Pass actual user data here
                    email: 'john.doe@example.com', // Replace with dynamic data
                    role: userRole, // Replace with actual user role
                  ),
                ),
              );
              break;
            case 2:
              // Navigate to Events Page (not implemented here)
              break;
            case 3:
              // Navigate to Community Page (not implemented here)
              break;
            case 4:
              // Navigate to Marketplace Page (not implemented here)
              break;
          }
        },
      ),
    );
  }
}
