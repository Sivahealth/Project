import 'package:flutter/material.dart';

class DrugProfile extends StatelessWidget {
  final String medicineName;
  final String category;
  final String batchNumber;
  final int stockQuantity;
  final double unitPrice;
  final DateTime expiryDate;
  final String manufacturer;
  final String status;

  const DrugProfile({
    super.key,
    required this.medicineName,
    required this.category,
    required this.batchNumber,
    required this.stockQuantity,
    required this.unitPrice,
    required this.expiryDate,
    required this.manufacturer,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue, // Light blue theme color
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Medicine Profile'),
          backgroundColor: Colors.lightBlue, // Light blue color for AppBar
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), // Back arrow icon
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Card(
              color: Colors.lightBlue[100], // Light blue color for Card
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Medicine Name:', medicineName),
                    _buildInfoRow('Category:', category),
                    _buildInfoRow('Batch Number:', batchNumber),
                    _buildInfoRow('Stock Quantity:', stockQuantity.toString()),
                    _buildInfoRow('Unit Price:', 'Rs. ${unitPrice.toString()}'),
                    _buildInfoRow(
                      'Expiry Date:',
                      '${expiryDate.day}/${expiryDate.month}/${expiryDate.year}',
                    ),
                    _buildInfoRow('Manufacturer:', manufacturer),
                    _buildStatusRow(
                        'Status:', status), // Use the new method for status
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Left align text
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String title, String status) {
    // Determine the color based on the status
    Color statusColor = status.toLowerCase() == 'expired'
        ? const Color.fromARGB(255, 242, 23, 8)
        : const Color.fromARGB(255, 19, 96, 6);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              status,
              style: TextStyle(
                fontSize: 16,
                color: statusColor, // Set the text color based on the status
              ),
            ),
          ),
        ],
      ),
    );
  }
}
