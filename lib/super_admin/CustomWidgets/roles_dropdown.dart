import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropdownField extends StatefulWidget {
  final String label;
  final List<Map<String, dynamic>> items; // List of role maps
  final ValueChanged<List<Map<String, dynamic>>>
  onChanged; // Callback with selected items
  final double spaceBelow;

  const CustomDropdownField({
    required this.label,
    required this.items,
    required this.onChanged,
    this.spaceBelow = 8.0,
  });

  @override
  _CustomDropdownFieldState createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  final GlobalKey _key = GlobalKey();
  bool _isDropdownOpen = false;
  OverlayEntry? _overlayEntry;
  List<Map<String, dynamic>> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    // Pre-select and lock the first item if available
    if (widget.items.isNotEmpty) {
      _selectedItems = [widget.items[0]]; // Pre-select the first item
    }
  }

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
    if (_isDropdownOpen) {
      _showDropdown();
    } else {
      _removeDropdown();
    }
  }

  void _showDropdown() {
    final RenderBox renderBox =
    _key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    final double dropdownHeight = 300.0; // Adjust as needed
    double topPosition = offset.dy + size.height + 5; // Adjusted spacing
    final double screenHeight = MediaQuery.of(context).size.height;

    // Adjust position if the dropdown goes off the screen
    if (topPosition + dropdownHeight > screenHeight) {
      topPosition = offset.dy - dropdownHeight - 5;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: topPosition,
        left: offset.dx,
        width: size.width,
        child: Material(
          color: Colors.transparent,
          child: StatefulBuilder(
            builder: (context, setStateOverlay) {
              return Container(
                width: size.width,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(143, 17, 17, 17),
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: Color.fromARGB(255, 111, 108, 108).withOpacity(0.5),
                    width: 1.8,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.5), blurRadius: 8)
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.items.asMap().entries.map((entry) {
                          int index = entry.key;
                          Map<String, dynamic> item = entry.value;
                          String roleName = item['roleName'] ?? '';
                          bool isSelected = _selectedItems.any(
                                  (selected) => selected['roleName'] == roleName);
                          bool isLocked = index == 0; // Lock only the first item

                          return MouseRegion(
                            cursor: isLocked
                                ? SystemMouseCursors.forbidden
                                : SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                if (isLocked) {
                                  // Do nothing for the locked item
                                  return;
                                }
                                setStateOverlay(() {
                                  // Deselect if already selected, otherwise select
                                  if (isSelected) {
                                    _selectedItems.removeWhere((selected) =>
                                    selected['roleName'] == roleName);
                                  } else {
                                    _selectedItems.add(item);
                                  }
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                constraints: BoxConstraints(
                                  minHeight: 60.0, // Fixed height
                                  maxHeight: 60.0,
                                  minWidth: size.width,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 12.0),
                                margin: EdgeInsets.only(bottom: 8.0),
                                decoration: BoxDecoration(
                                  color: isLocked || isSelected // Check if it's locked or selected
                                      ? Colors.green // Green for locked and selected
                                      : Color.fromARGB(255, 54, 51, 51), // Default color
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      roleName,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0),
                                    ),
                                    Row(
                                      children: [
                                        if (isLocked)
                                          Icon(
                                            Icons.lock,
                                            color: Colors.yellow,
                                            size: 18,
                                          ),
                                        if (isLocked)
                                          SizedBox(width: 8.0), // Spacing between icons
                                        IconButton(
                                          icon: Icon(Icons.question_mark_rounded),
                                          onPressed: () {
                                            _removeDropdown(); // Hide dropdown
                                            showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                backgroundColor: Colors.transparent,
                                                child: Container(
                                                  width: 0.4 * MediaQuery.of(context).size.width,
                                                  padding: EdgeInsets.all(16.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[800],
                                                    borderRadius: BorderRadius.circular(12.0),
                                                    border: Border.all(
                                                      color: const Color.fromARGB(255, 54, 51, 51),
                                                      width: 1.8,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'More about $roleName',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18.0,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      SizedBox(height: 12.0),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: _getDetailedInfo(roleName),
                                                      ),
                                                      SizedBox(height: 16.0),
                                                      Align(
                                                        alignment: Alignment.bottomRight,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text('Close'),
                                                          style: ElevatedButton.styleFrom(
                                                            foregroundColor: Colors.white,
                                                            backgroundColor: Colors.green,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ).then((_) {
                                              if (_isDropdownOpen) {
                                                _showDropdown();
                                              }
                                            });
                                          },
                                          iconSize: 18,
                                          color: Colors.yellow,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        _removeDropdown();

                        // Ensure that ADMIN_USER is always included in _selectedItems
                        if (!_selectedItems.contains(widget.items[0])) {
                          _selectedItems.insert(0, widget.items[0]);
                        }

                        // Call the callback with the selected items
                        widget.onChanged(_selectedItems);
                      },
                      child: Text('Confirm Selection'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                      ),
                    ),

                  ],
                ),
              );
            },
          ),
        ),
      ),
    );

    Overlay.of(context)!.insert(_overlayEntry!);
  }

  void _removeDropdown() {
    _isDropdownOpen = false;
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  List<Widget> _getDetailedInfo(String roleName) {
    switch (roleName) {
      case 'ADMIN_USER':
        return [
          const Text(
            '• Admin: Full access to all features and settings.',
            style: TextStyle(color: Colors.white70, fontSize: 14.0),
          ),
        ];
      case 'NEW_USER':
        return [
          const Text(
            '• Barcode Payment: New users can initiate and complete barcode-based payments.',
            style: TextStyle(color: Colors.white70, fontSize: 14.0),
          ),
        ];
      default:
        return [
          const Text(
            '• No additional responsibilities assigned.',
            style: TextStyle(color: Colors.white70, fontSize: 14.0),
          ),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
              fontSize: screenWidth > 600 ? 18.0 : 16.0, color: Colors.white),
        ),
        SizedBox(height: widget.spaceBelow),
        GestureDetector(
          key: _key,
          onTap: _toggleDropdown,
          child: Container(
            width: screenWidth * 0.8, // Responsive width
            height: screenHeight > 600 ? 50.0 : 45.0,
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 54, 51, 51),
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: const Color.fromARGB(255, 111, 108, 108),
                width: 1.8,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedItems.isEmpty
                      ? 'Select ${widget.label}'
                      : _selectedItems
                      .map((item) => item['roleName'])
                      .join(', '),
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                Icon(
                  _isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



/*import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class CustomDropdownField extends StatefulWidget {
  final String label;
  final List<String> items;
  final String? currentValue;
  final ValueChanged<String?> onChanged;
  final double spaceBelow;

  const CustomDropdownField({
    required this.label,
    required this.items,
    required this.currentValue,
    required this.onChanged,
    this.spaceBelow = 8.0,
  });

  @override
  _CustomDropdownFieldState createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  final GlobalKey _key = GlobalKey();
  bool _isDropdownOpen = false;
  String? _hoveredItem;
  OverlayEntry? _overlayEntry;

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
    if (_isDropdownOpen) {
      _showDropdown();
    } else {
      _removeDropdown();
    }
  }

  void _showDropdown() {
    final RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    final double dropdownHeight = 200.0; // Adjust this based on your dropdown's height

    double topPosition = offset.dy + size.height + 25; // Space below the trigger widget

    final double screenHeight = MediaQuery.of(context).size.height;
    if (topPosition + dropdownHeight > screenHeight) {
      topPosition = offset.dy - dropdownHeight - 25; // Space above the trigger widget
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: topPosition,
        left: offset.dx,
        width: size.width,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: size.width,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(143, 17, 17, 17),
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: Color.fromARGB(255, 111, 108, 108).withOpacity(0.5), // Border color
                width: 1.8, // Border width
              ),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 8)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.items.map((item) {
                return MouseRegion(
                  onEnter: (_) => setState(() => _hoveredItem = item),
                  onExit: (_) => setState(() => _hoveredItem = null),
                  child: GestureDetector(
                    onTap: () {
                      widget.onChanged(item);
                      _toggleDropdown(); // Close dropdown after selection
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                      margin: EdgeInsets.only(bottom: 8.0),
                      decoration: BoxDecoration(
                        color: widget.currentValue == item
                            ? Colors.green
                            : _hoveredItem == item
                            ? const Color.fromARGB(255, 158, 158, 159)
                            : const Color.fromARGB(255, 54, 51, 51),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item,
                            style: TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                          SizedBox(height: 8.0),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'This is a paragraph for $item. It provides additional information about the role. ',
                                  style: TextStyle(color: Colors.white70, fontSize: 14.0),
                                ),
                                TextSpan(
                                  text: 'Read more',
                                  style: TextStyle(color: const Color.fromARGB(255, 33, 243, 72), fontSize: 14.0, decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()..onTap = () {
                                    _removeDropdown(); // Ensure dropdown is hidden
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        backgroundColor: Colors.transparent,
                                        child: Container(
                                          width: 0.4 * MediaQuery.of(context).size.width, // Responsive width
                                          padding: EdgeInsets.all(16.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[800],
                                            borderRadius: BorderRadius.circular(12.0),
                                            border: Border.all(
                                              color:  const Color.fromARGB(255, 54, 51, 51), // Border color
                                              width: 1.8, // Border width
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'More about $item',
                                                style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(height: 12.0),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: _getDetailedInfo(item),
                                              ),
                                              SizedBox(height: 16.0),
                                              Align(
                                                alignment: Alignment.bottomRight,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Close'),
                                                  style: ElevatedButton.styleFrom(
                                                    foregroundColor: Colors.white, backgroundColor: Colors.green, // Text color
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ).then((_) {
                                      // Re-open dropdown if it was open before dialog
                                      if (_isDropdownOpen) {
                                        _showDropdown();
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)!.insert(_overlayEntry!);
  }

  void _removeDropdown() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  List<Widget> _getDetailedInfo(String item) {
    // Debug print to check item value
    print('Selected item: $item');

    switch (item) {
      case 'Admin':
        return [
          Text('• View Live Parking: Admin can monitor all ongoing parking activities in real-time.', style: TextStyle(color: Colors.white70, fontSize: 14.0)),
          SizedBox(height: 4.0),
          Text('• View Parking History: Admin can filter and view historical parking data by specific dates.', style: TextStyle(color: Colors.white70, fontSize: 14.0)),
          SizedBox(height: 4.0),
          Text('• Expand User Entries: Admin can expand individual entries in the dashboard to see detailed information about a user and their parking history.', style: TextStyle(color: Colors.white70, fontSize: 14.0)),
          SizedBox(height: 4.0),
          Text('• Blacklist Theft Vehicle: Admin can blacklist vehicles flagged for suspicious or illegal activity.', style: TextStyle(color: Colors.white70, fontSize: 14.0)),
          SizedBox(height: 4.0),
          Text('• Remove User: Admin can remove users from the system if necessary.', style: TextStyle(color: Colors.white70, fontSize: 14.0)),
          SizedBox(height: 4.0),
          Text('• Manual Slot Allocation: Admin can manually allocate parking slots in case of system issues or user requests.', style: TextStyle(color: Colors.white70, fontSize: 14.0)),
        ];

      default:
        return [
          Text('• View Parking History: Normal users can view their own parking history.', style: TextStyle(color: Colors.white70, fontSize: 14.0)),
          SizedBox(height: 4.0),
          Text('• Manage Payments: Normal users can handle their own payments and transactions.', style: TextStyle(color: Colors.white70, fontSize: 14.0)),
          SizedBox(height: 4.0),
          Text('• Reserve Parking Spots: Normal users can reserve parking spots in advance.', style: TextStyle(color: Colors.white70, fontSize: 14.0)),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontSize: screenWidth > 600 ? 18.0 : 16.0, color: Colors.white),
        ),
        SizedBox(height: widget.spaceBelow),
        GestureDetector(
          key: _key,
          onTap: _toggleDropdown,
          child: Container(
            width: screenWidth * 0.8, // Responsive width
            height: screenHeight > 600 ? 55.0 : 45.0, // Responsive height
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: const Color.fromARGB(255, 81, 81, 81).withOpacity(0.5), // Border color
                width: 0.5, // Border width
              ),
            ),
            child: Text(
              widget.currentValue ?? 'Select an option',
              style: TextStyle(color: Colors.white, fontSize: screenWidth > 600 ? 16.0 : 14.0), // Responsive font size
            ),
          ),
        ),
      ],
    );
  }
}*/
