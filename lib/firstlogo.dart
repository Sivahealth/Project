import 'package:flutter/material.dart';
import 'dart:async';

// ignore: unused_import
import 'package:healthhub/icon1.dart'; // For Timer

class FirstLogo extends StatefulWidget {
  @override
  _FirstLogoState createState() => _FirstLogoState();
}

class _FirstLogoState extends State<FirstLogo> {
  @override
  void initState() {
    super.initState();
    // Navigate to the login_view screen after 2 seconds
    Timer(Duration(seconds: 2), () {
      //Navigator.of(context).pushReplacementNamed('/login_view');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => IconScreen1()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Image.asset(
          'assets/logo.png', // Path to the icon in the assets folder
          width: 200.0, // Adjust the width as needed
          height: 200.0, // Adjust the height as needed
        ),
      ),
    );
  }
}
