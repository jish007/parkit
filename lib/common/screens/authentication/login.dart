import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            color: Colors.grey[100],
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.menu),
                      SizedBox(width: 8),
                      Text(
                        'MENU',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                buildMenuItem(Icons.dashboard, "Dashboard"),
                buildMenuItem(Icons.directions_car, "Booking"),
                buildMenuItem(Icons.check_circle, "Services"),
                buildMenuItem(Icons.schedule, "Service Schedule"),
                buildMenuItem(Icons.local_parking, "Parking space"),
                buildMenuItem(Icons.payment, "Payments"),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Text(
                        "Dashboard",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Container(
                        width: 250,
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Registration number or Booking number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Icon(Icons.notifications),
                      SizedBox(width: 16),
                      Icon(Icons.settings),
                      SizedBox(width: 16),
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/profile.png'),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),

                  // Stats Cards
                  Row(
                    children: [
                      buildStatCard("Available Parking Spaces", "126", Colors.green),
                      SizedBox(width: 16),
                      buildStatCard("Upcoming Tasks", "196", Colors.red),
                    ],
                  ),
                  SizedBox(height: 32),

                  // Latest Booking
                  Text(
                    "Latest Booking",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: [
                        buildBookingItem("9 Jan 2003", "Car", "KL47K2255", "Car wash"),
                        buildBookingItem("22 Oct 2001", "Car", "KL47K2255", "Car wash"),
                        buildBookingItem("22 Jan 2003", "Car", "KL47K2255", "Interior cleaning & Car wash"),
                        buildBookingItem("3 May 2000", "Car", "KL47K2255", "Interior cleaning"),
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

  Widget buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.arrow_upward, size: 16, color: color),
                Text("+18%", style: TextStyle(color: color)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBookingItem(String time, String type, String numberPlate, String service) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Text(time),
          subtitle: Text("$type | $numberPlate"),
          trailing: Text(service),
        ),
      ),
    );
  }
}
