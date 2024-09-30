import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppointmentBookingPage extends StatefulWidget {
  final String doctorName;
  final String Time;
  final String Date;
  final String doctorId;
  final String userId;

  AppointmentBookingPage({
    Key? key,
    required this.doctorName,
    required this.Time,
    required this.Date,
    required this.doctorId, // Added doctorId field
    required this.userId,
  }) : super(key: key);

  @override
  _AppointmentBookingPageState createState() => _AppointmentBookingPageState();
}

class _AppointmentBookingPageState extends State<AppointmentBookingPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _doctorNameController = TextEditingController();
  final TextEditingController _TimeController = TextEditingController();
  final TextEditingController _DateController = TextEditingController();

  late String _selectedGender;
  late String _selectedDepartment;
  int? _selectedYear;
  int? _selectedMonth;
  int? _selectedDay;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _departments = ['OPD', 'Physiotherapy'];

  @override
  void initState() {
    super.initState();
    _selectedGender = _genders[0]; // Initialize with the first item in _genders
    _selectedDepartment = _departments[0];
    _doctorNameController.text = widget.doctorName;
    _TimeController.text = widget.Time;
    _DateController.text = widget.Date;
    _emailController.text = widget.userId;
  }

  Future<void> _selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedYear = picked.year;
        _selectedMonth = picked.month;
        _selectedDay = picked.day;
      });
    }
  }

  Future<void> _bookAppointment() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Prepare appointment data
      final appointmentData = {
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'dateOfBirth': {
          'date': _selectedDay?.toString() ?? '',
          'month': _selectedMonth?.toString() ?? '',
          'year': _selectedYear?.toString() ?? '',
        },
        'gender': _selectedGender,
        'age': int.parse(_ageController.text),
        'email': _emailController.text,
        'address': {
          'road': _addressController.text,
          'city': _cityController.text,
          'province': _provinceController.text,
        },
        'department': _selectedDepartment,
        'contactNumber': _contactNumberController.text,
        'appointmentDate': widget.Date,
        'timeSlot': _TimeController.text,
        'doctorId': widget.doctorId,
      };

      try {
        final response = await http.post(
          Uri.parse('http://localhost:8002/api/appointments'),
          //Uri.parse('http://192.168.1.106/api/appointments'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(appointmentData),
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 201) {
          _showDialog('Success', 'Appointment booked successfully!');
        } else {
          _showDialog('Error', 'Failed to book appointment.');
        }
      } catch (e) {
        print('Error: $e');
        _showDialog('Error', 'An error occurred: $e');
      }
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool readOnly = false,
    FormFieldValidator<String>? validator,
    Function()? onTap,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      readOnly: readOnly,
      validator: validator,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('+ New Appointment'),
        backgroundColor:
            Color.fromARGB(255, 34, 21, 166), // Use your preferred theme color
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Patient Information',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _firstNameController,
                      labelText: 'First Name',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      controller: _lastNameController,
                      labelText: 'Last Name',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      readOnly: true,
                      onTap: () => _selectDateOfBirth(context),
                      controller: TextEditingController(
                          text: _selectedYear != null ? '$_selectedYear' : ''),
                      labelText: 'Year',
                      validator: (value) {
                        if (_selectedYear == null) {
                          return 'Please select your date of birth';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      readOnly: true,
                      onTap: () => _selectDateOfBirth(context),
                      controller: TextEditingController(
                          text: _selectedMonth != null
                              ? DateFormat('MM').format(DateTime(
                                  DateTime.now().year, _selectedMonth!, 1))
                              : ''),
                      labelText: 'Month',
                      validator: (value) {
                        if (_selectedMonth == null) {
                          return 'Please select your date of birth';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      readOnly: true,
                      onTap: () => _selectDateOfBirth(context),
                      controller: TextEditingController(
                          text: _selectedDay != null ? '$_selectedDay' : ''),
                      labelText: 'Day',
                      validator: (value) {
                        if (_selectedDay == null) {
                          return 'Please select your date of birth';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildTextField(
                readOnly: true,
                controller: _emailController,
                labelText: 'Email',
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _ageController,
                      labelText: 'Age',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your age';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      controller: _addressController,
                      labelText: 'Address',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _cityController,
                      labelText: 'City',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your city';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      controller: _provinceController,
                      labelText: 'Province',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your province';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: _contactNumberController,
                labelText: 'Contact Number',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your contact number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _buildTextField(
                readOnly: true,
                controller: _doctorNameController,
                labelText: 'Doctor Name',
              ),
              SizedBox(height: 20),
              _buildTextField(
                readOnly: true,
                controller: _TimeController,
                labelText: 'Date and Time',
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                items: _genders.map((gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedDepartment,
                decoration: InputDecoration(
                  labelText: 'Department',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                items: _departments.map((department) {
                  return DropdownMenuItem<String>(
                    value: department,
                    child: Text(department),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDepartment = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _bookAppointment,
                  child: Text('Book Appointment'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
