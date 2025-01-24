import 'package:flutter/material.dart';
import 'package:park_it/admin/screens/Auth/admin_login_screen.dart';
import 'package:park_it/admin/screens/Auth/loading_screen.dart';
import 'package:park_it/admin/screens/MainMenu/Action/action_screen.dart';
import 'package:park_it/admin/screens/MainMenu/ParkingSpace/parking_space.dart';
import 'package:park_it/admin/screens/MainMenu/Profile/profile_page.dart';
import 'package:park_it/super_admin/screens/MainMenu/super_admin_main_menu.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        home: /*ParkingSpacePage(adminMail: 'gokulgnair777@gmail.com',)LoadingScreen(destination : LoginPage())ActionScreen(adminMail: 'gokulgnair777@gmail.com',)*/SuperAdmin(),
    );
  }
}