import 'package:healthhub/dashboard1.dart';
import 'package:healthhub/doctor.dart';
import 'package:healthhub/firstlogo.dart';
import 'package:flutter/material.dart';
import 'package:healthhub/dashboard.dart';
import 'package:healthhub/login_view.dart';
import 'package:healthhub/reports.dart';
import 'package:healthhub/signUp.dart';
import 'package:logging/logging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _setupLogging();

  // Socket connection test

  runApp(const MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;

  // Add a handler that prints to the console
  Logger.root.onRecord.listen((record) {
    print(
        '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
    if (record.error != null) {
      print('Error: ${record.error}');
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
