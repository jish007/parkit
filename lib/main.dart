import 'package:flutter/material.dart';
import 'package:park_it/admin/screens/Auth/admin_login_screen.dart';
import 'package:park_it/admin/screens/Auth/loading_screen.dart';
import 'package:park_it/official_website/screens/MainMenu/official_web_main_menu.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        home: OfficialWeb(),
    );
  }
}