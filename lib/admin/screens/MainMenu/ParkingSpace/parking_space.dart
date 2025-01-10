import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/browser_client.dart';
import 'package:park_it/admin/screens/MainMenu/DashBoard/helpers/slots_model.dart';
import 'package:park_it/common/constants/spring_url.dart';

class ParkingSpacePage extends StatefulWidget {
  final String adminMail;
  const ParkingSpacePage({super.key,required this.adminMail});

  @override
  State<ParkingSpacePage> createState() => _ParkingSpacePageState();
}

class _ParkingSpacePageState extends State<ParkingSpacePage>
    with TickerProviderStateMixin {

  late Future<List<Slots>> fullSlots;

  late TabController _tabController;

  List<String> _floors = [];

  final Map<String, List<String>> _parkingSpaces = {};

  final Set<String> _bookedSpaces = {};

  @override
  void initState() {
    super.initState();
    fullSlots = fetchSlots(widget.adminMail).then((slots) {
      setState(() {
        updateSlotData(slots);
        _tabController = TabController(length: _floors.length, vsync: this);
      });
      return slots;
    });
    _tabController = TabController(length: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Parking Space",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: FutureBuilder<List<Slots>>(
        future: fullSlots,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return _floors.isEmpty
                ? const Center(
              child: Text(
                "No floors available",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
                : TabBarView(
              controller: _tabController,
              children: _floors
                  .map((floor) => _buildFloorPage(floor))
                  .toList(),
            );
          }
        },
      ),
      bottomNavigationBar: _floors.isEmpty
          ? null
          : Material(
        color: Colors.white,
        child: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicator: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(25),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          tabs: _floors.map((floor) {
            return Tab(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  floor,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildFloorPage(String floor) {
    final slots = _parkingSpaces[floor]!;
    final int slotCount = slots.length;

    int rows = 1;
    int columns = slotCount;

    // If the number of slots is greater than or equal to 10, split into rows with a maximum of 5 columns
    if (slotCount >= 10) {
      columns = 5;
      rows = (slotCount / columns).ceil(); // Adjust rows dynamically
    } else {
      // For fewer than 10 slots, distribute them evenly across 2 rows
      rows = 2;
      columns = (slotCount / rows).ceil();
    }

    final double slotWidth = 140.0 * 1.75; // Increased by 1.75 (0.75x increase)
    final double slotHeight = 180.0 * 1.75; // Increased by 1.75 (0.75x increase)
    final double horizontalPadding = 15.0;
    final double verticalPadding = 15.0;

    final double gridWidth = columns * (slotWidth + 2 * horizontalPadding);
    final double gridHeight = (rows * (slotHeight + 2 * verticalPadding));

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView( // Make the content scrollable
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              floor,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: gridWidth,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: _buildParkingGrid(floor, rows, columns, slotWidth, slotHeight),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParkingGrid(String floor, int rows, int columns, double slotWidth, double slotHeight) {
    final slots = _parkingSpaces[floor]!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < rows; i++)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int j = 0; j < columns; j++)
                    if (i * columns + j < slots.length)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                        child: Container(
                          width: slotWidth,
                          height: slotHeight,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage('assets/admin/parking_bg4.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: _getParkingSlotContent(floor, i * columns + j),
                          ),
                        ),
                      ),
                ],
              ),
              // Add a central container after each row (except the last row)
              if (i < rows - 1)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  height: 80, // Adjust the height as per your needs
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/admin/background_image.png'), // Use your desired background image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _getParkingSlotContent(String floor, int index) {
    final slot = _parkingSpaces[floor]![index];
    final isBooked = _bookedSpaces.contains(slot);

    // Find the slot in the fullSlots list
    final slotDetails = fullSlots.then((slots) => slots.firstWhere(
            (s) => s.slotNumber == slot,
        orElse: () => Slots(
            slotId: 0,
            slotNumber: '',
            floor: '',
            vehicleType: '',
            propertyName: '',
            city: '',
            district: '',
            state: '',
            country: '',
            slotAvailability: true,
            googleLocation: '',
            adminName: '',
            adminPhone: '',
            propertyType: '',
            adminMailId: '')));

    return FutureBuilder<Slots>(
      future: slotDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError || !snapshot.hasData) {
          return const Text(
            "Error",
            style: TextStyle(color: Colors.red),
          );
        }

        final slotData = snapshot.data!;
        final isCar = slotData.vehicleType.toLowerCase() == 'car';
        final isBike = slotData.vehicleType.toLowerCase() == 'bike';

        if (isBooked) {
          return Image.asset(
            isCar ? 'assets/admin/car_icon.png' : 'assets/admin/bike.png',
            width: 280,
            height: 280,
          );
        } else {
          return Text(
            slot,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.black87,
            ),
          );
        }
      },
    );
  }


  Future<List<Slots>> fetchSlots(String email) async {
    try {
      var client = BrowserClient();
      final response =
      await client.get(Uri.parse("${SpringUrls.getSlotsURL}?adminMailId=$email"));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Slots.fromJson(data)).toList();
      } else {
        throw Exception(
            "Failed to load profiles. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching profiles: $error");
      return []; // Return an empty list in case of an error
    }
  }

  void updateSlotData(List<Slots> fullSlots) {

    // Update _floors
    _floors.clear();
    _floors.addAll(
        fullSlots
            .map((slot) => slot.floor.trim()) // Trim floor names here
            .toSet() // Ensure unique floor names
            .map((floor) => _formatFloorName(floor)) // Format floor names
    );

    // Update _parkingSpaces
    _parkingSpaces.clear();
    for (String floor in _floors) {
      String originalFloor = _reverseFormatFloorName(floor); // Get the original floor name
      List<String> spaces = fullSlots
          .where((slot) => slot.floor.trim() == originalFloor) // Trim here as well
          .map((slot) => slot.slotNumber)
          .toList();
      _parkingSpaces[floor] = spaces;
    }

    // Update _bookedSpaces
    _bookedSpaces.clear();
    _bookedSpaces.addAll(
        fullSlots
            .where((slot) => !slot.slotAvailability) // Check for booked slots
            .map((slot) => slot.slotNumber)
    );
  }


// Helper function to format floor names (e.g., "Ground" -> "Ground Floor")
  String _formatFloorName(String floor) {
    return floor.trim() + " Floor"; // Trim spaces and append " Floor"
  }

  String _reverseFormatFloorName(String formattedFloor) {
    return formattedFloor.replaceAll(" Floor", "").trim(); // Remove " Floor" and trim
  }


}
