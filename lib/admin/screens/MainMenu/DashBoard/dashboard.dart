import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/browser_client.dart';
import 'package:intl/intl.dart';
import 'package:park_it/admin/screens/MainMenu/DashBoard/cards.dart';
import 'package:park_it/admin/screens/MainMenu/DashBoard/helpers/profile_model.dart';
import 'package:park_it/admin/screens/MainMenu/DashBoard/helpers/slots_model.dart';
import 'package:park_it/admin/screens/MainMenu/DashBoard/table.dart';
import 'package:park_it/common/constants/spring_url.dart';

/*class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Make the page scrollable
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // First existing widget (same as before)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Client Picture
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'assets/admin/sample_client.jpg', // Replace with your image path
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),

                  // Client Info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Reg No: ABC1234',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),

                  Spacer(),

                  // Parking Start Date
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Date',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '2024-12-10',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                  Spacer(),

                  // Parking End Date
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'End Date',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '2024-12-12',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                  Spacer(),

                  // Timer and Payment Info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Timer (Progress Bar)
                      Row(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 0.7, // 70% Progress Example
                              backgroundColor: Colors.grey[300],
                              color: const Color.fromARGB(255, 22, 194, 77),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '70%',
                            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      // Payment Info
                      Row(
                        children: [
                          Icon(
                            Icons.currency_rupee,
                            size: 16,
                            color: Colors.green,
                          ),
                          Text(
                            '500',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            // New Booking Progress Section
            Container(
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Step 1: New Booking
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'New Booking',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 31, 123, 197), // Active step in blue
                            ),
                          ),
                        ],
                      ),
                      // Horizontal Line after New Booking
                      Container(
                        width: 180,
                        height: 2,
                        color: const Color.fromARGB(255, 36, 138, 222), // Line color for active step
                      ),
                      // Step 2: Waiting for Car
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Waiting for Car',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Default color
                            ),
                          ),
                        ],
                      ),
                      // Horizontal Line after Waiting for Car
                      Container(
                        width: 180,
                        height: 2,
                        color: Colors.black, // Line color for default steps
                      ),
                      // Step 3: Car Parked
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Car Parked',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Default color
                            ),
                          ),
                        ],
                      ),
                      // Horizontal Line after Car Parked
                      Container(
                        width: 180,
                        height: 2,
                        color: Colors.black, // Line color for default steps
                      ),
                      // Step 4: Exited from Slot
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Exited from Slot',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Default color
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Main horizontal line connecting all steps
                  Container(
                    height: 2,
                    color: Colors.white, // Line connecting all steps
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            // Row to display both Personal Info and Parking Space cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: PersonalInfoCard(
                    firstName: 'Pranav',
                    dateOfBirth: '9 Jan 2003',
                    email: 'Pranav334@gmail.com',
                    phoneNumber: '93343223664274',
                    country: 'India',
                    city: 'Thrissur',
                    drivingExperience: '4 yr',
                  ),
                ),
                SizedBox(width: 10), // Space between the cards
                Expanded(
                  child: ParkingSpaceCard(
                    section: 'C',
                    row: '31',
                    space: '#C31',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PersonalInfoCard extends StatelessWidget {
  final String firstName;
  final String dateOfBirth;
  final String email;
  final String phoneNumber;
  final String country;
  final String city;
  final String drivingExperience;

  const PersonalInfoCard({super.key, 
    required this.firstName,
    required this.dateOfBirth,
    required this.email,
    required this.phoneNumber,
    required this.country,
    required this.city,
    required this.drivingExperience,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 300, // Reduced width for compact card
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 98, 120, 182).withOpacity(0.5),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Car & Personal Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12),
            // Shaded Boxes for Data
            _buildShadedBox('First Name', firstName),
            _buildShadedBox('Date of Birth', dateOfBirth),
            _buildShadedBox('Email', email),
            _buildShadedBox('Phone no', phoneNumber),
            _buildShadedBox('Country', country),
            _buildShadedBox('City', city),
            _buildShadedBox('Driving Experience', drivingExperience),
          ],
        ),
      ),
    );
  }

  Widget _buildShadedBox(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, ),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ParkingSpaceCard extends StatelessWidget {
  final String section;
  final String row;
  final String space;

  const ParkingSpaceCard({super.key, 
    required this.section,
    required this.row,
    required this.space,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: 200, // Reduced width for compact card
        height: 270,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading for the Parking Space Card
           Text(
              'Parking Space',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12),
            // Shaded Boxes for Data arranged in a row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildShadedBox('Section', section),
                _buildShadedBox('Row', row),
                _buildShadedBox('Space', space),
              ],
            ),
            SizedBox(height: 16),
            // Centering the button within the container
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Reassign',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShadedBox(String label, String value) {
    return Container(
      width: 150,
      height: 150, // Ensuring the boxes are square-shaped
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 167, 181, 237),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}*/

class DashboardPage extends StatefulWidget {
  final String adminMail;

  const DashboardPage({super.key, required this.adminMail});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late List<Profile> fullProfiles;
  late Future<List<Map<String, dynamic>>> profiles;

  late Future<List<Slots>> fullSlots;

  late String currentDate;

  @override
  void initState() {
    super.initState();
    profiles = fetchProfiles(widget.adminMail);
    fullSlots = fetchSlots(widget.adminMail).then((slots) {
      buildCardData(slots); // Build card data dynamically
      return slots;
    });
    DateTime now = DateTime.now();
    currentDate = DateFormat('dd/MM/yyyy').format(now);
  }

