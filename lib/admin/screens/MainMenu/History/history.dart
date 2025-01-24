import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/browser_client.dart';
import 'package:park_it/admin/screens/MainMenu/DashBoard/helpers/profile_model.dart';
import 'package:park_it/common/constants/spring_url.dart';

class HistoryPage extends StatefulWidget {
  final String adminMail;
  const HistoryPage({super.key,required this.adminMail});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  late Future<List<Profile>> fullProfiles;
  List<Map<String, dynamic>> orders = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadData();
  }

  // Function to load data from assets
  Future<void> _loadData() async {
    try {
      // Fetch the profiles from the API
      List<Profile> profiles = await fullProfiles;

      // Map the necessary key-value pairs to the orders variable
      setState(() {
        orders = profiles.map((profile) {
          return {
            'mailId': profile.userEmailId.toString(),
            'userName': profile.userName,
            'paidAmount': profile.paidAmount.toString(),
            'allocatedSlotNumber': profile.allocatedSlotNumber,
            'bookingTime': profile.bookingTime,
            'durationOfAllocation': profile.durationOfAllocation.toString(),
          };
        }).toList();
      });

      print("Data loaded successfully: $orders");
    } catch (e) {
      print("Error loading data: $e");
    }
  }


  // Function to handle row tap (can be extended to navigate to another screen or show a dialog)
  void _onRowTap(int index) {
    final order = orders[index];

    // Example: Show a dialog with order details
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Details'),
          content: Text(
            'Username: ${order['userName']}\n'
            'Mail Id: ${order['mailId']}\n'
            'Amount: ${order['paidAmount']}\n'
            'Slot: ${order['allocatedSlotNumber']}\n'
            'Time: ${order['bookingTime']}\n'
            'Duration: ${order['durationOfAllocation']}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullProfiles = fetchProfiles(widget.adminMail);
  }

  // Function to show a popup menu when the 3 dots are clicked
  void _onMenuOptionSelected(String value, int index) {
    final order = orders[index];
    if (value == 'view_profile') {
      // Perform action for "View Profile"
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Profile of ${order['userName']}'),
            content: Text('Here are the details for ${order['userName']}.\n\n'
                'Mail Id: ${order['mailId']}\n'
                'Amount: ${order['paidAmount']}\n'
                'Slot: ${order['allocatedSlotNumber']}\n'
                'Time: ${order['bookingTime']}\n'
                'Duration: ${order['durationOfAllocation']}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
    // You can add more cases for other menu options like 'edit_profile' or 'delete'
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: orders.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Table header
                  Row(
                    children: const [
                      Expanded(child: Text("User Name", style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(child: Text("Mail Id", style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(child: Text("Amount", style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(child: Text("Slot", style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(child: Text("Time", style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(child: Text("Duration", style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(width: 30), // Space for actions
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Table rows
                  Expanded(
                    child: ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return GestureDetector(
                          onTap: () => _onRowTap(index), // Handle row tap
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 16.0), // Increased space between rows
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16), // More rounded borders
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.05), // Shaded space between rows
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(24.0), // Increased padding for more height
                                          child: Text(order['userName'], style: TextStyle(color: Colors.black, fontSize: 18)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(24.0),
                                          child: Text(order['mailId'], style: TextStyle(color: Colors.black, fontSize: 18)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(24.0),
                                          child: Text(order['paidAmount'], style: TextStyle(color: Colors.black, fontSize: 18)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(24.0),
                                          child: Text(order['allocatedSlotNumber'], style: TextStyle(color: Colors.black, fontSize: 18)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(24.0),
                                          child: Text(order['bookingTime'], style: TextStyle(color: Colors.black, fontSize: 18)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(24.0),
                                          child: Text(order['durationOfAllocation'], style: TextStyle(color: Colors.black, fontSize: 18)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(24.0),
                                        child: PopupMenuButton<String>(
                                          icon: Icon(
                                            Icons.more_vert,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                          onSelected: (value) => _onMenuOptionSelected(value, index),
                                          itemBuilder: (BuildContext context) {
                                            return [
                                              PopupMenuItem<String>(
                                                value: 'view_profile',
                                                child: Text('View Profile'),
                                              ),
                                              // Add more options here as needed
                                            ];
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
  Future<List<Profile>> fetchProfiles(String email) async {
    try {
      var client = BrowserClient();
      final response =
      await client.get(Uri.parse("${SpringUrls.getProfileURL}?adminMailId=$email"));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Profile.fromJson(data)).toList();
      } else {
        throw Exception(
            "Failed to load profiles. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching profiles: $error");
      return []; // Return an empty list in case of an error
    }
  }
}
