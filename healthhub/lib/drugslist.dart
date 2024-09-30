import 'package:flutter/material.dart';

void main() {
  runApp(Drugslist());
}

class Drugslist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey, // Dark blue theme
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightBlue,
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
        ),
      ),
      home: DrugsPage(),
    );
  }
}

class DrugsPage extends StatefulWidget {
  @override
  _DrugsPageState createState() => _DrugsPageState();
}

class _DrugsPageState extends State<DrugsPage> {
  final List<String> _allDrugs = [
    'Aspirin',
    'Paracetamol',
    'Ibuprofen',
    'Amoxicillin',
    'Cetirizine',
    'Loratadine',
    'Metformin',
    'Simvastatin',
    'Omeprazole',
    'Losartan',
    'Hydrochlorothiazide',
    'Prednisone',
    'Diazepam',
    'Lorazepam',
    'Lisinopril',
    'Azithromycin',
    'Doxycycline',
    'Furosemide',
    'Gabapentin',
    'Tamsulosin',
  ];
  late List<String> _filteredDrugs;

  @override
  void initState() {
    super.initState();
    _filteredDrugs = _allDrugs;
  }

  void _filterDrugs(String query) {
    final filtered = _allDrugs
        .where((drug) => drug.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _filteredDrugs = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Drugs'),
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
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _filteredDrugs.length,
              itemBuilder: (context, index) {
                final drug = _filteredDrugs[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(drug,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold)),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      // Handle drug selection
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