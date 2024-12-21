import 'package:flutter/material.dart';
import 'dart:async';

class ParkingSpacePage extends StatefulWidget {
  const ParkingSpacePage({super.key});

  @override
  _ParkingSpacePageState createState() => _ParkingSpacePageState();
}

class _ParkingSpacePageState extends State<ParkingSpacePage> {
  // Timer variables for each parking slot (total 30 slots: 10 per section A, B, C)
  List<int> remainingTimes = List.generate(30, (_) => 300); // Set initial time in seconds (5 minutes)
  late List<Timer> _timers;

  // Sidebar state
  bool _isSidebarOpen = false;
  String selectedSlot = '';

  @override
  void initState() {
    super.initState();

    // Initialize timers for all slots
    _timers = List.generate(
      30,
      (index) => Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          setState(() {
            if (remainingTimes[index] > 0) {
              remainingTimes[index]--;
            } else {
              timer.cancel();
            }
          });
        },
      ),
    );

    // Manually set some slots to 0 (unallocated) in no specific linear order
    remainingTimes[2] = 0;  // Slot AR1C3
    remainingTimes[4] = 0;  // Slot AR2C2
    remainingTimes[13] = 0; // Slot BR3C1
    remainingTimes[17] = 0; // Slot BR4C2
    remainingTimes[22] = 0; // Slot CR1C2
    remainingTimes[28] = 0; // Slot CR5C1
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Parking Space View',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Color.fromARGB(255, 14, 14, 14),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 246, 246, 248),
        elevation: 4,
      ),
      body: Stack(
        children: [
          // Main content
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start, // Align sections to the left
                children: [
                  // Section A with Ac1 and Ac2 (as columns)
                  _buildSection("A", ["AR1C1", "AR1C2", "AR1C3", "AR1C4", "AR1C5"],
                      ["AR2C1", "AR2C2", "AR2C3", "AR2C4", "AR2C5"]),
                  
                  // Space before the vertical line
                  const SizedBox(width: 20), // Add space before the line

                  // Vertical line between sections
                  _buildVerticalLine(),
                  
                  // Space after the vertical line
                  const SizedBox(width: 20), // Add space after the line

                  // Section B with Bc1 and Bc2 (as columns)
                  _buildSection("B", ["BR1C1", "BR1C2", "BR1C3", "BR1C4", "BR1C5"],
                      ["BR2C1", "BR2C2", "BR2C3", "BR2C4", "BR2C5"]),
                  
                  // Space before the vertical line
                  const SizedBox(width: 20), // Add space before the line

                  // Vertical line between sections
                  _buildVerticalLine(),

                  // Space after the vertical line
                  const SizedBox(width: 20), // Add space after the line

                  // Section C with Cc1 and Cc2 (as columns)
                  _buildSection("C", ["CR1C1", "CR1C2", "CR1C3", "CR1C4", "CR1C5"],
                      ["CR2C1", "CR2C2", "CR2C3", "CR2C4", "CR2C5"]),
                ],
              ),
            ),
          ),
          
          // Right Sidebar
          _buildSidebar(),
        ],
      ),
    );
  }

  // Function to build a section with two columns
  Widget _buildSection(String sectionName, List<String> col1Slots, List<String> col2Slots) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section $sectionName',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        const SizedBox(height: 16), // Increased space between section title and slots
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Column 1 (e.g., AR1C1, BR1C1, CR1C1)
            _buildParkingColumn(col1Slots),
            const SizedBox(width: 20), // Space between columns
            // Column 2 (e.g., AR1C2, BR1C2, CR1C2)
            _buildParkingColumn(col2Slots),
          ],
        ),
      ],
    );
  }

  // Function to build a column of parking slots
  Widget _buildParkingColumn(List<String> slots) {
    return Column(
      children: [
        // Add parking slots vertically in this column
        for (int i = 0; i < slots.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0), // Increased space between slots
            child: _buildParkingSlot(slots[i], slots.indexOf(slots[i])),
          ),
      ],
    );
  }

  // Function to build a single parking slot with its timer and progress bar
  Widget _buildParkingSlot(String slotName, int index) {
    double progress = remainingTimes[index] / 300; // Calculate progress (300 seconds = 5 minutes)

    // Check if the slot is unallotted (for simplicity, we can use index 0-5 as unallotted)
    bool isUnallotted = remainingTimes[index] == 0;

    return GestureDetector(
      onTap: () {
        // Show the sidebar when a parking slot is tapped
        if (!isUnallotted) {
          _openSidebar(slotName);
        }
      },
      child: Column(
        children: [
          Text(
            slotName,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isUnallotted ? Colors.grey : Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 100, // Increased width
            height: 100, // Increased height
            decoration: BoxDecoration(
              gradient: isUnallotted
                  ? const LinearGradient(
                      colors: [Colors.grey, Colors.grey],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : const LinearGradient(
                      colors: [Color.fromARGB(255, 116, 19, 201), Colors.blueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                slotName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isUnallotted ? Colors.black : Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 6.0,
                      color: Colors.black54,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 100, // Match width with the parking slot
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: isUnallotted ? 0 : progress,
                minHeight: 8,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to build a vertical shaded line between sections
  Widget _buildVerticalLine() {
    return Container(
      width: 2, // Make line a bit thicker
      height: MediaQuery.of(context).size.height,
      color: Colors.grey.withOpacity(0.5),
    );
  }

  // Function to open the sidebar with parking slot details
  void _openSidebar(String slotName) {
    setState(() {
      selectedSlot = slotName;
      _isSidebarOpen = true;
    });
  }

  // Sidebar widget
  Widget _buildSidebar() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      right: _isSidebarOpen ? 0 : -350,
      top: 0,
      bottom: 0,
      child: GestureDetector(
        onTap: () {
          // Close the sidebar when tapping outside
          setState(() {
            _isSidebarOpen = false;
          });
        },
        child: Container(
          width: 350,
          color: const Color.fromARGB(255, 22, 4, 85).withOpacity(0.5),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Car Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 16),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Demo car image
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildShadedBox('Model: Sedan'),
                  _buildShadedBox('Reg No: XYZ 1234'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildShadedBox('User: John Doe'),
                  _buildShadedBox('Owner: Jane Doe'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildShadedBox('Number Plate: ABC1234'),
                  _buildShadedBox('City: New York'),
                ],
              ),
              const SizedBox(height: 16),
              _buildShadedBox('Payment Status: Paid'),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isSidebarOpen = false; // Close sidebar on button press
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShadedBox(String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  void dispose() {
    // Cancel all timers when the widget is disposed
    for (var timer in _timers) {
      timer.cancel();
    }
    super.dispose();
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ParkingSpacePage(),
  ));
}
