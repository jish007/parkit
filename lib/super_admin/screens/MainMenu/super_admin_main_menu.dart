import 'package:flutter/material.dart';
import 'package:park_it/super_admin/screens/JoinUs/form_field_widget.dart';
import 'package:park_it/super_admin/screens/JoinUs/nextcontainer.dart';
import 'package:park_it/super_admin/screens/JoinUs/wrapping_all_widget.dart';
import 'package:park_it/super_admin/screens/home/super_admin_home.dart';
import 'package:park_it/super_admin/screens/service/service_screen.dart';

class SuperAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0), // Set the background color of the Scaffold
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0), // Set the AppBar height to 0
          child: AppBar(
            elevation: 0,
          ),
        ),
        body: ContainerWithTabs(),
      ),
    );
  }
}

class ContainerWithTabs extends StatefulWidget {
  @override
  _ContainerWithTabsState createState() => _ContainerWithTabsState();
}

class _ContainerWithTabsState extends State<ContainerWithTabs> {
  String _currentTab = 'Home';
  final Map<String, GlobalKey> _tabKeys = {
    'Home': GlobalKey(),
    'Service': GlobalKey(),
    'Join Us': GlobalKey(),
  };

  double _indicatorPosition = 0.0;
  double _indicatorWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTabButton('Home'),
                        SizedBox(width: 80),
                        _buildTabButton('Service'),
                        SizedBox(width: 80),
                        _buildTabButton('Join Us'),
                      ],
                    ),
                    if (_currentTab == 'Home')
                      SizedBox(height: 0.5),
                    if (_currentTab == 'Home')
                      Container(
                        height: 4.0,
                        width: 60.0,
                        color: Color.fromARGB(255, 235, 231, 11),
                        margin: EdgeInsets.only(right: 250),
                      ),
                    if (_currentTab == 'Service')
                      SizedBox(height: 0.5),
                    if (_currentTab == 'Service')
                      Container(
                        height: 4.0,
                        width: 60.0,
                        color: Color.fromARGB(255, 235, 231, 11),
                        margin: EdgeInsets.only(right: 0),
                      ),
                    if (_currentTab == 'Join Us')
                      SizedBox(height: 0.5),
                    if (_currentTab == 'Join Us')
                      Container(
                        height: 4.0,
                        width: 60.0,
                        color: Color.fromARGB(255, 235, 231, 11),
                        margin: EdgeInsets.only(left: 250),
                      ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: screenWidth < 600
                  ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.0),
                      child: RightContainer(), // Display RightContainer
                    ),
                    SizedBox(height: 20.0), // Space between containers
                    Container(
                      padding: EdgeInsets.all(16.0),
                      child: NextContainer(), // Display LeftContainer2 below RightContainer
                    ),
                  ],
                ),
              )
                  : _buildContent(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTabButton(String tabName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentTab = tabName;
          _updateIndicator();
        });
      },
      child: AnimatedScale(
        scale: _currentTab == tabName ? 1.2 : 1.0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Container(
          key: _tabKeys[tabName],
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            tabName,
            style: TextStyle(
              color: _currentTab == tabName ? Colors.white : Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _updateIndicator() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = _tabKeys[_currentTab]!
          .currentContext!
          .findRenderObject() as RenderBox;
      final size = renderBox.size;
      final offset = renderBox.localToGlobal(Offset.zero);

      setState(() {
        _indicatorWidth = size.width;
        _indicatorPosition = offset.dx;
      });
    });
  }

  Widget _buildContent() {
    switch (_currentTab) {
      case 'Service':
        return ServiceScreen(); // Navigate to service.dart
      case 'Join Us':
        return JoinUsScreen(); // Navigate to joinus.dart
      default:
        return HomeScreen(
            isSelected: _currentTab == 'Home'); // Pass the selected state
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateIndicator();
    });
  }
}