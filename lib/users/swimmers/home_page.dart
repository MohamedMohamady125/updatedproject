import 'package:flutter/material.dart';
import '../../profile/profile_page.dart';
import '../../shared/events/events_screen.dart';
import '../../shared/community/community_screen.dart';
import '../../shared/marketplace/marketplace_screen.dart';
import '../swimmers/my_bookings_screen.dart';
import '../swimmers/my_orders_screen.dart';
import '../swimmers/my_children_screen.dart';

class SwimmerHomePage extends StatelessWidget {
  final String userRole;

  SwimmerHomePage({required this.userRole});

  @override
  Widget build(BuildContext context) {
    print('Current user role: $userRole');

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.support_agent),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Customer Support'),
                  content: Text('For assistance, call us at:\n\n0101708211'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: _buildRoleSpecificButtons(context, userRole),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Marketplace'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    fullName: 'John Doe',
                    email: 'john.doe@example.com',
                    role: userRole,
                  ),
                ),
              );
              break;
            case 2:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EventsScreen()));
              break;
            case 3:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CommunityScreen()));
              break;
            case 4:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MarketplaceScreen(userRole: userRole)));
              break;
          }
        },
      ),
    );
  }

  Widget _buildRoleSpecificButtons(BuildContext context, String role) {
    print('Building buttons for role: $role');

    List<Widget> buttons = [];

    buttons.add(_buildButton(
      context,
      'My Orders',
      Icons.shopping_cart,
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyOrdersScreen(role: userRole),
        ),
      ),
    ));

    if (role.toLowerCase() == 'swimmer' || role.toLowerCase() == 'parent') {
      print('Adding bookings button for $role');
      buttons.add(_buildButton(
        context,
        'My Bookings',
        Icons.book_online,
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyBookingsScreen())),
      ));
    }

    if (role.toLowerCase() == 'parent') {
      buttons.add(_buildButton(
        context,
        'My Children',
        Icons.child_care,
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyChildrenScreen())),
      ));
    }

    return ListView(
      padding: EdgeInsets.all(16),
      children: buttons,
    );
  }

  Widget _buildButton(BuildContext context, String label, IconData icon,
      VoidCallback onPressed) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, size: 40),
        title: Text(label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        onTap: onPressed,
      ),
    );
  }
}