import 'package:flutter/material.dart';
import 'package:park_it/super_admin/screens/JoinUs/form_field_widget.dart';
import 'package:park_it/super_admin/screens/JoinUs/nextcontainer.dart';

class JoinUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          bool isSmallScreen = constraints.maxWidth < 343; // Define small screen width

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity, // Ensure full width
                  padding: const EdgeInsets.all(16.0),
                  child: RightContainer(),
                ),
                SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  child: NextContainer(),
                ),
              ],
            ),
          );
        },
      );
  }
}



