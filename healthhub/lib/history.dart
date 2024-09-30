import 'package:flutter/material.dart';
import 'package:healthhub/doctor.dart';
import 'dashboard1.dart';
import 'profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // To decode JSON responses
import 'package:intl/intl.dart'; // Add this import

class AppointmentHistoryPage extends StatefulWidget {
  final String userId;

  AppointmentHistoryPage({required this.userId});

  @override
  _AppointmentHistoryPageState createState() => _AppointmentHistoryPageState();
}

class _AppointmentHistoryPageState extends State<AppointmentHistoryPage> {
  int _selectedIndex = 2; // Set History as the selected index
  List<Map<String, dynamic>> appointments = [];
  bool isLoading = true; // To show a loading indicator while fetching data

  @override
  void initState() {
    super.initState();
    fetchAppointments(); // Fetch appointments when the page loads
  }

  Future<void> fetchAppointments() async {
    // Construct the URL with the email query parameter
    final url = Uri.parse(
      'http://localhost:8002/api/appointments_by_usersId?email=${widget.userId}', // Assuming userId is an email
    );

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<Map<String, dynamic>> tempAppointments = [];

        for (var appointment in data) {
          // Fetch the doctor's name for each appointment
          final doctorId = appointment['doctorId'];

          // Construct the correct API URL for fetching doctor name by ID
          final doctorNameUrl = Uri.parse(
            'http://localhost:8002/api/doctors/$doctorId',
          );

          final doctorNameResponse = await http.get(doctorNameUrl, headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          });

          String doctorName =
              "Unknown Doctor"; // Default value if name not found

          if (doctorNameResponse.statusCode == 200) {
            final doctorData = json.decode(doctorNameResponse.body);
            doctorName =
                doctorData['name'] ?? "Unknown Doctor"; // Safely get the name
          }

          // Add the appointment with the doctor's name
          tempAppointments.add({
            'doctor': doctorName,
            'department': appointment['department'],
            'date': DateFormat('yyyy-MM-dd').format(DateTime.parse(
                appointment['appointmentDate'])), // Format the date
            'time': appointment['timeSlot'],
          });
        }

        // Update the state with fetched appointments
        setState(() {
          appointments = tempAppointments;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load appointments');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false; // Stop loading even if there's an error
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Dashboard1(userId: widget.userId)),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => OPDDoctorPage(userId: widget.userId)),
        );
        break;
      case 2:
        break; // Stay on the same page (History)
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ProfilePage(userId: widget.userId)),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment History'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  // Display the userId
                  SizedBox(height: 20),
                  Text(
                    'User ID: ${widget.userId}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                      height:
                          20), // Add some space between the text and the appointments
                  Expanded(
                    child: ListView.builder(
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        final appointment = appointments[index];

                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      appointment['doctor'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      appointment['department'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_today,
                                            color: Colors.grey),
                                        SizedBox(width: 10),
                                        Text(
                                          appointment['date'],
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Icon(Icons.access_time,
                                            color: Colors.grey),
                                        SizedBox(width: 5),
                                        Text(
                                          appointment['time'],
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
