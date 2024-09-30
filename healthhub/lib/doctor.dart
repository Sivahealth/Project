import 'package:flutter/material.dart';
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
  OPDDoctorPage({required this.userId});
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
    final apiUrl = 'http://localhost:8002/api/doctors/by-date';

    final formattedDate =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    final body = json.encode({
      'availableDate': formattedDate,
      'department': department,
    });

    final response = await http.post(
      Uri.parse(apiUrl),
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
        hintColor: const Color.fromARGB(255, 4, 57, 147),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Schedule Appointments',
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1), // Change the text color
              fontSize: 20.0, // Adjust the font size
              //fontWeight: FontWeight.bold, // Optional: to make the text bold
            ),
          ),
          backgroundColor: Color.fromARGB(222, 0, 140, 255),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text('Appointment Date: '),
                              SizedBox(width: 30),
                              Expanded(
                                child: ElevatedButton(
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
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedDepartment,
                            items: [
                              DropdownMenuItem(
                                  value: 'OPD', child: Text('OPD')),
                              DropdownMenuItem(
                                  value: 'Physiotherapy',
                                  child: Text('Physiotherapy')),
                            ],
                            onChanged: handleDepartmentChange,
                            hint: Text('Select Department'),
                            isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
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
                        color: Color.fromARGB(231, 18, 49, 255),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: doctors.length,
                itemBuilder: (BuildContext context, int index) {
                  return DoctorCard(
                    doctor: doctors[index],
                    selectedDate: selectedDate,
                    userId: widget.userId,
                  );
                },
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
      {required this.doctor, required this.selectedDate, required this.userId});

  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  final _formKey = GlobalKey<FormState>();
  String? selectedTimeSlot;

  @override
  Widget build(BuildContext context) {
    List<String> availableSlots = widget.doctor['availableTime'].cast<String>();

    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.doctor['name'],
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text('Department: ${widget.doctor['department']}'),
              DropdownButtonFormField<String>(
                items: availableSlots
                    .map((slot) => DropdownMenuItem(
                          value: slot.trim(),
                          child: Text(slot.trim()),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedTimeSlot = value;
                  });
                },
                hint: Text('Select a time slot'),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a time slot';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
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
                child: Text('Select'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
