/*import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:park_it/super_admin/CustomWidgets/roles_dropdown.dart';
import 'package:park_it/super_admin/constants/image_strings.dart';
import 'package:file_picker/file_picker.dart';

class RightContainer extends StatefulWidget {
  @override
  _RightContainerState createState() => _RightContainerState();
}

class _RightContainerState extends State<RightContainer> {
  // TextEditingControllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _adminNameController = TextEditingController();
  final TextEditingController _rolesController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _paymentController = TextEditingController();
  final TextEditingController _propertyNameController = TextEditingController();
  final TextEditingController _propertyLocationController =
      TextEditingController();

  List<Map<String, dynamic>> floorSlotData = [];
  bool isTrue = false;

  // Dropdown values
  String? _selectedCountry;
  String? _selectedState;
  String? _selectedDistrict;
  String? _selectedCity;
  List<String> _selectedRoles = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isSmallScreen = constraints.maxWidth < 600;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Let's ",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: "Talk",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 235, 231, 11),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  "We're here to assist you with anything you need.",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 24.0),
                // Dropdown and Text Fields Rows
                _buildLabeledTextFieldsRow(
                  'Name',
                  'Enter your name',
                  'Phone',
                  'Enter your phone number',
                  JoinUsSVG.person,
                  JoinUsSVG.phone,
                  _nameController,
                  _phoneController,
                  isSmallScreen,
                ),
                _buildDropdownTextFieldsRow(
                  'Country',
                  ['USA', 'Canada', 'Mexico'],
                  'State',
                  ['California', 'Texas', 'New York'],
                  _selectedCountry,
                  _selectedState,
                  isSmallScreen,
                ),
                _buildDropdownTextFieldsRow(
                  'District',
                  ['District 1', 'District 2', 'District 3'],
                  'City',
                  ['City A', 'City B', 'City C'],
                  _selectedDistrict,
                  _selectedCity,
                  isSmallScreen,
                ),
                _buildLabeledTextFieldsRowWithDropdown(
                  'Admin Name',
                  'Enter your admin name',
                  'Roles',
                  ['Admin', 'Manager', 'User'],
                  // Roles options
                  _adminNameController,
                  _selectedRoles,
                  // Pass the list of selected roles
                  isSmallScreen,
                ),
                _buildLabeledTextFieldsRow(
                  'Email*',
                  'Enter your email',
                  'Password',
                  'Enter your password',
                  JoinUsSVG.email,
                  JoinUsSVG.lock,
                  _emailController,
                  _passwordController,
                  isSmallScreen,
                ),
                _buildLabeledTextFieldsRow(
                  'Payment/Hour',
                  'Enter payment',
                  'Property Name',
                  'Enter your Property Name',
                  JoinUsSVG.rupee,
                  JoinUsSVG.property,
                  _paymentController,
                  _propertyNameController,
                  isSmallScreen,
                ),
                _buildLabeledTextFieldsWithSeparateButtons(
                  'Property Location',
                  'Enter property location',
                  'Location',
                  'Upload',
                  JoinUsSVG.location,
                  JoinUsSVG.attachment,
                  _propertyLocationController,
                  isSmallScreen,
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Builder(
                    builder: (context) {
                      return ElevatedButton(
                        onPressed: () {
                          // Handle submit action
                          print(floorSlotData);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width < 600
                                ? 100.0
                                : 200.0,
                            // Adjust padding based on screen width
                            vertical: 15.0,
                          ),
                          backgroundColor: Color.fromARGB(255, 235, 231, 11),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLabeledTextFieldsRowWithDropdown(
      String leftLabel,
      String leftHint,
      String rightLabel,
      List<String> rightItems, // Options for the dropdown
      TextEditingController leftController,
      List<String> rightValues, // Now a list of selected values
      bool isSmallScreen,
      ) {
    if (isSmallScreen) {
      return Column(
        children: [
          _buildLabeledTextField(leftLabel, leftHint, JoinUsSVG.person, leftController),
          SizedBox(height: 12.0),
          CustomDropdownField(
            label: rightLabel,
            items: rightItems, // Use the passed options for the dropdown
            currentValues: rightValues, // Pass the list of selected values
            onChanged: (selectedValues) {
              setState(() {
                _selectedRoles = selectedValues; // Update the selected roles with the new values
              });
            },
          ),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildLabeledTextField(leftLabel, leftHint, JoinUsSVG.person, leftController),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: CustomDropdownField(
              label: rightLabel,
              items: rightItems, // Use the passed options for the dropdown
              currentValues: rightValues, // Pass the list of selected values
              onChanged: (selectedValues) {
                setState(() {
                  _selectedRoles = selectedValues; // Update the selected roles with the new values
                });
              },
            ),
          ),
        ],
      );
    }
  }


  Widget _buildLabeledTextFieldsRow(
    String leftLabel,
    String leftHint,
    String rightLabel,
    String rightHint,
    String leftIconPath,
    String rightIconPath,
    TextEditingController leftController,
    TextEditingController rightController,
    bool isSmallScreen,
  ) {
    if (isSmallScreen) {
      return Column(
        children: [
          _buildLabeledTextField(
              leftLabel, leftHint, leftIconPath, leftController),
          SizedBox(height: 12.0),
          _buildLabeledTextField(
              rightLabel, rightHint, rightIconPath, rightController),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildLabeledTextField(
                leftLabel, leftHint, leftIconPath, leftController),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: _buildLabeledTextField(
                rightLabel, rightHint, rightIconPath, rightController),
          ),
        ],
      );
    }
  }

  Widget _buildDropdownTextFieldsRow(
    String leftLabel,
    List<String> leftItems,
    String rightLabel,
    List<String> rightItems,
    String? leftValue,
    String? rightValue,
    bool isSmallScreen,
  ) {
    if (isSmallScreen) {
      return Column(
        children: [
          _buildDropdownField(leftLabel, leftItems, leftValue, (value) {
            setState(() {
              _selectedCountry = value;
            });
          }),
          SizedBox(height: 12.0),
          _buildDropdownField(rightLabel, rightItems, rightValue, (value) {
            setState(() {
              _selectedState = value;
            });
          }),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child:
                _buildDropdownField(leftLabel, leftItems, leftValue, (value) {
              setState(() {
                _selectedCountry = value;
              });
            }),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: _buildDropdownField(rightLabel, rightItems, rightValue,
                (value) {
              setState(() {
                _selectedState = value;
              });
            }),
          ),
        ],
      );
    }
  }

  Widget _buildDropdownField(
    String label,
    List<String> items,
    String? currentValue,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16.0, color: Colors.white)),
        SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: DropdownButtonFormField<String>(
            value: items.contains(currentValue) ? currentValue : null,
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: TextStyle(color: Colors.white)),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Color.fromARGB(34, 165, 164, 164),
            ),
            dropdownColor: const Color.fromARGB(255, 47, 45, 45),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildLabeledTextFieldsWithSeparateButtons(
    String leftLabel,
    String leftHint,
    String leftButtonLabel,
    String rightButtonLabel,
    String leftIconPath,
    String rightIconPath,
    TextEditingController leftController,
    bool isSmallScreen,
  ) {
    if (isSmallScreen) {
      return Column(
        children: [
          _buildLabeledTextFieldWithSeparateButtons(leftLabel, leftHint,
              leftIconPath, leftButtonLabel, leftController),
          SizedBox(height: 12.0),
          _buildLabeledTextFieldWithSeparateButtons(
              'Upload', '', rightIconPath, rightButtonLabel, null),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildLabeledTextFieldWithSeparateButtons(leftLabel,
                leftHint, leftIconPath, leftButtonLabel, leftController),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: _buildLabeledTextFieldWithSeparateButtons(
                'Upload', '', rightIconPath, rightButtonLabel, null),
          ),
        ],
      );
    }
  }

  Widget _buildLabeledTextFieldWithSeparateButtons(String label, String hint,
      String iconPath, String buttonLabel, TextEditingController? controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        Stack(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: isTrue ? 'File Uploaded' : hint,
                hintStyle: TextStyle(
                  color:
                      const Color.fromARGB(255, 255, 255, 255).withOpacity(0.6),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    iconPath,
                    color: Color.fromARGB(255, 235, 231, 11),
                  ),
                ),
                suffixIcon: TextButton(
                  onPressed: () {
                    // Handle button action here
                    if (buttonLabel == 'Location') {
                      // Handle location logic
                    } else if (buttonLabel == 'Upload') {
                      // Handle upload logic
                      handleFileUpload();
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    backgroundColor:
                        Color.fromARGB(255, 139, 138, 142).withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    buttonLabel,
                    style: TextStyle(
                      color: Color.fromARGB(255, 235, 231, 11),
                    ),
                  ),
                ),
              ),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLabeledTextField(String label, String hint, String iconPath,
      TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16.0, color: Colors.white)),
        SizedBox(height: 8.0),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                iconPath,
                color: Color.fromARGB(255, 235, 231, 11),
              ),
            ),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  // Function to handle file upload and parse it
  Future<void> handleFileUpload() async {
    Uint8List? fileBytes = await pickExcelFile();

    if (fileBytes != null) {
      try {
        List<Map<String, dynamic>> parsedData = parseExcelToMap(fileBytes);
        isTrue = true;
        setState(() {
          floorSlotData = parsedData; // Update the state with the parsed data
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error parsing Excel: ${e.toString()}')),
        );
      }
    }
  }

  // Function to pick the Excel file
  Future<Uint8List?> pickExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      return result.files.first.bytes;
    }

    return null;
  }

  /// Function to parse the Excel data and transform it into the desired format
  List<Map<String, dynamic>> parseExcelToMap(Uint8List fileBytes) {
    var excel = Excel.decodeBytes(fileBytes); // Decode the Excel file bytes

    String sheetName =
        excel.tables.keys.first; // Assuming you are reading the first sheet
    var sheet = excel.tables[sheetName]; // Access the sheet

    // Ensure the sheet is not empty
    if (sheet == null || sheet.maxCols == 0 || sheet.maxRows == 0) {
      throw Exception("Sheet is empty or invalid.");
    }

    List<Map<String, dynamic>> floorSlotData = [];

    // The first row should contain floor names
    List<dynamic> floorHeaders = sheet.rows[0];

    // Loop through each column (for each floor)
    for (int col = 0; col < floorHeaders.length; col++) {
      var floorCell = floorHeaders[col];
      String? floor = _getCellValue(floorCell); // Get the floor name safely

      if (floor == null || floor.isEmpty)
        continue; // Skip if the floor name is empty

      List<String> slots = [];

      // Start from the second row (index 1) for slot data
      for (int row = 1; row < sheet.maxRows; row++) {
        var slotCell = sheet.rows[row][col]; // Get the slot data
        String? slot = _getCellValue(slotCell); // Safely extract the slot value
        if (slot != null && slot.isNotEmpty) {
          slots.add(slot); // Add the slot to the list
        }
      }

      // Add the floor and its corresponding slot data to the list
      floorSlotData.add({
        "slotNumber": slots,
        "floor": floor,
      });
    }

    return floorSlotData;
  }

  /// Helper function to safely get the value from a cell
  String? _getCellValue(Data? cell) {
    if (cell == null) return null;
    if (cell.value is SharedString) {
      return cell.value.toString(); // Convert SharedString to String
    } else if (cell.value is String) {
      return cell.value as String;
    } else {
      return cell.value?.toString(); // Convert other types to String
    }
  }
}*/

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/src/painting/box_border.dart' as border;
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/browser_client.dart';
import 'package:latlong2/latlong.dart';
import 'package:park_it/super_admin/CustomWidgets/roles_dropdown.dart';
import 'package:park_it/super_admin/constants/image_strings.dart';
import 'package:park_it/super_admin/screens/JoinUs/location_popup.dart';
import 'package:park_it/super_admin/screens/JoinUs/popup.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RightContainer extends StatefulWidget {
  @override
  _RightContainerState createState() => _RightContainerState();
}

