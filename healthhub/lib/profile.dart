import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:healthhub/dashboard1.dart';
import 'package:healthhub/doctor.dart';
import 'package:healthhub/history.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  final String userId; // Pass email instead of userId
  ProfilePage({required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 3; // Set Profile as the selected index

  String firstName = '';
  String lastName = '';
  String Gender = '';
  String dateOfBirth = '';
  String status = '';

  // Controllers for editing
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
    genderController.text = Gender;
    dobController.text = dateOfBirth;
  }

  // Function to fetch user data from the API
  Future<void> fetchUserData() async {
    final response = await http.get(Uri.parse(
        'http://localhost:8002/api/user/${widget.userId}')); // Fetch data based on email

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        firstName = data['firstName'] ?? '';
        lastName = data['lastName'] ?? '';
        Gender = data['gender'] ?? '';
        dateOfBirth = data['dateOfBirth']?.split('T')[0] ?? '';
        status = data['status'] ?? '';
        genderController.text = Gender;
        dobController.text = dateOfBirth;
      });
    } else {
      print('Failed to load user data: ${response.statusCode}');
    }
  }

  // Function to update user details
  Future<void> updateUserDetails(String gender, String dateOfBirth) async {
    final response = await http.put(
      Uri.parse(
          'http://localhost:8002/api/user_profile/${widget.userId}'), // Use email in the URL
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'gender': gender,
        'dateOfBirth': dateOfBirth,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        gender = data['user']['gender']; // Update the Gender variable
        dateOfBirth = data['user']['dateOfBirth']
            .split('T')[0]; // Update dateOfBirth variable
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    } else {
      print('Failed to update profile: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile')),
      );
    }
  }

  void _showEditDialog(String field) {
    if (field == 'Gender') {
      genderController.text = Gender;
    } else if (field == 'Date of Birth') {
      dobController.text = dateOfBirth;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $field'),

          content: TextField(
            controller: field == 'Gender' ? genderController : dobController,
            decoration: InputDecoration(labelText: 'Enter your $field'),
          ),
          //SizedBox(height: 10.0),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Ensure the input is not empty
                if (field == 'Gender' && genderController.text.isNotEmpty) {
                  await updateUserDetails(
                      genderController.text, dobController.text);
                  fetchUserData();
                } else if (field == 'Date of Birth' &&
                    dobController.text.isNotEmpty) {
                  await updateUserDetails(Gender, dobController.text);
                  fetchUserData();
                } else {
                  // Optionally show an error message if the input is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid value')),
                  );
                }
                Navigator.pop(context); // Close the dialog after updating
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80.0,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.person,
                    size: 80.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  '$firstName $lastName',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Email: ${widget.userId}',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to change password screen
                  },
                  child: Text('Change Password'),
                ),
                SizedBox(height: 10.0),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Email'),
                  subtitle: Text(widget.userId),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.male),
                  title: Text("Gender"),
                  subtitle: Text(Gender),
                  trailing: Icon(Icons.edit),
                  onTap: () {
                    _showEditDialog('Gender'); // Edit gender
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.cake),
                  title: Text('Date of Birth'),
                  subtitle: Text(dateOfBirth),
                  trailing: Icon(Icons.edit),
                  onTap: () {
                    _showEditDialog('Date of Birth'); // Edit date of birth
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.work),
                  title: Text('Status'),
                  subtitle: Text(status),
                ),
                Divider(),
              ],
            ),
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

  // Function to handle bottom navigation taps
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
        // Stay on the same page (Profile)
        break;
    }
  }
}
