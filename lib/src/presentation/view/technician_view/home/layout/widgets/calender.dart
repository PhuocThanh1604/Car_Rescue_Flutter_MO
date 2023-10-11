import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/presentation/view/technician_view/home/layout/widgets/scheduling_task.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../../models/work_shift.dart';
import 'package:intl/intl.dart';

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
      backgroundColor: FrontendConfigs.kBackgrColor, // Background color
      body: SingleChildScrollView(
        // Wrap your column with a SingleChildScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Container for "Works Schedule" with line underneath
            Container(
              // Container background color

              color: Colors.white,
              padding: const EdgeInsets.only(
                  left: 17, top: 8, right: 17, bottom: 8), // Adjust padding
              child: Text(
                'Lịch làm việc',
                style: TextStyle(
                  color: Colors.black, // Text color
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 2), // Adjust the spacing as needed

            // Table Calendar
            Container(
              color: Colors.white, // Container background color
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
                    _showSchedulingCard(context, selectedDay);
                  });
                },
              ),
            ),

            // Divider line under "Active Booking"
          ],
        ),
      ),
    );
  }

  // Function to show the shift details as a modal bottom sheet
  void _showSchedulingCard(BuildContext context, DateTime selectedDay) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDay);
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
            color: Colors.white, // Container background color
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chi tiết',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Text color
                  ),
                ),
                SizedBox(height: 12),
                TaskSchedulingCard(
                  taskTitle: 'Today Work',
                  taskTime: '9:00 AM - 21:00 PM',
                  taskDescription:
                      'Discuss project requirements and finalize the contract details.',
                  taskCreated: '${formattedDate}',
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the modal
                  },
                  child: Text('Đóng'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
