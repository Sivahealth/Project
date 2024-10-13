import 'package:flutter/material.dart';
import 'package:healthhub/appointment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DoctorProfilePage extends StatefulWidget {
  final String doctorName;
  final String specialization;
  final String visitingHours;
  final String patientCount;
  String rating;
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
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  double _currentRating = 0.0;

  Future<void> updateDoctorRating(String doctorName, double rating) async {
    final url = Uri.parse('http://localhost:8002/api/rating/$doctorName');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body:
            json.encode({'rating': rating.toString()}), // Send rating as string
      );

      if (response.statusCode == 200) {
        print('Rating updated successfully');
      } else {
        print('Failed to update rating: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating rating: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        backgroundColor: widget.themeColor,
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
                backgroundImage: AssetImage(widget.imagePath),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                widget.doctorName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: widget.themeColor,
                ),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                widget.specialization,
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
                      widget.visitingHours,
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
                      widget.patientCount,
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
                      'Rating',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {
                        // Trigger the dialog to show the rating stars
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Rate this doctor'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(5, (index) {
                                      return IconButton(
                                        icon: Icon(
                                          index < _currentRating
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: Colors.yellow,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _currentRating = index + 1;

                                            double currentRating =
                                                double.parse(widget.rating);

                                            double updatedRating =
                                                (currentRating +
                                                        _currentRating) /
                                                    2;
                                            widget.rating = updatedRating
                                                .toStringAsFixed(1);

                                            updateDoctorRating(
                                                widget.doctorName,
                                                updatedRating);

                                            Navigator.pop(context);
                                          });
                                        },
                                      );
                                    }),
                                  ),
                                  SizedBox(height: 10),
                                  Text("Your rating: $_currentRating stars")
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 187, 220, 5),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '${widget.rating} Reviews',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
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
                  widget.biography,
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
                    backgroundColor: widget.buttonColor,
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
                        ),
                      ),
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
