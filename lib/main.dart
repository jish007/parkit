import 'package:flutter/material.dart';
import 'package:park_it/admin/screens/Auth/admin_login_screen.dart';
import 'package:park_it/admin/screens/Auth/loading_screen.dart';
import 'package:park_it/admin/screens/MainMenu/Profile/profile_page.dart';
import 'package:park_it/official_website/screens/MainMenu/official_web_main_menu.dart';
import 'package:park_it/official_website/screens/service/test.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        home: /*OfficialWeb()*/LoadingScreen(destination: LoginPage(),),
    );
  }
}