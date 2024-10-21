import 'dart:convert';
import 'dart:io'; // For handling files
import 'package:flutter/material.dart';
import 'package:healthhub/constants.dart';
import 'package:healthhub/dashboard1.dart';
import 'package:healthhub/doctor.dart';
import 'package:healthhub/history.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart'; // For image picking

class ProfilePage extends StatefulWidget {
  final String userId; // Pass email instead of userId
  const ProfilePage({super.key, required this.userId});

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
  File? _imageFile; // To hold the selected image

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
        '$apiUrl/api/user/${widget.userId}')); // Fetch data based on email

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
          '$apiUrl/api/user_profile/${widget.userId}'), // Use email in the URL
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
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } else {
      print('Failed to update profile: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile')),
      );
    }
  }

  // Function to upload profile picture
  Future<void> uploadProfilePicture(File imageFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$apiUrl/api/upload-profile-pic'),
    );
    request.fields['email'] = widget.userId; // Use email to identify the user
    request.files.add(
      await http.MultipartFile.fromPath('profilePic', imageFile.path),
    );

    var response = await request.send();
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile picture updated successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to upload profile picture')),
      );
    }
  }

  // Function to select image
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      // Upload the image
      await uploadProfilePicture(_imageFile!);
    } else {
      print('No image selected.');
    }
  }

  // Function to show edit profile image dialog
  void _showEditProfileImageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Profile Picture'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _imageFile != null
                  ? Image.file(_imageFile!)
                  : const Text('No image selected.'),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImage, // Pick image from gallery
                child: const Text('Select Image'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    final response = await http.put(
      Uri.parse('$apiUrl/api/change-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': widget.userId, // Use the user's email
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully')),
      );
    } else {
      final data = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'] ?? 'Failed to change password')),
      );
    }
  }

// Function to show change password dialog
  void _showChangePasswordDialog() {
    final TextEditingController currentPasswordController =
        TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                decoration:
                    const InputDecoration(labelText: 'Current Password'),
                obscureText: true,
              ),
              TextField(
                controller: newPasswordController,
                decoration: const InputDecoration(labelText: 'New Password'),
                obscureText: true,
              ),
              TextField(
                controller: confirmPasswordController,
                decoration:
                    const InputDecoration(labelText: 'Confirm New Password'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (newPasswordController.text ==
                    confirmPasswordController.text) {
                  await changePassword(currentPasswordController.text,
                      newPasswordController.text);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Passwords do not match')),
                  );
                }
                Navigator.pop(context);
              },
              child: const Text('Save'),
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
          title: const Text('Profile'),
          backgroundColor: Colors.blue,
          centerTitle: false,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Use a Stack to place edit icon on CircleAvatar
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 80.0,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.person,
                        size: 80.0,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _showEditProfileImageDialog, // Open image dialog
                        child: CircleAvatar(
                          radius: 25.0,
                          backgroundColor: Color.fromARGB(255, 13, 83, 169),
                          child: Icon(
                            Icons.edit,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Text(
                  '$firstName $lastName',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  'Email: ${widget.userId}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _showChangePasswordDialog,
                  child: const Text('Change Password'),
                ),
                const SizedBox(height: 10.0),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email'),
                  subtitle: Text(widget.userId),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.male),
                  title: const Text("Gender"),
                  subtitle: Text(Gender),
                  trailing: const Icon(Icons.edit),
                  onTap: () {
                    _showEditDialog('Gender'); // Edit gender
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.cake),
                  title: const Text('Date of Birth'),
                  subtitle: Text(dateOfBirth),
                  trailing: const Icon(Icons.edit),
                  onTap: () {
                    _showEditDialog('Date of Birth'); // Edit date of birth
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.work),
                  title: const Text('Status'),
                  subtitle: Text(status),
                ),
                const Divider(),
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

  // Function to show the edit dialog for gender and date of birth
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
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (field == 'Gender' && genderController.text.isNotEmpty) {
                  await updateUserDetails(
                      genderController.text, dobController.text);
                  fetchUserData();
                } else if (field == 'Date of Birth' &&
                    dobController.text.isNotEmpty) {
                  await updateUserDetails(Gender, dobController.text);
                  fetchUserData();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a valid value')),
                  );
                }
                Navigator.pop(context); // Close the dialog after updating
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
