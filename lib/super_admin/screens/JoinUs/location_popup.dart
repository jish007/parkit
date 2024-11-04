import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:park_it/super_admin/screens/JoinUs/tom_tom_map.dart';

// Class to manage the location popup with the map
class LocationPopup {
  // Function to show the location popup with the map
  static void show(BuildContext context, {String title = 'Location', double height = 400, required Function(LatLng) onLocationSelected}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title), // Set the title of the popup
          content: Container(
            width: double.maxFinite, // Make the content take up the available width
            height: height, // Set the height of the map container
            child: TomTomMapWithRoute(
              onLocationSelected: onLocationSelected
            ), // Display your map widget
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
              },
              child: Text('Close'), // Close button
            ),
          ],
        );
      },
    );
  }
}