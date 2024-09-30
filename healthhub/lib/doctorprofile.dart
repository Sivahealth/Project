import 'package:flutter/material.dart';
import 'package:healthhub/appointment.dart';

class DoctorProfilePage extends StatelessWidget {
  final String doctorName;
  final String specialization;
  final String visitingHours;
  final String patientCount;
  final String rating;
  final String biography;
  final String imagePath;
  final Color themeColor;
  final Color buttonColor;

  DoctorProfilePage({
    required this.doctorName,
    required this.specialization,
    required this.visitingHours,
    required this.patientCount,
    required this.rating,
    required this.biography,
    required this.imagePath,
    this.themeColor = Colors.blue,
    this.buttonColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        backgroundColor: themeColor,
        leading: Icon(Icons.arrow_back, color: Colors.white),
        actions: [
          Icon(Icons.notifications, color: Colors.white),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(imagePath),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                doctorName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: themeColor,
                ),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                specialization,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Visiting hour',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      visitingHours,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Patients',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      patientCount,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.star, color: themeColor),
                    SizedBox(height: 4),
                    Text(
                      '$rating Review',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Biography',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  biography,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentBookingPage(
                                doctorName: '',
                                Time: '',
                                doctorId: '',
                                Date: '',
                                userId: '',
                              )),
                    );
                  },
                  child: Text(
                    'Book Appointment',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
