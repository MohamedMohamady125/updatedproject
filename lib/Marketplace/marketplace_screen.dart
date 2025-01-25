import 'package:flutter/material.dart';
import 'used_section.dart';
import 'online_store_section.dart';
import 'store_section.dart';

class MarketplaceScreen extends StatefulWidget {
  final String userRole; // To determine role-specific features

  MarketplaceScreen({required this.userRole});

  @override
  _MarketplaceScreenState createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _sections = [
      UsedSection(userRole: widget.userRole),
      OnlineStoreSection(userRole: widget.userRole),
      StoreSection(userRole: widget.userRole),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Marketplace'),
        centerTitle: true,
      ),
      body: _sections[_selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: (index) {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Used'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Online Store'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Store'),
        ],
      ),
    );
  }
}
