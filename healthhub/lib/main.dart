// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:healthhub/ambulance.dart';
import 'package:healthhub/dashboard.dart';
import 'package:healthhub/firstlogo.dart';
import 'package:healthhub/icon1.dart';
import 'package:healthhub/login_view.dart';
import 'package:healthhub/signUp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Siva Health',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/login_view': (context) => LoginPage(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(child: Text('Page not found')),
        ),
      ),
    );
  }
}
