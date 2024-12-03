import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/browser_client.dart';
import 'package:park_it/super_admin/constants/image_strings.dart';

class AdminLogin extends StatefulWidget {
  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {

  String urlLoginDto = "http://localhost:9000/login";

  late String email;
  late String password;
  late String status;

  TextEditingController emailController =  TextEditingController();
  TextEditingController passwordController =  TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Split background
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(color: Colors.white),
              ),
              Expanded(
                flex: 1,
                child: Container(color: Color(0xFF0D47A1)), // Dark blue color
              ),
            ],
          ),
          // Curved shape at the bottom left
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Color(0xFF0D47A1), // Dark blue color
                borderRadius: BorderRadius.only(topRight: Radius.circular(200)),
              ),
            ),
          ),
          // Enlarged blue portion at the top right
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Color(0xFF0D47A1), // Dark blue color
                borderRadius:
                BorderRadius.only(bottomLeft: Radius.circular(300)),
              ),
            ),
          ),
          // Enlarged Admin login form with adjusted positioning
          Center(
            child: Container(
              width: 600, // Increased width
              padding: EdgeInsets.all(48), // Increased padding
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                    16), // Rectangular shape with rounded corners
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Admin login',
                    style: TextStyle(
                      fontSize: 28, // Larger font size
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40), // Increased spacing
                  Text(
                    'email',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18), // Changed to grey color
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Password',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18), // Changed to grey color
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: Icon(Icons.visibility_off),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'forgot password?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      await checkLogin();
                      if(status == "User Is Valid"){
                        print("user can enter");
                      }
                      else{
                        print("user can't");
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white), // Changed to white color
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0D47A1), // Dark blue color
                      padding: EdgeInsets.symmetric(
                          vertical: 20), // Increased button height
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // Rectangular with slightly rounded edges
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Logo
          Positioned(
            left: 16,
            top: 16,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                JoinUsSVG.facebook,
                width: 50,
                height: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> checkLogin() async {
    email = emailController.text.toString();
    password = passwordController.text.toString();
    var client = BrowserClient(); // Use BrowserClient for web-specific requests
    try {
      var res = await client.post(
        Uri.parse(urlLoginDto),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email' : email,
          'password' : password
        }),
      );
      print('Status Code: ${res.statusCode}');
      print('Response Body: ${res.body}');
      setState(() {
        status = res.body;
      });
    } catch (e) {
      // Catch any errors that occur during the request
      print(e);
    } finally {
      client.close(); // Ensure the client is closed after the request
    }
  }
}