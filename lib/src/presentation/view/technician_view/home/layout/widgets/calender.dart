import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../../models/work_shift.dart';

class MyCalendarPage extends StatefulWidget {
  @override
  _MyCalendarPageState createState() => _MyCalendarPageState();
}

class _MyCalendarPageState extends State<MyCalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late ShiftDetails _selectedShift; // Declare as non-nullable

  // Sample shift data, replace this with your actual data source
  final List<ShiftDetails> _shifts = [
    ShiftDetails(
      date: DateTime(2023, 10, 5),
      time: '9:00 AM - 5:00 PM',
      numberOfSlots: 8,
      managerName: 'John Doe',
    ),
    // Add more shift details here
  ];

  @override
  void initState() {
    super.initState();
    // Initialize _selectedShift with default values
    _selectedShift = ShiftDetails(
      date: DateTime(
          2000, 1, 1), // Provide a default date or other default values
      time: 'N/A',
      numberOfSlots: 0,
      managerName: 'N/A',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Custom Calendar Header
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFE0AC69),
                    Color(0xFF8D5524)
                  ], // Customize gradient colors here
                ),
                borderRadius:
                    BorderRadius.circular(8.0), // Optional: Add rounded corners
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Today works', // Updated header text
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.calendar_month),
                    ],
                  ),
                  SizedBox(height: 5),
                  // Add any additional header elements or widgets here
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: TableCalendar(
                calendarFormat: _calendarFormat,
                focusedDay: _focusedDay,
                firstDay: DateTime(2000),
                lastDay: DateTime(2050),
                startingDayOfWeek: StartingDayOfWeek.sunday,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;

                    // Find the shift details for the selected date
                    _selectedShift = _shifts.firstWhere(
                      (shift) => shift.date == selectedDay,
                      orElse: () => ShiftDetails(
                        date: selectedDay,
                        time: 'N/A',
                        numberOfSlots: 0,
                        managerName: 'N/A',
                      ),
                    );

                    // Display the shift details as a modal bottom sheet
                    _showShiftDetailsModal(context, _selectedShift);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show the shift details as a modal bottom sheet
  void _showShiftDetailsModal(BuildContext context, ShiftDetails shift) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shift Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Date: ${shift.date.toLocal()}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Time: ${shift.time}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Number of Slots: ${shift.numberOfSlots.toString()}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Manager: ${shift.managerName}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the modal
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
