import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthhub/ambulance.dart';
import 'package:healthhub/doctor.dart';
import 'package:healthhub/doctorlist.dart';
import 'package:healthhub/drugslist.dart';
import 'package:healthhub/history.dart';
import 'package:healthhub/login_view.dart';
import 'package:healthhub/profile.dart';
import 'package:healthhub/reports.dart';
import 'package:healthhub/settings.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shelf/shelf.dart';

class Dashboard1 extends StatefulWidget {
  @override
  _Dashboard1State createState() => _Dashboard1State();
  final String userId;

  const Dashboard1({super.key, required this.userId});
}

class _Dashboard1State extends State<Dashboard1> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> appointments =
      []; // Variable to store appointments
  bool isLoading = true; // Variable to manage loading state

  String firstName = ''; // Variable to store fetched firstName

  @override
  void initState() {
    super.initState();
    //_fetchUserData();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    setState(() {
      isLoading = true; // Start loading
    });

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

        DateTime now = DateTime.now(); // Get current date and time

        for (var appointment in data) {
          // Parse the appointment date
          DateTime appointmentDate =
              DateTime.parse(appointment['appointmentDate']);

          // Check if the appointment is in the future
          if (appointmentDate.isAfter(now)) {
            // Fetch the doctor's name for each future appointment
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
              'date': DateFormat('yyyy-MM-dd')
                  .format(appointmentDate), // Format the date
              'time': appointment['timeSlot'],
            });
          }
        }

        setState(() {
          appointments = tempAppointments; // Assign fetched future appointments
          isLoading = false; // Stop loading
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

  Future<void> _fetchUserData() async {
    const String apiUrl = 'http://localhost:8002/api/users';
    try {
      final response =
          await http.get(Uri.parse('$apiUrl?email=${widget.userId}'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          firstName = data['firstName'];
        });
      } else {
        print('Failed to fetch user data');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  // Handles navigation tab switch
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle actual page navigation here
    switch (index) {
      case 0:
        //stay on dashboard
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => OPDDoctorPage(userId: widget.userId)),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AppointmentHistoryPage(userId: widget.userId)),
        );
        break;
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
      backgroundColor: const Color(0xFFEDF4F8),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0), // Increase height of AppBar
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(178, 0, 140, 255),
          elevation: 0,
          title: const Row(
            mainAxisAlignment:
                MainAxisAlignment.start, // Aligns items to the start (left)
            children: [
              Text(
                'Dashboard', // Your app title
                style: TextStyle(
                  fontSize: 24, // Increase font size
                  //fontWeight: FontWeight.bold, // Bold text
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 30.0, top: 10),
              child: Container(
                width: 35, // Width of the circle
                height: 35, // Height of the circle
                decoration: const BoxDecoration(
                  color: Colors.white, // Circle background color
                  shape: BoxShape.circle, // Make it circular
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.red, // Icon color
                    size: 18,
                  ),
                  onPressed:
                      _showLogoutConfirmationDialog, // Call your logout function
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 25), // Space after the AppBar
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Greeting
                  // Greeting with Profile Avatar
                  Row(
                    children: [
                      // Column for texts
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hello!',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.userId,
                              style: const TextStyle(
                                fontSize: 20,
                                //fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                          width:
                              10), // Adjust space between the text and the avatar
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/doctor1.png'),
                        radius: 50, // Adjust size as needed
                      ),
                      const SizedBox(
                          width: 40), // Space to the right of the avatar
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Search Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Medical Services and Doctors',
                        border: InputBorder.none,
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Services
                  const Text(
                    'Services',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildServiceButton(
                        icon: Icons.local_hospital,
                        label: 'Doctor',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DoctorsListPage()),
                          );
                        },
                      ),
                      _buildServiceButton(
                        icon: Icons.local_pharmacy,
                        label: 'Pharmacy',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Drugslist(userId: widget.userId)),
                          );
                        },
                      ),
                      _buildServiceButton(
                        icon: Icons.file_copy,
                        label: 'Reports',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ReportPage(userId: widget.userId)),
                          );
                        },
                      ),
                      _buildServiceButton(
                        icon: Icons.local_shipping,
                        label: 'Ambulance',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AmbulancePage()),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        top: 35,
                        right: 120,
                        bottom: 45,
                        left: 20), // Reduce left padding
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(25),
                      image: const DecorationImage(
                        image: AssetImage('assets/dashboardLady.png'),
                        fit: BoxFit
                            .contain, // Scale down the image instead of stretching
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Get the Best', // First part of the text
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Medical Services', // Second part of the text
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'We provide best quality medical services without further cost',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Upcoming Appointments
                  // Upcoming Appointments Section
                  const Text(
                    'Upcoming Appointments',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  isLoading
                      ? const CircularProgressIndicator()
                      : appointments.isNotEmpty
                          ? SingleChildScrollView(
                              scrollDirection: Axis
                                  .horizontal, // Horizontal scrolling enabled
                              child: Row(
                                children: appointments.map((appointment) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10.0), // Space between cards
                                    child: _buildAppointmentCard(
                                      date: appointment['date']
                                          .split('-')[2], // Extract day
                                      day: DateFormat('EEEE').format(
                                          DateTime.parse(appointment[
                                              'date'])), // Extract day of the week
                                      year: appointment['date']
                                          .split('-')[0], // Extract year
                                      month: appointment['date']
                                          .split('-')[1], // Extract month
                                      time: appointment['time'],
                                      doctor: appointment['doctor'],
                                      department: appointment['department'],
                                      cardColor: Colors.primaries[
                                          (appointments.indexOf(appointment) +
                                                  1) %
                                              Colors.primaries.length],
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          : const Text(
                              'No upcoming appointments',
                              style: TextStyle(fontSize: 16),
                            ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Fixes the shifting behavior
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue, // Set color for selected item
        unselectedItemColor: Colors.black, // Set color for unselected items
        selectedLabelStyle:
            const TextStyle(color: Colors.black), // Text color for selected
        unselectedLabelStyle:
            const TextStyle(color: Colors.black), // Text color for unselected
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

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Do you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog and stay on the same page
              },
              child: const Text('Stay'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _logout(); // Call the logout function
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    // Navigate to the login page (replace LoginPage with your actual login page class)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Widget _buildServiceButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // Shows clickable cursor on hover
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentCard({
    required String date,
    required String day,
    required String year,
    required String month,
    required String time,
    required String doctor,
    required String department,
    required Color cardColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.start, // Align items to the start of the row
            children: [
              Container(
                padding: const EdgeInsets.all(10), // Add padding for the circle
                decoration: const BoxDecoration(
                  shape: BoxShape.circle, // Make it circular
                  color: Colors.blue, // Background color of the circle
                ),
                child: Text(
                  date,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white, // Text color inside the circle
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                month,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 3),
              Text(
                year,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                'Time: $time',
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            day,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Doctor: $doctor',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            'Department: $department',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
