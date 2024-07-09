import 'package:flutter/material.dart';

class AmbulancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Siva Health Hub - Ambulance',
          style: TextStyle(
            color: Colors.white, // Set text color to white
          ),
        ),
        backgroundColor:
            Color.fromARGB(255, 26, 34, 199), // Theme color changed to blue
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png', // Replace with the path to your logo.png image
                width: 200,
                height: 200,
              ),
              SizedBox(height: 20),
              Text(
                'Need an Ambulance?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color:
                      Color.fromARGB(255, 0, 0, 0), // Set text color to black
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Call us at: 0112 XXX XXX',
                style: TextStyle(
                  fontSize: 18,
                  color:
                      Color.fromARGB(255, 0, 0, 0), // Set text color to black
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  // Handle the ambulance booking logic here
                },
                icon: Icon(Icons.phone),
                label: Text(
                  'Call Ambulance',
                  style: TextStyle(
                    color: Color.fromARGB(
                        255, 255, 255, 255), // Set text color to white
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(
                      255, 26, 34, 199), // Button color changed to blue
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(
                        255, 255, 255, 255), // Set text color to white
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                '24 hour service Available!',
                style: TextStyle(
                  fontSize: 24,
                  color:
                      Color.fromARGB(255, 0, 0, 0), // Set text color to black
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      backgroundColor:
          Color.fromARGB(255, 255, 255, 255), // Background color set to white
    );
  }
}
