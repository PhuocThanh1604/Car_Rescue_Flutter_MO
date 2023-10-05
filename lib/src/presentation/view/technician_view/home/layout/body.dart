import 'package:CarRescue/src/presentation/view/technician_view/home/layout/widgets/active_booking.dart';
import 'package:CarRescue/src/presentation/view/technician_view/home/layout/widgets/calender.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TechncianHomePageBody extends StatefulWidget {
  @override
  _TechncianHomePageBodyState createState() => _TechncianHomePageBodyState();
}

class _TechncianHomePageBodyState extends State<TechncianHomePageBody> {
  bool isDisplayed = true;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    // String formattedDate = DateFormat('MMM d, y').format(now);

    // Define the widget variable based on the condition
    Widget conditionalWidget = isDisplayed
        ? ActiveBookingCard()
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Your active booking will be shown here',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          );

    return Scaffold(
      body: Column(
        children: <Widget>[
          // Custom Calendar Header

          // Use the conditionalWidget variable
          conditionalWidget,

          // Separator Line

          // Calendar Widget
          Expanded(
            child: Container(
              color: Colors.white, // Adjust the background color
              // Replace 'MyCalendarPage()' with your actual calendar widget
              child: MyCalendarPage(),
            ),
          )
        ],
      ),
    );
  }
}
