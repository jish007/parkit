import 'package:flutter/material.dart';
import 'package:park_it/admin/screens/MainMenu/Profile/profile_page.dart';

class TableContainer extends StatefulWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final double borderRadius;
  final List<Map<String, dynamic>> data;

  TableContainer({
    required this.data,
    this.width = double.infinity,
    this.height = 400.0,
    this.backgroundColor = const Color.fromARGB(255, 254, 254, 255),
    this.borderRadius = 16.0,
  });

  @override
  _TableContainerState createState() => _TableContainerState();
}

class _TableContainerState extends State<TableContainer> {
  bool _ascending = true; // Sorting state
  int _currentPage = 0;
  int _rowsPerPage = 10; // Rows per page

  void _sortData(String column) {
    setState(() {
      if (_ascending) {
        widget.data.sort((a, b) => a[column].compareTo(b[column]));
      } else {
        widget.data.sort((a, b) => b[column].compareTo(a[column]));
      }
      _ascending = !_ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the start and end indices for the current page
    final start = _currentPage * _rowsPerPage;
    final end = start + _rowsPerPage;
    final dataSlice = widget.data.sublist(start, end < widget.data.length ? end : widget.data.length);

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 255, 255, 255), // Shadow color
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: Text('Username', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Type', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Number Plate', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Time', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          Divider(color: Colors.white70),

          // Rows
          Expanded(
            child: ListView.builder(
              itemCount: dataSlice.length,
              itemBuilder: (context, index) {
                final item = dataSlice[index];
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(child: Text(item['username'])),
                      Expanded(child: Text(item['type'])),
                      Expanded(child: Text(item['numberPlate'])),
                      Expanded(child: Text(item['time'])),
                    ],
                  ),
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => ProfilePage(vehicleNum: item['numberPlate'].toString())));
                    //ProfilePage(vehicleNum: item['numberPlate'].toString());
                  },
                );
              },
            ),
          ),

          // Pagination
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Page ${_currentPage + 1}'),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: _currentPage > 0
                          ? () {
                        setState(() {
                          _currentPage--;
                        });
                      }
                          : null,
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: (start + _rowsPerPage < widget.data.length)
                          ? () {
                        setState(() {
                          _currentPage++;
                        });
                      }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}