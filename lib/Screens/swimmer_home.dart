import 'package:flutter/material.dart';
import 'shared_layout.dart';

class SwimmerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SharedLayout(
      body: Center(
        child: Text('Welcome, Swimmer!'),
      ),
      pageTitle: 'Swimmer Home',
      currentIndex: 0,
    );
  }
}