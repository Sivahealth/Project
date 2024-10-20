import 'package:healthhub/login_view.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class FirstLogo extends StatefulWidget {
  const FirstLogo({super.key});

  @override
  _FirstLogoState createState() => _FirstLogoState();
}

class _FirstLogoState extends State<FirstLogo> {
  @override
  void initState() {
    super.initState();
    // Navigate to the login_view screen after 2 seconds
    Timer(const Duration(seconds: 2), () {
      //Navigator.of(context).pushReplacementNamed('/login_view');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 200.0,
          height: 200.0,
        ),
      ),
    );
  }
}
