import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ActionScreen extends StatefulWidget {
  @override
  _ActionScreenState createState() => _ActionScreenState();
}

class _ActionScreenState extends State<ActionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32),
                  // Tabs
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
                  // User Table

                  Expanded(
                    child: ListView(
                      children: [
                        buildUserRow("Pranav", "KL47K2255",
                            "paru12@gmail.com", "19 Jan 2024", "banned"),
                        buildUserRow("Pranav", "KL47K2255",
                            "paru12@gmail.com", "19 Jan 2024", "fine"),
                        buildUserRow("Pranav", "KL47K2255",
                            "paru12@gmail.com", "19 Jan 2024", "none"),
                        buildUserRow("Pranav", "KL47K2255",
                            "paru12@gmail.com", "19 Jan 2024", "none"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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

  Widget buildUserRow(String name, String carNumber, String email,
      String date, String status) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => ActionDialog(name: name),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          subtitle: Row(
            children: [
              Checkbox(value: false, onChanged: (value) {}),
              Text(name),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    status == "banned"
                        ? StatusChip("Banned", Colors.red)
                        : SizedBox.shrink(),
                    status == "fine"
                        ? StatusChip("Fine", Colors.orange)
                        : SizedBox.shrink(),
                    status == "none"
                        ? StatusChip("None", Colors.green)
                        : SizedBox.shrink(),
                  ],
                ),
              ),
              Expanded(child: Text(carNumber)),
              Expanded(child: Text(email)),
              Expanded(child: Text(date)),
            ],
          ),

        ),
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

class ActionDialog extends StatelessWidget {
  final String name;

  ActionDialog({required this.name});

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
              value: "Inactive",
              items: ["Inactive", "Active"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {},
              decoration: InputDecoration(
                labelText: "Status",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Reason",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle Ban Action
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text("Ban"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
