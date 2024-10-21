import 'package:flutter/material.dart';
import 'package:healthhub/constants.dart';
import 'package:healthhub/dashboard1.dart';
import 'package:healthhub/history.dart';
import 'package:healthhub/profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:healthhub/appointment.dart';
import 'package:healthhub/doctorlist.dart';

class OPDDoctorPage extends StatefulWidget {
  @override
  _OPDDoctorPageState createState() => _OPDDoctorPageState();
  final String userId;
  const OPDDoctorPage({super.key, required this.userId});
}

class _OPDDoctorPageState extends State<OPDDoctorPage> {
  List<Map<String, dynamic>> doctors = [];
  DateTime? selectedDate;
  String? selectedDepartment;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedDepartment = 'OPD'; // Default department
    fetchDoctorsByDateAndDepartment(selectedDate!, selectedDepartment!);
  }

  void fetchDoctorsByDateAndDepartment(DateTime date, String department) async {
    const ApiUrl = '$apiUrl/api/doctors/by-date';

    final formattedDate =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    final body = json.encode({
      'availableDate': formattedDate,
      'department': department,
    });

    final response = await http.post(
      Uri.parse(ApiUrl),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      try {
        List<dynamic> data = json.decode(response.body);

        if (data.isNotEmpty) {
          setState(() {
            doctors = data.map((doctor) {
              List<String> availableTimes = [];
              if (doctor['availableTime'] != null) {
                availableTimes = doctor['availableTime'].toString().split(',');
              }

              return {
                'name': doctor['name'],
                'department': doctor['department'],
                'availableTime': availableTimes,
                '_id': doctor['_id'],
              };
            }).toList();
          });
        } else {
          setState(() {
            doctors = []; // No doctors available
          });
        }
      } catch (e) {
        print('Error decoding response data: $e');
      }
    } else {
      print('Failed to load doctors: ${response.statusCode}');
    }
  }

  void handleDateChange(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    fetchDoctorsByDateAndDepartment(date, selectedDepartment!);
  }

  void handleDepartmentChange(String? department) {
    setState(() {
      selectedDepartment = department;
    });
    fetchDoctorsByDateAndDepartment(selectedDate!, department!);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to different pages based on index
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Dashboard1(userId: widget.userId)),
        );
        break;
      case 1:
        // Stay on the same page (Schedule)
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 1, 60, 109),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Schedule Appointments',
            style: TextStyle(
              color: Colors.black, // Clean text color
              fontSize: 22.0,
              // fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor:
              const Color(0xFF008CFF), // Brighter, professional blue
          elevation: 5,
          shadowColor: Colors.blueAccent, // Adds a shadow to the app bar
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Text(
                                'Appointment Date:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 30),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(
                                        0xFF4A90E2), // Professional blue
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  onPressed: () async {
                                    final DateTime? picked =
                                        await showDatePicker(
                                      context: context,
                                      initialDate:
                                          selectedDate ?? DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );
                                    if (picked != null) {
                                      handleDateChange(picked);
                                    }
                                  },
                                  child: Text(
                                    selectedDate != null
                                        ? selectedDate!
                                            .toString()
                                            .substring(0, 10)
                                        : 'Select Date',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedDepartment,
                            items: const [
                              DropdownMenuItem(
                                  value: 'OPD', child: Text('OPD')),
                              DropdownMenuItem(
                                  value: 'Physiotherapy',
                                  child: Text('Physiotherapy')),
                            ],
                            onChanged: handleDepartmentChange,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            hint: const Text('Select Department'),
                            isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 16.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorsListPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Find doctor',
                      style: TextStyle(
                        color: Colors.blue[700],
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
              // Show only the last doctor (updated doctor)
              doctors.isNotEmpty
                  ? DoctorCard(
                      doctor: doctors.last,
                      selectedDate: selectedDate,
                      userId: widget.userId,
                    )
                  : const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'No doctors available for the selected date.',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
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
      ),
    );
  }
}

class DoctorCard extends StatefulWidget {
  final Map<String, dynamic> doctor;
  final DateTime? selectedDate;
  var userId;

  DoctorCard(
      {super.key,
      required this.doctor,
      required this.selectedDate,
      required this.userId});

  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  final _formKey = GlobalKey<FormState>();
  String? selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    if (widget.doctor['availableTime'].isNotEmpty) {
      selectedTimeSlot =
          widget.doctor['availableTime'][0]; // Set default time slot
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> availableSlots = widget.doctor['availableTime'];

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.doctor['name'],
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Department: ${widget.doctor['department']}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 30),
                DropdownButtonFormField<String>(
                  value: selectedTimeSlot,
                  items: availableSlots.map((String slot) {
                    return DropdownMenuItem<String>(
                      value: slot,
                      child: Text(slot),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTimeSlot = newValue!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Time Slot',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a time slot';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppointmentBookingPage(
                            doctorName: widget.doctor['name'],
                            Time: '$selectedTimeSlot',
                            Date: '${widget.selectedDate}',
                            doctorId: widget.doctor['_id'],
                            userId: widget.userId,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF008CFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    'Confirm Appointment',
                    style: TextStyle(color: Colors.white), // Updated to white
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
