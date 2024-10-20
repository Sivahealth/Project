import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AmbulancePage extends StatelessWidget {
  const AmbulancePage({super.key});

  // Method to launch the phone dialer with the ambulance number
  void _callAmbulance() async {
    const phoneNumber = 'tel:0112255255';
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      // Handle error if the phone number can't be launched
      // Show a snackbar or alert to inform the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Siva Health Hub - Ambulance',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20),
              const Text(
                'Need an Ambulance?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Call us at: 0112 255 255',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: _callAmbulance,
                icon: const Icon(Icons.phone),
                label: const Text(
                  'Call Ambulance',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(178, 0, 119, 255), // Dark Blue
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                '24-hour service Available!',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