  List<Map<String, dynamic>> cardData = [
    {
      'number': '0',
      'title': 'Available Parking Spaces',
      'date': '',
      'percentageChange': 0,
      'color': Color.fromARGB(237, 24, 0, 181),
      'numberColor': Colors.green,
      'titleColor': Colors.white,
      'dateColor': Colors.white,
      'percentageColor': Colors.green,
    },
    {
      'number': '0',
      'title': 'Occupied Space',
      'date': '',
      'percentageChange': 0,
      'color': Color.fromARGB(237, 24, 0, 181),
      'numberColor': Colors.red,
      'titleColor': Colors.white,
      'dateColor': Colors.white,
      'percentageColor': Colors.red,
    },
    {
      'number': '0',
      'title': 'Total Parking Spaces',
      'date': '',
      'percentageChange': 0,
      'color': Color.fromARGB(237, 24, 0, 181),
      'numberColor': Colors.green,
      'titleColor': Colors.white,
      'dateColor': Colors.white,
      'percentageColor': Color.fromARGB(237, 24, 0, 181)
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Grid
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Display three cards per row
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                childAspectRatio: 1.5,
              ),
              itemCount: cardData.length,
              shrinkWrap: true,
              // Ensure GridView only takes the necessary space
              physics: NeverScrollableScrollPhysics(),
              // Disable GridView scrolling
              itemBuilder: (context, index) {
                var data = cardData[index];
                return DashboardCard(
                  number: data['number'],
                  title: data['title'],
                  date: data['date'],
                  percentageChange: data['percentageChange'],
                  color: data['color'],
                  numberColor: data['numberColor'],
                  titleColor: data['titleColor'],
                  dateColor: data['dateColor'],
                  percentageColor: data['percentageColor'],
                );
              },
            ),

            SizedBox(height: 70), // Add some space between the grid and table

            // Header with SVG icon and "BOOKING" text
            Row(
              children: [
                SvgPicture.asset(
                  'assets/admin/alarm.svg', // Path to your local SVG asset
                  width: 24, // Set the size of the icon
                  height: 30,
                ),
                SizedBox(width: 8), // Space between the icon and the text
                Text(
                  'Latest Booking',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 31, 204), // Text color
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),

            // Table Container with fetched data
            FutureBuilder<List<Map<String, dynamic>>>(
              future: profiles,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error fetching profiles: ${snapshot.error}",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return TableContainer(
                    width: double.infinity,
                    height: 500,
                    backgroundColor:
                        Color.fromARGB(255, 115, 104, 189).withOpacity(0.2),
                    data: snapshot.data!, // Pass the fetched data to the table
                  );
                } else {
                  return Center(
                    child: Text("No profiles available."),
                  );
                }
              },
            ),
            // Add more content here if needed
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchProfiles(String email) async {
    try {
      var client = BrowserClient();
      final response =
          await client.get(Uri.parse("${SpringUrls.getProfileURL}?adminMailId=$email"));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        fullProfiles =
            jsonResponse.map((data) => Profile.fromJson(data)).toList();
        return jsonResponse
            .map((data) => {
                  'username': data['userName'],
                  'type': data['vehicleType'],
                  'numberPlate': data['vehicleNumber'],
                  'time': data['bookingDate'],
                })
            .toList();
      } else {
        throw Exception(
            "Failed to load profiles. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching profiles: $error");
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<Slots>> fetchSlots(String email) async {
    try {
      var client = BrowserClient();
      final response =
      await client.get(Uri.parse("${SpringUrls.getSlotsURL}?adminMailId=$email"));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Slots.fromJson(data)).toList();
      } else {
        throw Exception(
            "Failed to load profiles. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching profiles: $error");
      return []; // Return an empty list in case of an error
    }
  }

  void buildCardData(List<Slots> slots) {
    int totalSlots = slots.length;
    int availableSlots = slots.where((slot) => slot.slotAvailability).length;
    int occupiedSlots = totalSlots - availableSlots;

    setState(() {
      cardData = [
        {
          'number': '$availableSlots',
          'title': 'Available Parking Spaces',
          'date': currentDate,
          'percentageChange': (availableSlots/totalSlots * 100).toInt(),
          'color': Color.fromARGB(237, 24, 0, 181),
          'numberColor': Colors.green,
          'titleColor': Colors.white,
          'dateColor': Colors.white,
          'percentageColor': Colors.green,
        },
        {
          'number': '$occupiedSlots',
          'title': 'Occupied Space',
          'date': currentDate,
          'percentageChange': (occupiedSlots/totalSlots * 100).toInt(),
          'color': Color.fromARGB(237, 24, 0, 181),
          'numberColor': Colors.red,
          'titleColor': Colors.white,
          'dateColor': Colors.white,
          'percentageColor': Colors.red,
        },
        {
          'number': '$totalSlots',
          'title': 'Total Parking Spaces',
          'date': currentDate,
          'percentageChange': 0,
          'color': Color.fromARGB(237, 24, 0, 181),
          'numberColor': Colors.green,
          'titleColor': Colors.white,
          'dateColor': Colors.white,
          'percentageColor': Color.fromARGB(237, 24, 0, 181),
        },
      ];
    });
  }
}
