import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/browser_client.dart';
import 'package:park_it/admin/screens/MainMenu/DashBoard/helpers/profile_model.dart';
import 'package:park_it/common/constants/spring_url.dart';

class ActionScreen extends StatefulWidget {

  final String adminMail;
  const ActionScreen({super.key,required this.adminMail});

  @override
  State<ActionScreen> createState() => _ActionScreenState();
}

class _ActionScreenState extends State<ActionScreen> {
  late Future<List<Profile>> fullProfiles;
  List<Map<String, dynamic>> orders = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Fetch the profiles from the API
      List<Profile> profiles = await fullProfiles;

      // Map the necessary key-value pairs to the orders variable
      setState(() {
        orders = profiles.map((profile) {
          return {
            'profileId': profile.profileId.toString(),
            'userName': profile.userName,
            'vehicleNumber': profile.vehicleNumber.toString(),
            'userEmailId': profile.userEmailId.toString(),
            'bookingTime': profile.bookingTime,
            'durationOfAllocation': profile.durationOfAllocation.toString(),
            'banned':profile.isBanned,
            'fineAmount':profile.fineAmount,
          };
        }).toList();
      });

      print("Data loaded successfully: $orders");
    } catch (e) {
      print("Error loading data: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullProfiles = fetchProfiles(widget.adminMail);
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

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: orders.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Table header
              Row(
                children: [
                  TabButton("Users", true),
                  SizedBox(width: 8),
                  TabButton("Ban", false),
                  SizedBox(width: 8),
                  TabButton("Fine", false),
                ],
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: const [
                    Expanded(child: Text("Id", style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(child: Text("Vehicle Number", style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(child: Text("Mail Id", style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(child: Text("Time", style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(child: Text("Duration", style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(width: 30), // Space for actions
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Table rows
              Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ActionDialog(name: order['userName'],isBanned: order['banned'],fineAmount: order['fineAmount']),
                        );
                      }, // Handle row tap
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
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(24.0), // Increased padding for more height
                                          child: Text(order['profileId'], style: TextStyle(color: Colors.black, fontSize: 18)),
                                        ),
                                        Expanded(
                                          child: Card(
                                            elevation: 3,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: ListTile(
                                              subtitle: Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        order['banned'] == true
                                                            ? StatusChip("Banned", Colors.red)
                                                            : SizedBox.shrink(),
                                                        order['fineAmount'] != 0
                                                            ? StatusChip("Fine", Colors.orange)
                                                            : SizedBox.shrink(),
                                                        order['fineAmount'] == 0 && order['banned'] == false
                                                            ? StatusChip("None", Colors.green)
                                                            : SizedBox.shrink(),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(24.0),
                                      child: Text(order['userName'], style: TextStyle(color: Colors.black, fontSize: 15)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(24.0),
                                      child: Text(order['vehicleNumber'], style: TextStyle(color: Colors.black, fontSize: 15)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(24.0),
                                      child: Text(order['userEmailId'], style: TextStyle(color: Colors.black, fontSize: 15)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(24.0),
                                      child: Text(order['bookingTime'], style: TextStyle(color: Colors.black, fontSize: 15)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(24.0),
                                      child: Text(order['durationOfAllocation'], style: TextStyle(color: Colors.black, fontSize: 15)),
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

  Widget buildMenuItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(icon, size: 24),
          SizedBox(width: 16),
          Text(title, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget TabButton(String title, bool isActive) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: isActive ? Colors.white : Colors.black,
        backgroundColor: isActive ? Colors.blue : Colors.white,
        elevation: isActive ? 4 : 0,
        side: BorderSide(color: Colors.blue, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(title),
      ),
    );
  }

  Widget StatusChip(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ActionDialog extends StatefulWidget {
  final String name;
  final bool isBanned;
  final int fineAmount;

  const ActionDialog({super.key, required this.name,required this.isBanned,required this.fineAmount});

  @override
  State<ActionDialog> createState() => _ActionDialogState();
}

class _ActionDialogState extends State<ActionDialog> {
  String value = "Ban";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning_amber, color: Colors.orange, size: 30),
                SizedBox(width: 8),
                Text(
                  "Action",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: "Ban",
              items: ["Ban", "Fine"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  value = newValue.toString();
                  print(value);
                });
              },
              decoration: InputDecoration(
                labelText: "Choose",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: value == "Ban"?"Reason":"Amount",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text(value == "Ban"?"Ban":"Fine"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
