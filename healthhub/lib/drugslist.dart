import 'package:flutter/material.dart';
import 'package:healthhub/drugProfile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:healthhub/dashboard1.dart';

class Drugslist extends StatelessWidget {
  final String userId;
  const Drugslist({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey, // Dark blue theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.lightBlue,
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
        ),
      ),
      home: DrugsPage(userId: userId),
    );
  }
}

class DrugsPage extends StatefulWidget {
  final String userId;
  const DrugsPage({super.key, required this.userId});

  @override
  _DrugsPageState createState() => _DrugsPageState(userId: userId);
}

class _DrugsPageState extends State<DrugsPage> {
  final String userId;
  List<dynamic> _drugsList = []; // List to hold drugs data
  late List<dynamic> _filteredDrugs;

  _DrugsPageState({required this.userId});

  @override
  void initState() {
    super.initState();
    _fetchDrugs(); // Fetch drugs when the widget is initialized
  }

  Future<void> _fetchDrugs() async {
    final response =
        await http.get(Uri.parse('http://localhost:8002/api/medicines/drugs'));

    if (response.statusCode == 200) {
      setState(() {
        _drugsList = json.decode(response.body); // Decode the JSON response
        _filteredDrugs = _drugsList; // Initialize filtered drugs list
      });
    } else {
      // Handle error response here if needed
      print('Failed to load drugs: ${response.statusCode}');
    }
  }

  void _filterDrugs(String query) {
    final filtered = _drugsList
        .where((drug) =>
            drug['medicineName'].toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _filteredDrugs = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Drugs'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // This line will navigate to the previous screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard1(userId: userId),
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filterDrugs,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                hintText: 'Search for drugs',
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _filteredDrugs.length,
              itemBuilder: (context, index) {
                final drug = _filteredDrugs[index];

                // Determine the status color
                Color statusColor = drug['status'].toLowerCase() == 'expired'
                    ? Colors.red
                    : const Color.fromARGB(255, 3, 109, 7);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(drug['medicineName'],
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold)),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        const Text(
                          'Status: ',
                          style: TextStyle(
                              color: Colors.black), // Static label in black
                        ),
                        Text(
                          drug['status'],
                          style: TextStyle(
                              color: statusColor), // Dynamic color for status
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Handle drug selection
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DrugProfile(
                            medicineName: drug['medicineName'],
                            category: drug['category'],
                            batchNumber: drug['batchNumber'],
                            stockQuantity: drug['stockQuantity'],
                            unitPrice: drug['unitPrice'],
                            expiryDate: DateTime.parse(
                              drug['expiryDate'],
                            ),
                            manufacturer: drug['manufacturer'],
                            status: drug['status'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
