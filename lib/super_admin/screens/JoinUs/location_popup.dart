import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:park_it/super_admin/screens/JoinUs/tom_tom_map.dart';


// Class to manage the location popup with the map
class LocationPopup {
  static void show(
      BuildContext context, {
        String title = 'Location',
        double height = 400,
        required Function(LatLng?) onLocationSelected, // Callback for location
      }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 85, 81, 81),
          title: Text(title,style: TextStyle(color: Colors.black),),
          content: Container(
            width: double.maxFinite,
            height: height,
            child: TomTomMapWithRoute(
              onLocationSelected: (location) {
                Navigator.of(context).pop(); // Close the popup
                onLocationSelected(location); // Pass the location back
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
                onLocationSelected(null); // Pass null if canceled
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
