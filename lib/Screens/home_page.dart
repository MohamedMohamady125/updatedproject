import 'package:flutter/material.dart';
import 'profile_page.dart';
import '../community/community_screen.dart';
import 'notifications_screen.dart';
import 'cart_screen.dart';

class HomePage extends StatelessWidget {
  final String userRole;

  HomePage({required this.userRole});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          // Notifications Button
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsScreen()));
            },
          ),
          // Customer Support Button
          IconButton(
            icon: Icon(Icons.support_agent),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Customer Support'),
                    content: Text('For assistance, call us at:\n\n0101708211'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          // Cart Button
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
            },
          ),
        ],
      ),
      body: _buildRoleSpecificButtons(context, userRole),
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
          switch (index) {
            case 0:
              // Stay on Home
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    fullName: 'John Doe', // Replace with actual user data
                    email: 'john.doe@example.com', // Replace with dynamic data
                    role: userRole, // Replace with actual user role
                  ),
                ),
              );
              break;
            case 2:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Events Page is under construction')),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CommunityScreen()),
              );
              break;
            case 4:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Marketplace Page is under construction')),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildRoleSpecificButtons(BuildContext context, String role) {
    List<Widget> buttons = [];

    buttons.add(_buildButton(
      context,
      'My Orders',
      Icons.shopping_cart,
      () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrdersScreen(role: role)));
      },
    ));

    if (role == 'Swimmer' || role == 'Parent') {
      buttons.add(_buildButton(
        context,
        'My Bookings',
        Icons.book_online,
        () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyBookingsScreen()));
        },
      ));
    }

    if (role == 'Clinic' || role == 'Coach' || role == 'Academy' || role == 'Online Store' || role == 'Store') {
      buttons.add(_buildButton(
        context,
        'My Branches',
        Icons.store,
        () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyBranchesScreen(role: role)));
        },
      ));
    }

    if (role == 'Online Academy') {
      buttons.add(_buildButton(
        context,
        'My Programs',
        Icons.book,
        () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyProgramsScreen()));
        },
      ));
    }

    if (role == 'Swimmer') {
      buttons.add(_buildButton(
        context,
        'Register Myself',
        Icons.person_add,
        () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterBranchScreen(role: role)));
        },
      ));
    }

    if (role == 'Parent') {
      buttons.add(_buildButton(
        context,
        'My Children',
        Icons.child_care,
        () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyChildrenScreen()));
        },
      ));
    }

    if (role == 'Clinic' || role == 'Coach' || role == 'Academy') {
      buttons.add(_buildButton(
        context,
        'My Services',
        Icons.miscellaneous_services,
        () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyServicesScreen(role: role)));
        },
      ));
    }

    if (role == 'Online Store' || role == 'Store') {
      buttons.add(_buildButton(
        context,
        'My Products',
        Icons.shopping_bag,
        () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyProductsScreen(role: role)));
        },
      ));
    }

    if (role == 'Event Organizer') {
      buttons.add(_buildButton(
        context,
        'Create Event',
        Icons.event,
        () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateEventScreen()));
        },
      ));
    }

    return ListView(
      padding: EdgeInsets.all(16),
      children: buttons,
    );
  }

  Widget _buildButton(BuildContext context, String label, IconData icon, VoidCallback onPressed) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, size: 40),
        title: Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        onTap: onPressed,
      ),
    );
  }
}
