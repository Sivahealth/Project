import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:healthhub/constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportPage extends StatefulWidget {
  final String userId; // User ID to fetch data
  const ReportPage({super.key, required this.userId});

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
    fetchUserData();
    fetchReportsByEmail(); // Fetch user data when the widget is initialized
  }

  List<Map<String, dynamic>> reports = [];
  Future<void> fetchReportsByEmail() async {
    try {
      final response = await http
          .get(Uri.parse('$apiUrl/api/report?email=${widget.userId}'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          reports = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception('Failed to load reports');
      }
    } catch (e) {
      print(e.toString());
      // Handle error if necessary
    }
  }

  Future<void> fetchUserData() async {
    try {
      final response =
          await http.get(Uri.parse('$apiUrl/api/health/${widget.userId}'));

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
        Uri.parse('$apiUrl/api/update/${widget.userId}'),
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
        initialValue = bloodGroup;
        break;
      case 'weight':
        initialValue = '$weight KG';
        break;
      case 'heartRate':
        initialValue = '$heartRate BPM';
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
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA), // Light background color
      appBar: AppBar(
        title: const Text('Report', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heart Rate Container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(175, 8, 131, 208), // Light blue
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Heart Rate', style: TextStyle(fontSize: 18.0)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '$heartRate BPM',
                            style: const TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8), // Small space
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => showEditDialog('heartRate'),
                            padding:
                                EdgeInsets.zero, // Make closer to the value
                          ),
                        ],
                      ),
                      const Icon(
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
            const SizedBox(height: 16.0),

            // Row for Blood Group and Weight
            Row(
              children: [
                // Blood Group
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color:
                          const Color.fromARGB(183, 225, 48, 32), // Light red
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Blood Group',
                            style: TextStyle(fontSize: 18.0)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              bloodGroup,
                              style: const TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8), // Small space
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => showEditDialog('bloodGroup'),
                              padding: const EdgeInsets.only(
                                  left: 2.0), // Closer to the value
                            ),
                            const Icon(
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
                const SizedBox(width: 16.0),

                // Weight
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9FBD9), // Light green
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Weight', style: TextStyle(fontSize: 18.0)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween, // Adjusted
                          children: [
                            Expanded(
                              child: Text(
                                '$weight KG',
                                style: const TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                                width: 5.0), // Increased width for spacing
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                showEditDialog('weight');
                              },
                              padding:
                                  const EdgeInsets.only(left: 8), // Add padding
                            ),
                            const SizedBox(
                                width:
                                    10.0), // Adjust spacing between icon and next icon
                            const Icon(
                              Icons.fitness_center,
                              size: 40.0, // Adjusted size
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
            const SizedBox(height: 32.0),

            // Latest Report Section
            // Latest Report Section
            const Text('Latest Report',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16.0),

// Display reports if available
            if (reports.isNotEmpty) ...[
              for (var report in reports)
                ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  tileColor:
                      const Color.fromARGB(80, 106, 165, 237), // Light blue box
                  leading: const Icon(Icons.picture_as_pdf_rounded,
                      size: 40, color: Color.fromARGB(255, 212, 0, 0)),

                  title: Text(
                    '${report['reportTitle']} Report',
                    style: const TextStyle(
                      color: Color.fromARGB(
                          255, 0, 0, 0), // Set title text color to black
                      fontSize: 16.0,
                      // Change title font size
                    ),
                  ),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                          height:
                              8), // Adds spacing between title and 'Uploaded by'
                      Text(
                        'Uploaded by : ${report['doctorName']}',
                        style: const TextStyle(
                          color: Color.fromARGB(212, 0, 0,
                              0), // Set uploaded by text color to black
                          fontSize: 14.0, // Change uploaded by font size
                        ),
                      ),
                      const SizedBox(
                          height:
                              2), // Adds spacing between doctor name and date
                      Text(
                        'Date : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(report['createdAt']))}',
                        style: const TextStyle(
                          color: Color.fromARGB(
                              212, 0, 0, 0), // Set date text color to black
                          fontSize: 14.0, // Change date font size
                        ),
                      ), // Date formatted as YYYY-MM-DD
                    ],
                  ),

                  trailing: IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () {
                      // Open the PDF URL in browser or download it
                      final pdfUrl = report['attachedPdf'];
                      if (pdfUrl != null) {
                        launchUrl(Uri.parse(pdfUrl)); // Launch the PDF URL
                      }
                    },
                  ),
                ),
            ] else ...[
              // Show a message if there are no reports
              const Text('No reports available for this user'),
            ],
          ],
        ),
      ),
    );
  }
}
