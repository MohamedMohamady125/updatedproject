import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My first app'),
          centerTitle: true,
          backgroundColor: Colors.lightBlue,
        ),
        body: Center(
          child: Text(
            'hello ninjas',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Colors.blue[600]!,
              fontFamily: 'Inter',
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('Button Pressed'); // Add any action here
          },
          child: Text('press'),
        ),
      ),
    ));
