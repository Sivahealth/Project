import 'package:flutter/material.dart';
import 'package:healthhub/ambulance.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 50, 55, 167),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        toolbarHeight:
            300, // Increased toolbar height to accommodate the text and icons
        title: CustomAppBarTitle(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LightBlueRectangle(),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'Top Rated Doctors',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
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
                      name: "Dr. Dissanayake",
                      rating: "4.6/5",
                      image: 'assets/doctor2.png',
                    ),
                    SizedBox(width: 10),
                    // Add more DoctorCards here
                  ],
                ),
              ),
              SizedBox(height: 20), // Added some spacing after the row
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20), // Reduced top padding
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            'Find your desired health solution',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
        ),
        SizedBox(height: 20), // Reduced space between text and search bar
        buildSearchBar(),
        SizedBox(height: 10), // Small space between search bar and icons
        buildIconButtons(context),
        SizedBox(height: 10), // Added some spacing at the bottom
      ],
    );
  }
}

Widget buildSearchBar() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search doctor, drugs, articles..',
              hintStyle: TextStyle(color: Color(0xFF7A7878)),
              prefixIcon: Icon(Icons.search),
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
          icon: Icon(Icons.notifications),
          onPressed: () {},
        ),
      ],
    ),
  );
}

Widget buildIconButtons(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButtonColumn(
            image: 'assets/Doctor.png',
            onTap: () => navigateTo(context, 'doctor')),
        IconButtonColumn(
            image: 'assets/Pharmacy.png',
            onTap: () => navigateTo(context, 'pharmacy')),
        IconButtonColumn(
            image: 'assets/Hospital.png',
            onTap: () => navigateTo(context, 'hospital')),
        IconButtonColumn(
            image: 'assets/Ambulance.png',
            onTap: () => navigateTo(context, 'ambulance')),
      ],
    ),
  );
}

void navigateTo(BuildContext context, String destination) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      switch (destination) {
        case 'doctor':
          return DoctorScreen();
        case 'pharmacy':
          return PharmacyScreen();
        case 'hospital':
          return HospitalScreen();
        case 'ambulance':
          return AmbulanceScreen();
        default:
          return Dashboard(); // fallback to Dashboard
      }
    }),
  );
}

class IconButtonColumn extends StatelessWidget {
  final String image;
  final VoidCallback onTap;

  const IconButtonColumn({
    Key? key,
    required this.image,
    required this.onTap,
  }) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color.fromARGB(132, 50, 56, 167),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Early protection for\nyour family health',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 50, 55, 167),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text(
                  'Learn more',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          Image.asset(
            'assets/home.png',
            height: 150, // Increased height
          ),
        ],
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String rating;
  final String image;

  const DoctorCard({
    Key? key,
    required this.name,
    required this.rating,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Text(
            rating,
            style: TextStyle(
              fontSize: 16,
              color: const Color.fromARGB(255, 63, 63, 63),
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor'),
      ),
      body: Center(
        child: Text('Doctor Screen'),
      ),
    );
  }
}

class PharmacyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pharmacy'),
      ),
      body: Center(
        child: Text('Pharmacy Screen'),
      ),
    );
  }
}

class HospitalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital'),
      ),
      body: Center(
        child: Text('Hospital Screen'),
      ),
    );
  }
}

class AmbulanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AmbulancePage()),
      );
    });

    return Scaffold();
  }
}