class _RightContainerState extends State<RightContainer> {
  // TextEditingControllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _adminNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _paymentController = TextEditingController();
  final TextEditingController _propertyNameController = TextEditingController();
  final TextEditingController _propertyLocationController = TextEditingController();

  final String urlRoles = "http://localhost:9000/allRoles";
  final String urlSubmit = "http://localhost:9000/slotEnroll";

  List<Map<String, dynamic>> roles = [];
  List<String> resp = [];
  List<String> roleNames = [];
  List<Map<String, dynamic>> floorSlotData = [];
  bool isTrue = false;

  // Dropdown values
  String? _selectedCountry;
  String? _selectedState;
  String? _selectedDistrict;
  String? _selectedCity;
  String? latitude;
  String? longitude;

  List<Map<String,dynamic>> _selectedRoles = [];

  @override
  void initState() {
    super.initState();
    // Optionally, fetch roles when the widget is initialized
    getRoles();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        border: border.Border.all(
          color: Color.fromARGB(255, 141, 174, 8), // Border color
          width: 1.0, // Border width
        ),
        color: Colors.black,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isSmallScreen = constraints.maxWidth < 600;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Let's ",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: "Talk",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 235, 231, 11),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  "We're here to assist you with anything you need.",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 24.0),
                // Name and Phone Fields
                _buildLabeledTextFieldsRow(
                  'Name',
                  'Enter your name',
                  'Phone',
                  'Enter your phone number',
                  JoinUsSVG.person,
                  JoinUsSVG.phone,
                  _nameController,
                  _phoneController,
                  isSmallScreen,
                ),
                // Country and State Dropdowns
                _buildDropdownTextFieldsRow(
                  'Country',
                  ['USA', 'Canada', 'Mexico'],
                  'State',
                  ['California', 'Texas', 'New York'],
                  _selectedCountry,
                  _selectedState,
                  isSmallScreen,
                ),
                // District and City Dropdowns
                _buildDropdownTextFieldsRow1(
                  'District',
                  ['District 1', 'District 2', 'District 3'],
                  'City',
                  ['City A', 'City B', 'City C'],
                  _selectedDistrict,
                  _selectedCity,
                  isSmallScreen,
                ),
                // Admin Name and Roles (Dropdown for Roles)
                _buildLabeledTextFieldsRowWithDropdown(
                  'Admin Name',
                  'Enter your admin name',
                  'Roles',
                  roles,
                  // Roles options
                  _adminNameController,
                  // Pass the list of selected roles
                  isSmallScreen,
                ),
                // Email and Password Fields
                _buildLabeledTextFieldsRow(
                  'Email*',
                  'Enter your email',
                  'Password',
                  'Enter your password',
                  JoinUsSVG.email,
                  JoinUsSVG.lock,
                  _emailController,
                  _passwordController,
                  isSmallScreen,
                ),
                // Payment and Property Name Fields
                _buildLabeledTextFieldsRow(
                  'Payment/Hour',
                  'Enter payment',
                  'Property Name',
                  'Enter your Property Name',
                  JoinUsSVG.rupee,
                  JoinUsSVG.property,
                  _paymentController,
                  _propertyNameController,
                  isSmallScreen,
                ),
                // Property Location Field with Buttons
                _buildLabeledTextFieldsWithSeparateButtons(
                  'Property Location',
                  'Enter property location',
                  'Location',
                  'Upload',
                  JoinUsSVG.location,
                  JoinUsSVG.attachment,
                  _propertyLocationController,
                  isSmallScreen,
                ),
                SizedBox(height: 20.0),
                // Submit Button
                Center(
                  child: Builder(
                    builder: (context) {
                      return ElevatedButton(
                        onPressed: () {
                          submitData();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return PaymentPopup(); // This will show the payment popup
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width < 600
                                ? 100.0
                                : 200.0,
                            vertical: 15.0,
                          ),
                          backgroundColor: Color.fromARGB(255, 235, 231, 11),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLabeledTextFieldsRow(
    String leftLabel,
    String leftHint,
    String rightLabel,
    String rightHint,
    String leftIconPath,
    String rightIconPath,
    TextEditingController leftController,
    TextEditingController rightController,
    bool isSmallScreen,
  ) {
    if (isSmallScreen) {
      return Column(
        children: [
          _buildLabeledTextField(
              leftLabel, leftHint, leftIconPath, leftController),
          SizedBox(height: 12.0),
          _buildLabeledTextField(
              rightLabel, rightHint, rightIconPath, rightController),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildLabeledTextField(
                leftLabel, leftHint, leftIconPath, leftController),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: _buildLabeledTextField(
                rightLabel, rightHint, rightIconPath, rightController),
          ),
        ],
      );
    }
  }

  // Modified Row with Dropdown for Roles Field
  /*Widget _buildLabeledTextFieldsRowWithDropdown(
      String leftLabel,
      String leftHint,
      String rightLabel,
      List<String> rightItems,
      TextEditingController leftController,
      String? rightValue,
      bool isSmallScreen,
      ) {
    if (isSmallScreen) {
      return Column(
        children: [
          _buildLabeledTextField(leftLabel, leftHint,
              JoinUsSVG.person, leftController),
          SizedBox(height: 12.0),
          CustomDropdownField(
            label: rightLabel,
            items: ['Admin', 'User'],
            currentValue: rightValue,
            onChanged: (value) {
              setState(() {
                _selectedRole = value;
              });
            },
          ),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildLabeledTextField(leftLabel, leftHint,
                JoinUsSVG.person, leftController),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: CustomDropdownField(
              label: rightLabel,
              items: ['Admin', 'User'], // Removed 'Manager'
              currentValue: rightValue,
              onChanged: (value) {
                setState(() {
                  _selectedRole = value;
                });
              },
            ),
          ),
        ],
      );
    }
  }*/

  Widget _buildLabeledTextFieldsRowWithDropdown(
    String leftLabel,
    String leftHint,
    String rightLabel,
    List<Map<String,dynamic>> rightItems, // Options for the dropdown
    TextEditingController leftController,
    bool isSmallScreen,
  ) {
    if (isSmallScreen) {
      return Column(
        children: [
          _buildLabeledTextField(
              leftLabel, leftHint, JoinUsSVG.person, leftController),
          SizedBox(height: 12.0),
          CustomDropdownField(
            label: rightLabel,
            items: rightItems,
            // Pass the list of selected values
            onChanged: (selectedValues) {
              setState(() {
                _selectedRoles =
                    selectedValues; // Update the selected roles with the new values
              });
            },
          ),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildLabeledTextField(
                leftLabel, leftHint, JoinUsSVG.person, leftController),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: CustomDropdownField(
              label: rightLabel,
              items: rightItems,
              // Use the passed options for the dropdown
              // Pass the list of selected values
              onChanged: (selectedValues) {
                setState(() {
                  _selectedRoles =
                      selectedValues; // Update the selected roles with the new values
                });
              },
            ),
          ),
        ],
      );
    }
  }

  Widget _buildDropdownTextFieldsRow(
    String leftLabel,
    List<String> leftItems,
    String rightLabel,
    List<String> rightItems,
    String? leftValue,
    String? rightValue,
    bool isSmallScreen,
  ) {
    if (isSmallScreen) {
      return Column(
        children: [
          _buildDropdownField(leftLabel, leftItems, leftValue, (value) {
            setState(() {
              _selectedCountry = value;
            });
          }),
          SizedBox(height: 12.0),
          _buildDropdownField(rightLabel, rightItems, rightValue, (value) {
            setState(() {
              _selectedState = value;
            });
          }),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child:
                _buildDropdownField(leftLabel, leftItems, leftValue, (value) {
              setState(() {
                _selectedCountry = value;
              });
            }),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: _buildDropdownField(rightLabel, rightItems, rightValue,
                (value) {
              setState(() {
                _selectedState = value;
              });
            }),
          ),
        ],
      );
    }
  }

  Widget _buildDropdownTextFieldsRow1(
      String leftLabel,
      List<String> leftItems,
      String rightLabel,
      List<String> rightItems,
      String? leftValue,
      String? rightValue,
      bool isSmallScreen,
      ) {
    if (isSmallScreen) {
      return Column(
        children: [
          _buildDropdownField(leftLabel, leftItems, leftValue, (value) {
            setState(() {
              _selectedDistrict = value;
            });
          }),
          SizedBox(height: 12.0),
          _buildDropdownField(rightLabel, rightItems, rightValue, (value) {
            setState(() {
              _selectedCity = value;
            });
          }),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child:
            _buildDropdownField(leftLabel, leftItems, leftValue, (value) {
              setState(() {
                _selectedDistrict = value;
              });
            }),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: _buildDropdownField(rightLabel, rightItems, rightValue,
                    (value) {
                  setState(() {
                    _selectedCity = value;
                  });
                }),
          ),
        ],
      );
    }
  }

  Widget _buildDropdownField(
    String label,
    List<String> items,
    String? currentValue,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16.0, color: Colors.white)),
        SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: DropdownButtonFormField<String>(
            value: items.contains(currentValue) ? currentValue : null,
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: TextStyle(color: Colors.white)),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Color.fromARGB(34, 165, 164, 164),
            ),
            dropdownColor: const Color.fromARGB(255, 47, 45, 45),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildLabeledTextFieldsWithSeparateButtons(
    String leftLabel,
    String leftHint,
    String leftButtonLabel,
    String rightButtonLabel,
    String leftIconPath,
    String rightIconPath,
    TextEditingController leftController,
    bool isSmallScreen,
  ) {
    if (isSmallScreen) {
      return Column(
        children: [
          _buildLabeledTextFieldWithSeparateButtons(leftLabel, leftHint,
              leftIconPath, leftButtonLabel, leftController),
          SizedBox(height: 12.0),
          _buildLabeledTextFieldWithSeparateButtons(
              'Upload', '', rightIconPath, rightButtonLabel, null),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildLabeledTextFieldWithSeparateButtons(leftLabel,
                leftHint, leftIconPath, leftButtonLabel, leftController),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: _buildLabeledTextFieldWithSeparateButtons(
                'Upload', '', rightIconPath, rightButtonLabel, null),
          ),
        ],
      );
    }
  }

  Widget _buildLabeledTextFieldWithSeparateButtons(String label, String hint,
      String iconPath, String buttonLabel, TextEditingController? controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        Stack(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: isTrue ? 'File Uploaded' : hint,
                hintStyle: TextStyle(
                  color:
                      const Color.fromARGB(255, 255, 255, 255).withOpacity(0.6),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    iconPath,
                    color: Color.fromARGB(255, 235, 231, 11),
                  ),
                ),
                suffixIcon: TextButton(
                  onPressed: () {
                    // Handle button action here
                    if (buttonLabel == 'Location') {
                      // Handle location logic
                      LocationPopup.show(context,
                      onLocationSelected: (LatLng selectedLocation){
                        controller?.text = 'Lat: ${selectedLocation.latitude}, Lng: ${selectedLocation.longitude}';
                        latitude = selectedLocation.latitude.toString();
                        longitude = selectedLocation.longitude.toString();
                      });
                    } else if (buttonLabel == 'Upload') {
                      // Handle upload logic
                      handleFileUpload();
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    backgroundColor:
                        Color.fromARGB(255, 139, 138, 142).withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    buttonLabel,
                    style: TextStyle(
                      color: Color.fromARGB(255, 235, 231, 11),
                    ),
                  ),
                ),
              ),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLabeledTextField(String label, String hint, String iconPath,
      TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16.0, color: Colors.white)),
        SizedBox(height: 8.0),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                iconPath,
                color: Color.fromARGB(255, 235, 231, 11),
              ),
            ),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Future<void> getRoles() async {
    var client = BrowserClient(); // Use BrowserClient for web-specific requests
    try {
      print("Fetching roles from the API...");
      var res = await client.get(
        Uri.parse(urlRoles),
        headers: {'Content-Type': 'application/json'},
      );
      print('Status Code: ${res.statusCode}');
      print('Response Body: ${res.body}');
      if (res.statusCode == 200) {
        // Parse the response body
        List<dynamic> data = json.decode(res.body);
        // Extract role names and update the state
        setState(() {
          roles = data
              .map((item) => {
                    'roleName': item['roleName'],
                    'responsibilities': item['responsibilities'],
                  })
              .toList();
          resp =
              data.map((item) => item['responsibilities'] as String).toList();
          roleNames = data.map((item) => item['roleName'] as String).toList();

          /*if (roles.isNotEmpty) {
            _selectedRoles = [roles.first]; // or roles[0]
          }
          print(_selectedRoles);*/
        });
        print("Roles fetched successfully.");
      } else {
        // Handle non-200 responses
        print("Failed to fetch roles. Status Code: ${res.statusCode}");
      }
    } catch (e) {
      // Catch any errors that occur during the request
      print(e);
    } finally {
      client.close(); // Ensure the client is closed after the request
    }
  }

  // Function to handle file upload and parse it
  Future<void> handleFileUpload() async {
    Uint8List? fileBytes = await pickExcelFile();

    if (fileBytes != null) {
      try {
        List<Map<String, dynamic>> parsedData = parseExcelToMap(fileBytes);
        isTrue = true;
        setState(() {
          floorSlotData = parsedData; // Update the state with the parsed data
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error parsing Excel: ${e.toString()}')),
        );
      }
    }
  }

  // Function to pick the Excel file
  Future<Uint8List?> pickExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      return result.files.first.bytes;
    }

    return null;
  }

  /// Function to parse the Excel data and transform it into the desired format
  List<Map<String, dynamic>> parseExcelToMap(Uint8List fileBytes) {
    var excel = Excel.decodeBytes(fileBytes); // Decode the Excel file bytes

    String sheetName =
        excel.tables.keys.first; // Assuming you are reading the first sheet
    var sheet = excel.tables[sheetName]; // Access the sheet

    // Ensure the sheet is not empty
    if (sheet == null || sheet.maxCols == 0 || sheet.maxRows == 0) {
      throw Exception("Sheet is empty or invalid.");
    }

    List<Map<String, dynamic>> floorSlotData = [];

    // The first row should contain floor names
    List<dynamic> floorHeaders = sheet.rows[0];

    // Loop through each column (for each floor)
    for (int col = 0; col < floorHeaders.length; col++) {
      var floorCell = floorHeaders[col];
      String? floor = _getCellValue(floorCell); // Get the floor name safely

      if (floor == null || floor.isEmpty)
        continue; // Skip if the floor name is empty

      List<String> slots = [];

      // Start from the second row (index 1) for slot data
      for (int row = 1; row < sheet.maxRows; row++) {
        var slotCell = sheet.rows[row][col]; // Get the slot data
        String? slot = _getCellValue(slotCell); // Safely extract the slot value
        if (slot != null && slot.isNotEmpty) {
          slots.add(slot); // Add the slot to the list
        }
      }

      // Add the floor and its corresponding slot data to the list
      floorSlotData.add({
        "slotNumber": slots,
        "floor": floor,
      });
    }

    return floorSlotData;
  }

  /// Helper function to safely get the value from a cell
  String? _getCellValue(Data? cell) {
    if (cell == null) return null;
    if (cell.value is SharedString) {
      return cell.value.toString(); // Convert SharedString to String
    } else if (cell.value is String) {
      return cell.value as String;
    } else {
      return cell.value?.toString(); // Convert other types to String
    }
  }

  Future<void> submitData() async {

    Map<String,dynamic> userData = {};

    userData.addAll({
      'email' : _emailController.text.toString(),
      'password' : _passwordController.text.toString(),
      'roleName' : 'Admin',
    });

    List<Map<String,dynamic>> roleData = _selectedRoles;

    for (var role in roleData) {
      role["adminName"] = _adminNameController.text.toString();
    }

    List<Map<String,dynamic>> ratesData = [];

    String location = latitude.toString() + ',' + longitude.toString();

    ratesData.add({
      'googleLocation' : location,
      'duration' : '60',
      'charge' : _paymentController.text.toString()
    });

    /*print(floorSlotData);
    print(_propertyNameController.text.toString());
    print(_selectedCity.toString());
    print(_selectedDistrict.toString());
    print(_selectedState.toString());
    print(_selectedCountry.toString());
    print('true');
    print(location);
    print(_adminNameController.text.toString());
    print(userData);
    print(roleData);
    print(ratesData);*/


    var client = BrowserClient(); // Use BrowserClient for web-specific requests
    try {
      var res = await client.post(
        Uri.parse(urlSubmit),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'floorSlotDto': floorSlotData,
          'propertyName' : _propertyNameController.text.toString(),
          'city' : _selectedCity.toString(),
          'district' : _selectedDistrict.toString(),
          'state' : _selectedState.toString(),
          'country' : _selectedCountry.toString(),
          'slotAvailability' : 'true',
          'googleLocation' : location,
          'adminName' : _adminNameController.text.toString(),
          'userDto' : userData,
          'roleDto' : roleData,
          'ratesDto' : ratesData
        }),
      );
      print('Status Code: ${res.statusCode}');
      print('Response Body: ${res.body}');
      if (res.statusCode == 200) {
        print('Success');
      } else {
        // Handle non-200 responses
        print("Failed to send. Status Code: ${res.statusCode}");
      }
    } catch (e) {
      // Catch any errors that occur during the request
      print(e);
    } finally {
      client.close(); // Ensure the client is closed after the request
    }
  }
}