import 'package:flutter/material.dart';
import 'package:park_it/super_admin/screens/MainMenu/super_admin_main_menu.dart';



class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.04,
                      bottom: 50,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AutoSpaXe",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 100,
                            fontWeight: FontWeight.bold,
                            height: 1.0,
                          ),
                        ),
                        Text(
                          "Perfected",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 4,
                              height: 240, // Extended the height of the orange line
                              color: Colors.orange,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Park Smarter with",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                                Text(
                                  "the Next-Gen",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                                Text(
                                  "Parking Solution",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                        "Streamlined parking. Professional Service.\n",
                                        style: TextStyle(
                                          fontFamily:
                                          "Calibri Light", // Updated font family
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight
                                              .w300, // Reduced font weight
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                        "Streamlined parking. Professional Service.\n",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight
                                              .w300, // Reduced font weight
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Professional Service.",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight
                                              .w300, // Reduced font weight
                                          fontFamily: 'SourceSansPro',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment(
                        -0.8, 0.0), // Adjusted alignment to move the button
                    child: ElevatedButton(
                      onPressed: () {
                        // Access the parent state and call updateSelectedIndex
                        final parentState =
                        context.findAncestorStateOfType<SuperAdminState>();
                        parentState?.updateSelectedIndex(1); // Switch to ServiceScreen
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Learn More",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
}
