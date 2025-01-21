import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String userRole;

  HomePage({required this.userRole});

  @override
  Widget build(BuildContext context) {
    bool isSwimmerOrParent =
        userRole == 'Swimmer' || userRole == 'Parent'; // Extra 'Book' button
    bool isStoreOrOnlineStore =
        userRole == 'Store' || userRole == 'Online Store'; // No cart or marketplace

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            // Search Bar
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            // Notifications Button
            if (!isStoreOrOnlineStore)
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  // Handle notifications click
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Notifications clicked')),
                  );
                },
              ),
            // Cart Button
            if (!isStoreOrOnlineStore)
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  // Handle cart click
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Cart clicked')),
                  );
                },
              ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Home Page!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Book Button for Swimmers and Parents
            if (isSwimmerOrParent)
              ElevatedButton(
                onPressed: () {
                  // Handle book button click
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Book button clicked')),
                  );
                },
                child: Text('Book'),
              ),
          ],
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
          if (!isStoreOrOnlineStore)
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: 'Marketplace',
            ),
        ],
        onTap: (index) {
          // Handle navigation based on the selected index
          switch (index) {
            case 0:
              // Home
              break;
            case 1:
              // Profile
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Navigate to Profile')),
              );
              break;
            case 2:
              // Events
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Navigate to Events')),
              );
              break;
            case 3:
              // Community
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Navigate to Community')),
              );
              break;
            case 4:
              // Marketplace (if applicable)
              if (!isStoreOrOnlineStore) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Navigate to Marketplace')),
                );
              }
              break;
          }
        },
      ),
    );
  }
}
