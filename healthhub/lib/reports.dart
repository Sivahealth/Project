import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
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
                color: Color(0xFFD8EFFE), // Light blue
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
                      Text(
                        '96 bpm',
                        style: TextStyle(
                            fontSize: 32.0, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.monitor_heart, size: 50, color: Colors.blue),
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
                      color: Color(0xFFFCD4D4), // Light red
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Blood Group', style: TextStyle(fontSize: 18.0)),
                        SizedBox(height: 8),
                        Text(
                          'B+',
                          style: TextStyle(
                              fontSize: 32.0, fontWeight: FontWeight.bold),
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
                        Text(
                          '80 Kg',
                          style: TextStyle(
                              fontSize: 32.0, fontWeight: FontWeight.bold),
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
