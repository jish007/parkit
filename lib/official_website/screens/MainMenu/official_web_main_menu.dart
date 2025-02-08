import 'package:flutter/material.dart';
import 'package:park_it/official_website/screens/JoinUs/wrapping_all_widget.dart';
import 'package:park_it/official_website/screens/home/official_website_home.dart';
import 'package:park_it/official_website/screens/service/service_screen.dart';


class OfficialWeb extends StatefulWidget {
  @override
  OfficialWebState createState() => OfficialWebState();
}

class OfficialWebState extends State<OfficialWeb> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ServiceScreen(),
    JoinUsScreen(),
  ];

  // Public method to update _selectedIndex
  void updateSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/super_admin/icons/Frame11.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  menuItem("Home", 0),
                  SizedBox(width: 40),
                  menuItem("Services", 1),
                  SizedBox(width: 40),
                  menuItem("Join Us", 2),
                ],
              ),
            ),
            Expanded(
              child: _screens[_selectedIndex],
            ),
          ],
        ),
      ),
    );
  }

  Widget menuItem(String title, int index) {
    return GestureDetector(
      onTap: () {
        updateSelectedIndex(index);
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight:
              _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: 3,
            width: 50,
            color: _selectedIndex == index ? Colors.orange : Colors.transparent,
          ),
        ],
      ),
    );
  }
}

