import 'dart:convert';
import 'dart:ui';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:park_it/common/constants/spring_url.dart';
import 'package:park_it/super_admin/models/property_details.dart';

class SuperAdminHome extends StatefulWidget {
  @override
  _SuperAdminHomeState createState() => _SuperAdminHomeState();
}

class _SuperAdminHomeState extends State<SuperAdminHome> {
  List<PropertyDetails> parkingList = [];
  bool isLoading = true;
  bool isAscending = true;
  int sortedColumnIndex = 0;
  String verifyStatus = "";

  @override
  void initState() {
    super.initState();
    fetchParkingData();
  }

  Future<void> fetchParkingData() async {
    final response = await http.get(Uri.parse(
        'http://localhost:9000/super-admin/get-all-property-details'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        parkingList =
            jsonData.map((data) => PropertyDetails.fromJson(data)).toList();
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void sortTable(int columnIndex, bool ascending) {
    setState(() {
      sortedColumnIndex = columnIndex;
      isAscending = ascending;
      parkingList.sort((a, b) {
        var aValue = _getSortableValue(a, columnIndex);
        var bValue = _getSortableValue(b, columnIndex);
        return ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
      });
    });
  }

  dynamic _getSortableValue(PropertyDetails item, int columnIndex) {
    switch (columnIndex) {
      case 0:
        return item.slotId ?? 0;
      case 1:
        return item.slotNumber ?? "";
      case 2:
        return item.floor ?? "";
      case 3:
        return item.vehicleType ?? "";
      case 4:
        return item.propertyName ?? "";
      case 5:
        return item.city ?? "";
      case 6:
        return item.state ?? "";
      case 7:
        return item.country ?? "";
      case 8:
        return item.adminName ?? "";
      case 9:
        return item.roleName ?? "";
      case 10:
        return item.responsibilities ?? "";
      case 11:
        return item.duration ?? 0;
      case 12:
        return item.charge ?? 0;
      case 13:
        return item.adminMailId ?? "";
      default:
        return "";
    }
  }

  String formatData(dynamic value) {
    return value != null ? value.toString() : "N/A"; // Handle null values
  }

  Future<void> onVerifyPressed(
      String adminMail, String adminName, BuildContext context) async {
    verifyPropertyDetails(adminMail);
    showVerifyPopup(context, adminName);
  }

  void showVerifyPopup(BuildContext context, String adminName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Column(
            children: [
              Icon(Icons.check_circle, size: 50, color: Colors.green),
              // Success icon
              SizedBox(height: 10),
              Text(
                "Verification Successful",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: Text(
            "Admin $adminName has been verified successfully!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close popup
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text("Okay",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        );
      },
    );
  }

  void showPropertyImagePopup(BuildContext context, String propertyName) {
    showDialog(
      context: context,
      barrierDismissible: true, // Allows closing by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 10,
          backgroundColor: Colors.transparent, // Make the background transparent
          child: Stack(
            children: [
              // Background Blur Effect
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
              // Pop-up Container
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Only take necessary space
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Close Button at Top Right
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.close, size: 24, color: Colors.grey[700]),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    // Title
                    Text(
                      "Property Image",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    // Image Loader
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: fetchPropertyImages(propertyName),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return SizedBox(
                            height: 250,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                                  SizedBox(height: 10),
                                  Text("No image available", style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                          );
                        } else {
                          final imageBase64 = snapshot.data![0]['image'];
                          final imageBytes = Base64Decoder().convert(imageBase64);
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop(); // Close small popup
                              showFullScreenImage(context, imageBytes); // Show full screen image
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.memory(imageBytes, fit: BoxFit.cover, width: double.infinity, height: 250),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 15),
                    // Close Button
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: Text("Close", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showFullScreenImage(BuildContext context, Uint8List imageBytes) {
    showDialog(
      context: context,
      barrierDismissible: true, // Allow closing by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Full-screen experience
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(), // Close on tap
            child: InteractiveViewer(
              panEnabled: true, // Allows panning
              minScale: 1.0,
              maxScale: 3.0, // Enables pinch-to-zoom
              child: Image.memory(imageBytes, fit: BoxFit.contain),
            ),
          ),
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchPropertyImages(String propertyName) async {

    try {
      final response = await http.get(Uri.parse("${SpringUrls.getPropertyLayout}?propertyName=$propertyName"));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Map<String, dynamic>.from(item)).toList();
      } else {
        throw Exception("Failed to load images");
      }
    } catch (error) {
      print("Error fetching images: $error");
      return [];
    }
  }


  Future<void> verifyPropertyDetails(String adminMail) async {
    try {
      final response = await http.get(Uri.parse(
          "${SpringUrls.verifyPropertyBySuperAdmin}?email=$adminMail"));

      if (response.statusCode == 200) {
        print(response.body);
        setState(() {
          verifyStatus = response.body.toString();
        });
      } else {
        throw Exception("Failed");
      }
    } catch (error) {
      print("Error fetching : $error");
    }
  }

  void onRejectPressed(String adminName) {
    print("Rejected: $adminName");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(10),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 8,
                  shadowColor: Colors.blueAccent,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15)),
                        ),
                        child: Center(
                          child: Text(
                            "Parking Property Details",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(
                              sortColumnIndex: sortedColumnIndex,
                              sortAscending: isAscending,
                              headingRowColor: WidgetStateColor.resolveWith(
                                  (states) => Colors.blue.shade400),
                              dataRowColor: WidgetStateColor.resolveWith(
                                  (states) =>
                                      states.contains(WidgetState.selected)
                                          ? Colors.blue.shade100
                                          : Colors.white),
                              headingTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              columns: [
                                _buildSortableColumn('Slot ID', 0),
                                _buildSortableColumn('Slot Number', 1),
                                _buildSortableColumn('Floor', 2),
                                _buildSortableColumn('Vehicle Type', 3),
                                _buildSortableColumn('Property Name', 4),
                                _buildSortableColumn('City', 5),
                                _buildSortableColumn('State', 6),
                                _buildSortableColumn('Country', 7),
                                _buildSortableColumn('Admin Name', 8),
                                _buildSortableColumn('Role', 9),
                                _buildSortableColumn('Responsibilities', 10),
                                _buildSortableColumn('Duration', 11),
                                _buildSortableColumn('Charge', 12),
                                _buildSortableColumn('Admin Mail', 13),
                                DataColumn(label: Text('Actions')),
                                DataColumn(label: Text('Layout')),
                                // Adding the Actions column
                              ],
                              rows: parkingList.asMap().entries.map((entry) {
                                int index = entry.key;
                                PropertyDetails parking = entry.value;
                                return DataRow(
                                  color: WidgetStateProperty.resolveWith<
                                      Color?>((states) => index
                                          .isEven
                                      ? Colors.grey[100]
                                      : Colors.white), // Alternate row colors
                                  cells: [
                                    DataCell(Text(formatData(parking.slotId))),
                                    DataCell(
                                        Text(formatData(parking.slotNumber))),
                                    DataCell(Text(formatData(parking.floor))),
                                    DataCell(
                                        Text(formatData(parking.vehicleType))),
                                    DataCell(
                                        Text(formatData(parking.propertyName))),
                                    DataCell(Text(formatData(parking.city))),
                                    DataCell(Text(formatData(parking.state))),
                                    DataCell(Text(formatData(parking.country))),
                                    DataCell(
                                        Text(formatData(parking.adminName))),
                                    DataCell(
                                        Text(formatData(parking.roleName))),
                                    DataCell(Text(
                                        formatData(parking.responsibilities))),
                                    DataCell(
                                        Text(formatData(parking.duration))),
                                    DataCell(Text(formatData(parking.charge))),
                                    DataCell(
                                        Text(formatData(parking.adminMailId))),
                                    DataCell(
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () => onVerifyPressed(
                                                parking.adminMailId!,
                                                parking.adminName!,
                                                context),
                                            child: Text('Verify'),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 8),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          ElevatedButton(
                                            onPressed: () => onRejectPressed(
                                                parking.adminName!),
                                            child: Text('Reject'),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    DataCell(
                                      ElevatedButton(
                                        onPressed: () => showPropertyImagePopup(context, parking.propertyName!),
                                        child: Text('View'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.yellow,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  DataColumn _buildSortableColumn(String title, int columnIndex) {
    return DataColumn(
      label: Row(
        children: [
          Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Icon(
            sortedColumnIndex == columnIndex
                ? (isAscending ? Icons.arrow_upward : Icons.arrow_downward)
                : Icons.swap_vert,
            size: 16,
            color: Colors.white,
          ),
        ],
      ),
      onSort: (index, ascending) => sortTable(index, ascending),
    );
  }
}
