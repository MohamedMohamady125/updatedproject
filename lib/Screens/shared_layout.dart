import 'package:flutter/material.dart';

class SharedLayout extends StatefulWidget {
  final Widget body;
  final String pageTitle;
  final int currentIndex;

  SharedLayout({
    required this.body,
    required this.pageTitle,
    required this.currentIndex,
  });

  @override
  _SharedLayoutState createState() => _SharedLayoutState();
}

class _SharedLayoutState extends State<SharedLayout> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the corresponding screen based on the index
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/events');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/community');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/marketplace');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications screen
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to cart screen
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings screen
            },
          ),
        ],
      ),
      body: widget.body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
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
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Marketplace',
          ),
        ],
      ),
    );
  }
}