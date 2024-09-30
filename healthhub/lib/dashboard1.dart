import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthhub/ambulance.dart';
import 'package:healthhub/doctor.dart';
import 'package:healthhub/doctorlist.dart';
import 'package:healthhub/drugslist.dart';
import 'package:healthhub/history.dart';
import 'package:healthhub/profile.dart';
import 'package:healthhub/reports.dart';
import 'package:healthhub/settings.dart';
import 'package:http/http.dart' as http;

class Dashboard1 extends StatefulWidget {
  @override
  _Dashboard1State createState() => _Dashboard1State();
  final String userId;
  Dashboard1({required this.userId});
}

class _Dashboard1State extends State<Dashboard1> {
  int _selectedIndex = 0;

  String firstName = ''; // Variable to store fetched firstName

  @override
  void initState() {
    super.initState();
    //_fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final String apiUrl = 'http://localhost:8002/api/users';
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
      backgroundColor: Color(0xFFEDF4F8),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(222, 0, 140, 255),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 25), // Space after the AppBar
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
                            Text(
                              'Hello!',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              widget.userId,
                              style: TextStyle(
                                fontSize: 20,
                                //fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          width:
                              10), // Adjust space between the text and the avatar
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/doctor1.png'),
                        radius: 50, // Adjust size as needed
                      ),
                      SizedBox(width: 40), // Space to the right of the avatar
                    ],
                  ),
                  SizedBox(height: 30),
                  // Search Bar
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Medical Services and Doctors',
                        border: InputBorder.none,
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  // Services
                  Text(
                    'Services',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
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
                                builder: (context) => Drugslist()),
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
                                builder: (context) => ReportPage()),
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
                  SizedBox(height: 24),
                  // Banner
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        top: 35,
                        right: 120,
                        bottom: 45,
                        left: 20), // Reduce left padding
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                        image: AssetImage('assets/dashboardLady.png'),
                        fit: BoxFit
                            .contain, // Scale down the image instead of stretching
                      ),
                    ),
                    child: Column(
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
                  SizedBox(height: 24),
                  // Upcoming Appointments
                  Text(
                    'Upcoming Appointments',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildAppointmentCard(
                        date: '12',
                        day: 'Tue',
                        time: '9:30 AM',
                        doctor: 'DR. SAMUEL',
                        department: 'Depression',
                        cardColor: Colors.cyanAccent,
                      ),
                      _buildAppointmentCard(
                        date: '18',
                        day: 'Wed',
                        time: '3:00 PM',
                        doctor: 'DR. SMITH',
                        department: 'Cardiology',
                        cardColor: Colors.orangeAccent,
                      ),
                    ],
                  ),
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
            TextStyle(color: Colors.black), // Text color for selected
        unselectedLabelStyle:
            TextStyle(color: Colors.black), // Text color for unselected
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
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
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
    required String time,
    required String doctor,
    required String department,
    required Color cardColor,
  }) {
    return Container(
      width: 160,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            day,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            time,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            doctor,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            department,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
