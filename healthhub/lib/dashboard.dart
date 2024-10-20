import 'package:flutter/material.dart';
import 'package:healthhub/ambulance.dart';
import 'package:healthhub/appointment.dart';
import 'package:healthhub/doctor.dart';
import 'package:healthhub/doctorlist.dart';
import 'package:healthhub/drugslist.dart';
import 'package:healthhub/login_view.dart';
import 'package:healthhub/profile.dart';
import 'package:healthhub/reports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Hub',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 50, 55, 167),
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 70,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 50, 55, 167),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
      ),
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildCustomAppBarTitle(),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'new_appointment',
                child: Text('+ New Appointment'),
              ),
              const PopupMenuItem(
                value: 'drugs',
                child: Text('Drugs'),
              ),
              const PopupMenuItem(
                value: 'doctors',
                child: Text('Doctors'),
              ),
              const PopupMenuItem(
                value: 'profile',
                child: Text('Profile'),
              ),
              const PopupMenuItem(
                value: 'help',
                child: Text('Help'),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
            onSelected: (String value) {
              handleMenuSelection(value, context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LightBlueRectangle(),
              const SizedBox(height: 20),
              buildSearchBar(),
              const SizedBox(height: 20),
              buildIconButtons(context),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Top Rated Doctors',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Horizontal scrolling for Top Rated Doctors section
              const SizedBox(
                height: 250, // Adjust height as needed
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      DoctorCard(
                        name: "Dr. Saman Kumara",
                        rating: "4.7/5",
                        image: 'assets/doctor1.png',
                      ),
                      SizedBox(width: 10),
                      DoctorCard(
                        name: "Dr. Ruwan Silva",
                        rating: "4.6/5",
                        image: 'assets/doctor2.png',
                      ),
                      SizedBox(width: 10),
                      DoctorCard(
                        name: "Dr. Sriyantha Mendis",
                        rating: "4.4/5",
                        image: 'assets/doctor3.png',
                      ),
                      SizedBox(width: 10),
                      DoctorCard(
                        name: "Dr. Darshana Jayawardene",
                        rating: "4.4/5",
                        image: 'assets/doctor4.png',
                      ),
                      SizedBox(width: 10),
                      // Add more DoctorCards here
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void handleMenuSelection(String value, BuildContext context) {
    switch (value) {
      case 'new_appointment':
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AppointmentBookingPage(
                    doctorName: '',
                    Time: '',
                    doctorId: '',
                    Date: '',
                    userId: '',
                  )),
        );
        break;
      case 'drugs':
        break;
      case 'doctors':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DoctorsListPage()),
        );
        break;
      case 'profile':
        break;
      case 'help':
        // Handle Help action
        break;
      case 'logout':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
        break;
    }
  }
}

Widget buildCustomAppBarTitle() {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(height: 20),
      Text(
        'Find your desired health solution',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 20),
    ],
  );
}

Widget buildSearchBar() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search doctor, drugs, articles..',
              hintStyle: const TextStyle(color: Color(0xFF7A7878)),
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        ),
      ],
    ),
  );
}

Widget buildIconButtons(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButtonColumn(
          image: 'assets/Doctor.png',
          onTap: () => navigateTo('doctor', context),
        ),
        IconButtonColumn(
          image: 'assets/Pharmacy.png',
          onTap: () => navigateTo('pharmacy', context),
        ),
        IconButtonColumn(
          image: 'assets/Hospital.png',
          onTap: () => navigateTo('hospital', context),
        ),
        IconButtonColumn(
          image: 'assets/Ambulance.png',
          onTap: () => navigateTo('ambulance', context),
        ),
      ],
    ),
  );
}

void navigateTo(String destination, BuildContext context) {
  switch (destination) {
    case 'doctor':
      break;
    case 'pharmacy':
      break;
    case 'hospital':
      break;
    case 'ambulance':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AmbulancePage()),
      );
      break;
  }
}

class IconButtonColumn extends StatelessWidget {
  final String image;
  final VoidCallback onTap;

  const IconButtonColumn({
    super.key,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            image,
            height: 130,
            width: 70,
          ),
        ],
      ),
    );
  }
}

class LightBlueRectangle extends StatelessWidget {
  const LightBlueRectangle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(207, 17, 27, 216),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Early protection for\nyour family health',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(223, 17, 27, 216),
                      backgroundColor: Colors.white, // Text color blue
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    child: const Text(
                      'Learn more',
                      style: TextStyle(
                          color: Color.fromARGB(
                              223, 17, 27, 216)), // Text color blue
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Image.asset(
                'assets/home.png',
                height: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String rating;
  final String image;

  const DoctorCard({
    super.key,
    required this.name,
    required this.rating,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160, // Adjust width as needed
      height: 250, // Adjust height as needed
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(image),
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              rating,
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 63, 63, 63),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
