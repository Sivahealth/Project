import 'package:flutter/material.dart';
import 'package:healthhub/appointment.dart';
import 'package:healthhub/doctorprofile.dart';

class DoctorsListPage extends StatefulWidget {
  @override
  _DoctorsListPageState createState() => _DoctorsListPageState();
}

class _DoctorsListPageState extends State<DoctorsListPage> {
  final List<Map<String, String>> doctors = [
    {
      'name': 'Dr. Jayantha Perera',
      'specialty': 'Cardiologist',
      'location': 'Wackwella, Galle',
      'experience': '13 years experience',
      'fee': '2000',
      // No image field needed for icons
    },
    {
      'name': 'Dr. Deepika Silva',
      'specialty': 'Dermatologist',
      'location': 'Kollupitiya, Colombo',
      'experience': '10 years experience',
      'fee': '1500',
    },
    {
      'name': 'Dr. Shriyantha Mendis',
      'specialty': 'Dermatologist',
      'location': 'Kottawa, Sri Lanka',
      'experience': '10 years experience',
      'fee': '1800',
    },
    {
      'name': 'Dr. Kalum Jayawardene',
      'specialty': 'Physician',
      'location': 'Kurunegala, Sri Lanka',
      'experience': '10 years experience',
      'fee': '1600',
    },
    // Add more doctor profiles here...
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Doctors'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search doctor...',
                prefixIcon: Icon(Icons.search),
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
                    doctor['specialty']!.toLowerCase().contains(searchQuery) ||
                    doctor['location']!.toLowerCase().contains(searchQuery)) {
                  return Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              radius: 35.0, // Radius of the CircleAvatar
                              backgroundColor:
                                  Colors.grey[300], // Background color
                              child: Icon(
                                Icons.person, // Profile icon
                                size: 70.0, // Size of the icon
                                color: Color.fromARGB(
                                    255, 0, 129, 235), // Icon color
                              ),
                            ),
                            title: Text(
                              doctor['name']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(doctor['specialty']!),
                                  Text(doctor['location']!),
                                  Text(doctor['experience']!),
                                  SizedBox(height: 5.0),
                                  Text('Consultation Fee: ₹${doctor['fee']}'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
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
                                              doctorName: '',
                                              Time: '',
                                              doctorId: '',
                                              Date: '',
                                              userId: '',
                                            )),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[800],
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                ),
                                child: Text('BOOK',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle call action
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[800],
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                ),
                                child: Text('CALL',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DoctorProfilePage(
                                            doctorName:
                                                'Dr. Mangala Ganehiarachchi',
                                            specialization: 'Orthopedic',
                                            visitingHours: '10 AM to 6 PM',
                                            patientCount: '14000+',
                                            rating: '4.9',
                                            biography:
                                                'Dr. Mangala Ganehiarachchi is one of the Senior Academic staff members of a Faculty of Science in a well-recognized University. He Obtained his BSc (Special) degree with second class Honors and MPhil degree from University of Kelaniya. His MSc and PhD degrees are from North Dakota State University, USA. He is a member of the Institute of Biology in Sri Lanka. Dr. Ganehiarachchi has more than 30 years strong teaching experiences for Advanced Level Biology students. He has a thorough knowledge of the new Biology syllabus and in evaluating Biology answer scripts. He is an author of several Zoology and Biology textbooks. He is a well-trained University academic for advising teachers who teach new Biology syllabus.',
                                            imagePath: 'assets/doctor1.png'),
                                      ));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[800],
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                ),
                                child: Text('EXPERTISE',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.0),
                        ],
                      ),
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
