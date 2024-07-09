import 'package:flutter/material.dart';
import 'package:healthhub/login_view.dart';

class IconScreen3 extends StatelessWidget {
  const IconScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                  color: Color.fromARGB(255, 50, 55, 167), fontSize: 16),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Image.asset('assets/3.png'), // Path to your asset
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Get connect with our Therapists',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontFamily: 'OpenSans', // Set font to Calibri
                  ),
                ),
              ),
              const SizedBox(height: 100),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      // Define your onPressed action here
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    backgroundColor: Color.fromARGB(255, 50, 55, 167),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
