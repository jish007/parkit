import 'package:flutter/material.dart';
import 'package:http/browser_client.dart';
import 'package:park_it/admin/screens/Auth/admin_login_screen.dart';
import 'package:park_it/admin/screens/MainMenu/Action/action_screen.dart';
import 'package:park_it/admin/screens/MainMenu/DashBoard/dashboard.dart';
import 'package:park_it/admin/screens/MainMenu/History/history.dart';
import 'package:park_it/admin/screens/MainMenu/ParkingSpace/parking_space.dart';
import 'package:park_it/admin/screens/MainMenu/Profile/profile_page.dart';
import 'package:park_it/common/constants/spring_url.dart';

class AdminMainMenu extends StatefulWidget {
  final String adminMail;

  const AdminMainMenu({super.key,required this.adminMail});

  @override
  _AdminMainMenuState createState() => _AdminMainMenuState();
}

class _AdminMainMenuState extends State<AdminMainMenu> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      DashboardPage(adminMail: widget.adminMail), // Pass adminMail here
      ParkingSpacePage(adminMail: widget.adminMail,),
      HistoryPage(adminMail: widget.adminMail),
      ActionScreen(adminMail: widget.adminMail,),
      //ProfilePage(),
    ];
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> syncJotForm() async {
    try {
      var client = BrowserClient();
      final response =
      await client.get(Uri.parse("${SpringUrls.getJotFormUrl}?adminMailId=${widget.adminMail.toString()}"));

      if (response.statusCode == 200) {

      } else {
        throw Exception(
            "Failed to load profiles. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching profiles: $error");
    }
  }
  Future<void> logOutAdmin() async {
    try {
      var client = BrowserClient();
      final response =
      await client.get(Uri.parse("${SpringUrls.logoutUrl}?adminMailId=${widget.adminMail.toString()}"));

      if (response.statusCode == 200) {
        Navigator.push(context,MaterialPageRoute(builder: (context) => const LoginPage()));
      } else {
        throw Exception(
            "Failed to load profiles. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching profiles: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Logo
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Image.asset(
                      'assets/admin/logo.png', // Replace with your logo path
                      height: 50,
                    ),
                  ),
                ),
                // Menu Buttons
                Expanded(
                  child: ListView(
                    children: [
                      SidebarButton(
                        title: 'Dashboard',
                        icon: Icons.dashboard,
                        isSelected: _selectedIndex == 0,
                        onTap: () => _onItemTap(0),
                      ),
                      SidebarButton(
                        title: 'Parking Space',
                        icon: Icons.local_parking,
                        isSelected: _selectedIndex == 1,
                        onTap: () => _onItemTap(1),
                      ),
                      SidebarButton(
                        title: 'History',
                        icon: Icons.history,
                        isSelected: _selectedIndex == 2,
                        onTap: () => _onItemTap(2),
                      ),
                      SidebarButton(
                        title: 'Action Page',
                        icon: Icons.settings,
                        isSelected: _selectedIndex == 3,
                        onTap: () => _onItemTap(3),
                      ),
                      /*SidebarButton(
                        title: 'Profile', // Add the Profile button
                        icon: Icons.person,
                        isSelected: _selectedIndex == 4,
                        onTap: () => _onItemTap(4),
                      ),*/
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Separator with Rounded Corners
          Container(
            width: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
            ),
          ),

          // Content Area
          Expanded(
            child: Column(
              children: [
                // Search Bar and Action Icons
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Search Bar (Wrapped in Container for BoxShadow)
                      Container(
                        width: 850, // Adjust the length of the search bar
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            labelText: 'Search by Booking Number or Name',
                            labelStyle: TextStyle(color: Colors.black54),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Icon(Icons.search, color: Colors.black54),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          ),
                        ),
                      ),

                      Spacer(),

                      // Settings Icon
                      IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () {
                          // Add settings action here
                        },
                        color: Colors.black54,
                      ),

                      // Notification Icon
                      IconButton(
                        icon: Icon(Icons.notifications),
                        onPressed: () {
                          // Add notification action here
                        },
                        color: Colors.black54,
                      ),

                      // Profile Icon
                      IconButton(
                        icon: Icon(Icons.logout),
                        onPressed: () {
                          logOutAdmin();
                        },
                        color: Colors.black54,
                      ),

                      // Help Icon
                      IconButton(
                        icon: Icon(Icons.sync),
                        onPressed: () {
                          syncJotForm();
                        },
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),

                // Page Content
                Expanded(
                  child: _pages[_selectedIndex],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SidebarButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const SidebarButton({super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.black,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
