import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReportPage extends StatefulWidget {
  final String userId; // User ID to fetch data
  ReportPage({required this.userId});

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String bloodGroup = '--';
  String weight = '--';
  String heartRate = '--';

  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heartRateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch user data when the widget is initialized
  }

  Future<void> fetchUserData() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:8002/api/health/${widget.userId}'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          bloodGroup = data['bloodGroup'] ?? '--';
          weight = data['weight'] ?? '--';
          heartRate = data['heartRate'] ?? '--';
        });
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      print(e.toString());
      // Handle error if necessary
    }
  }

  Future<void> updateUserData() async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:8002/api/update/${widget.userId}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'bloodGroup': bloodGroupController.text.isNotEmpty
              ? bloodGroupController.text
              : bloodGroup,
          'weight':
              weightController.text.isNotEmpty ? weightController.text : weight,
          'heartRate': heartRateController.text.isNotEmpty
              ? heartRateController.text
              : heartRate,
        }),
      );

      if (response.statusCode == 200) {
        fetchUserData(); // Refresh data after update
        Navigator.pop(context); // Close the dialog
      } else {
        throw Exception('Failed to update user data');
      }
    } catch (e) {
      print(e.toString());
      // Handle error if necessary
    }
  }

  void showEditDialog(String field) {
    String initialValue = '';
    switch (field) {
      case 'bloodGroup':
        initialValue = '${bloodGroup}';
        break;
      case 'weight':
        initialValue = '${weight} KG';
        break;
      case 'heartRate':
        initialValue = '${heartRate} BPM';
        break;
    }

    // Open a dialog to edit user fields
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: field == 'bloodGroup'
                ? bloodGroupController
                : field == 'weight'
                    ? weightController
                    : heartRateController,
            decoration: InputDecoration(hintText: initialValue),
          ),
          actions: [
            TextButton(
              onPressed: () {
                updateUserData();
                fetchUserData();
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
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA), // Light background color
      appBar: AppBar(
        title: Text('Report', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heart Rate Container
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(175, 8, 131, 208), // Light blue
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Heart Rate', style: TextStyle(fontSize: 18.0)),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '$heartRate BPM',
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8), // Small space
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => showEditDialog('heartRate'),
                            padding:
                                EdgeInsets.zero, // Make closer to the value
                          ),
                        ],
                      ),
                      Icon(
                        Icons.trending_up,
                        size: 50, // Adjusted size
                        color: Color.fromARGB(
                            212, 53, 0, 226), // Color for symbol icon
                      ), // Symbol icon to the rightmost
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Row for Blood Group and Weight
            Row(
              children: [
                // Blood Group
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(183, 225, 48, 32), // Light red
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Blood Group', style: TextStyle(fontSize: 18.0)),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              bloodGroup,
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 8), // Small space
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => showEditDialog('bloodGroup'),
                              padding: EdgeInsets.only(
                                  left: 2.0), // Closer to the value
                            ),
                            Icon(
                              Icons.bloodtype,
                              size: 50.0, // Adjusted size
                              color: Colors.red,
                            ), // Icon for Blood Group
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16.0),

                // Weight
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFD9FBD9), // Light green
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Weight', style: TextStyle(fontSize: 18.0)),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween, // Adjusted
                          children: [
                            Expanded(
                              child: Text(
                                '$weight KG',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 5.0), // Increased width for spacing
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                showEditDialog('weight');
                              },
                              padding: EdgeInsets.only(left: 8), // Add padding
                            ),
                            SizedBox(
                                width:
                                    10.0), // Adjust spacing between icon and next icon
                            Icon(
                              Icons.fitness_center,
                              size: 50.0, // Adjusted size
                              color: Colors.green,
                            ), // Icon for Weight
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.0),

            // Latest Report Section
            Text('Latest Report',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 16.0),

            // General Health Container
            ListTile(
              contentPadding: EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              tileColor: Color(0xFFE9F3FF), // Light blue box
              leading: Icon(Icons.folder, size: 40, color: Colors.blue),
              title: Text('General Health'),
              subtitle: Text('8 files'),
              trailing: Icon(Icons.more_vert),
            ),
            SizedBox(height: 16.0),

            // Diabetes Container
            ListTile(
              contentPadding: EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              tileColor: Color(0xFFEDE4FF), // Light purple box
              leading: Icon(Icons.folder, size: 40, color: Colors.purple),
              title: Text('Diabetes'),
              subtitle: Text('4 files'),
              trailing: Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}
