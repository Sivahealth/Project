import 'package:healthhub/dashboard1.dart';
import 'package:flutter/material.dart';
import 'package:healthhub/login_view.dart';
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
        '/': (context) => Dashboard1(userId: "dishansanjuka3@gmail.com"),
        '/login_view': (context) =>
            Dashboard1(userId: "dishansanjuka3@gmail.com"),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('Page not found')),
        ),
      ),
    );
  }
}
