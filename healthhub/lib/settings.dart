import 'package:flutter/material.dart';
import 'package:healthhub/login_view.dart';

void main() {
  runApp(SettingsPage());
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 0, 140, 255),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // Set your desired height here
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 2, 141, 255),
            elevation: 0,
            title: const Text(
              'Settings',
              style: TextStyle(
                  fontSize: 30.0), // Adjust the title font size if needed
            ),
            centerTitle: false,
            flexibleSpace: Padding(
              padding: const EdgeInsets.all(16.0),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Account Information',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Full black color
                ),
              ),
              const SizedBox(height: 20.0),
              _buildSectionTitle('Login and security'),
              const SizedBox(height: 10.0),
              _buildSettingsOption(
                icon: Icons.person_outline,
                title: 'Username',
                onTap: () {
                  // Navigate to username screen
                },
              ),
              _buildSettingsOption(
                icon: Icons.phone_outlined,
                title: 'Phone Number',
                onTap: () {
                  // Navigate to phone number screen
                },
              ),
              _buildSettingsOption(
                icon: Icons.email_outlined,
                title: 'Email',
                onTap: () {
                  // Navigate to email screen
                },
              ),
              _buildSettingsOption(
                icon: Icons.lock_outline,
                title: 'Password',
                onTap: () {
                  // Navigate to password screen
                },
              ),
              const SizedBox(height: 20.0),
              _buildSectionTitle('Data and permissions'),
              const SizedBox(height: 10.0),
              _buildSettingsOption(
                icon: Icons.location_on_outlined,
                title: 'Location',
                onTap: () {
                  // Navigate to location screen
                },
              ),
              _buildSettingsOption(
                icon: Icons.help,
                title: 'Help',
                onTap: () {
                  // Navigate to help screen
                },
              ),
              _buildSettingsOption(
                icon: Icons.privacy_tip,
                title: 'Privacy Policy',
                onTap: () {
                  // Navigate to privacy policy screen
                },
              ),
              const SizedBox(height: 20.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: _buildDeactivateAccountButton(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.black45,
      ),
    );
  }

  Widget _buildSettingsOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildDeactivateAccountButton(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        icon: const Icon(
          Icons.power_settings_new,
          color: Colors.red,
        ),
        label: const Text(
          'Log out',
          style: TextStyle(color: Colors.red, fontSize: 16.0),
        ),
      ),
    );
  }
}

Widget _buildSectionTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.black45, // Adjust color if needed
    ),
  );
}

Widget _buildSettingsOption({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(icon, color: Colors.blue),
    title: Text(title),
    // Removed trailing arrow icon
    onTap: onTap,
  );
}

Widget _buildDeactivateAccountButton(BuildContext context) {
  return Center(
    child: TextButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      icon: const Icon(
        Icons.power_settings_new,
        color: Colors.red,
      ),
      label: const Text(
        'Log out',
        style: TextStyle(color: Colors.red, fontSize: 16.0),
      ),
    ),
  );
}
