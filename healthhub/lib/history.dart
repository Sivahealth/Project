import 'package:flutter/material.dart';
import 'package:healthhub/doctor.dart';
import 'dashboard1.dart';
import 'profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // To decode JSON responses
import 'package:intl/intl.dart'; // Add this import

class AppointmentHistoryPage extends StatefulWidget {
  final String userId;

  const AppointmentHistoryPage({super.key, required this.userId});

  @override
  _AppointmentHistoryPageState createState() => _AppointmentHistoryPageState();
}

class _AppointmentHistoryPageState extends State<AppointmentHistoryPage> {
  int _selectedIndex = 2; // Set History as the selected index
  List<Map<String, dynamic>> appointments = [];
  List<Map<String, dynamic>> filteredAppointments = [];
  bool isLoading = true; // To show a loading indicator while fetching data
  final TextEditingController _dateController = TextEditingController();
  DateTime? selectedDate; // To store the selected date

  @override
  void initState() {
    super.initState();
    fetchAppointments(); // Fetch appointments when the page loads
  }

  Future<void> fetchAppointments() async {
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
          filteredAppointments =
              tempAppointments; // Initialize filtered appointments
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

  void filterAppointments(String date) {
    setState(() {
      filteredAppointments = appointments.where((appointment) {
        return appointment['date'] == date; // Filter based on the selected date
      }).toList();
    });
  }

  // Function to select date from the calendar
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
        _dateController.text =
            formattedDate; // Update the text field with selected date
        filterAppointments(
            formattedDate); // Filter appointments based on selected date
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
        title: const Text('Appointment History'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'User ID: ${widget.userId}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${filteredAppointments.length} Appointments ',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _dateController,
                    readOnly: true, // Make the TextField read-only
                    decoration: InputDecoration(
                      labelText: 'Select date (YYYY-MM-DD)',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),

                        onPressed: () =>
                            _selectDate(context), // Open the date picker
                      ),
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                  const SizedBox(height: 20), // Add some space
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredAppointments.length,
                      itemBuilder: (context, index) {
                        final appointment = filteredAppointments[index];

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(165, 0, 183, 255),
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
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      appointment['doctor'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      appointment['department'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_today,
                                            color: Colors.black),
                                        const SizedBox(width: 10),
                                        Text(
                                          appointment['date'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        const Icon(Icons.access_time,
                                            color: Colors.black),
                                        const SizedBox(width: 5),
                                        Text(
                                          appointment['time'],
                                          style: const TextStyle(
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
