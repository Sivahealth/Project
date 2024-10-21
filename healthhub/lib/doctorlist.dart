import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:healthhub/constants.dart';
import 'package:http/http.dart' as http;
import 'package:healthhub/appointment.dart';
import 'package:healthhub/doctorprofile.dart';

class DoctorsListPage extends StatefulWidget {
  const DoctorsListPage({super.key});

  @override
  _DoctorsListPageState createState() => _DoctorsListPageState();
}

class _DoctorsListPageState extends State<DoctorsListPage> {
  List<Map<String, dynamic>> doctors = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchDoctors(); // Fetch doctors when the widget is initialized
  }

  Future<void> fetchDoctors() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/api/doctorsFind'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          // Map the API response to your UI format
          doctors = data.map((doctor) {
            return {
              'name': doctor['name'],
              'Department': doctor['department'],
              'location': doctor['city'] != null
                  ? doctor['city'].join(", ")
                  : 'Not Available',
              'experience': doctor['experience'] != null
                  ? doctor['experience'].join(", ")
                  : 'Not Available',
              'fee': doctor['consultantFee'] != null
                  ? doctor['consultantFee'].join(", ")
                  : 'Not Available',
              'visingHours': doctor['visingHours'] != null
                  ? doctor['visingHours'].join(", ")
                  : 'Not Available',
              'rating': doctor['rating'] != null
                  ? doctor['rating'].join(", ")
                  : 'Not Available',
              'description': doctor['description'] != null
                  ? doctor['description'].join(", ")
                  : 'Not Available',
            };
          }).toList();
        });
      } else {
        throw Exception('Failed to load doctors');
      }
    } catch (e) {
      print(e.toString());
      // Handle error if necessary
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Doctors'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search doctor...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                if (doctor['name']!.toLowerCase().contains(searchQuery) ||
                    doctor['Department']!.toLowerCase().contains(searchQuery) ||
                    doctor['location']!.toLowerCase().contains(searchQuery)) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              radius: 60.0,
                              backgroundColor: Colors.grey[300],
                              child: const Icon(
                                Icons.person,
                                size: 90.0,
                                color: Color.fromARGB(255, 0, 129, 235),
                              ),
                            ),
                            title: Text(
                              doctor['name']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    doctor['Department']!,
                                    style: const TextStyle(
                                        color: Colors
                                            .black), // Change text color to black
                                  ),
                                  Text(
                                    doctor['location']!,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    doctor['experience']!,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    'Consultation Fee: ${doctor['fee']}',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    children: [
                                      // Generate star icons based on rating
                                      for (int i = 1; i <= 5; i++)
                                        Icon(
                                          Icons.star,
                                          color: i <=
                                                  double.parse(
                                                      doctor['rating']!)
                                              ? const Color.fromARGB(
                                                  255, 129, 116, 2)
                                              : Colors
                                                  .grey, // Change color based on rating
                                          size: 18.0, // Size of the star
                                        ),
                                      const SizedBox(
                                          width:
                                              5.0), // Space between stars and text
                                      Text(
                                        '${doctor['rating']} / 5',
                                        style: const TextStyle(
                                            color: Colors
                                                .black), // Change text color to black
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 25.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AppointmentBookingPage(
                                              doctorName: doctor['name'],
                                              Time: '',
                                              doctorId: '',
                                              Date: '',
                                              userId: '',
                                            )),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[800],
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                ),
                                child: const Text('BOOK',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle call action
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[800],
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                ),
                                child: const Text('CALL',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DoctorProfilePage(
                                            doctorName: doctor['name']!,
                                            specialization:
                                                doctor['Department']!,
                                            visitingHours:
                                                doctor['visingHours']!,
                                            patientCount: '14000+',
                                            rating: doctor['rating'],
                                            biography: doctor['description'],
                                            imagePath: 'assets/doctor1.png'),
                                      ));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[800],
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                ),
                                child: const Text('EXPERTISE',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15.0),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
