import 'package:CarRescue/src/presentation/elements/custom_text.dart';
import 'package:CarRescue/src/presentation/view/technician_view/home/layout/widgets/active_booking.dart';
import 'package:CarRescue/src/presentation/view/technician_view/home/layout/widgets/calender.dart';
import 'package:flutter/material.dart';

class TechncianHomePageBody extends StatefulWidget {
  @override
  _TechncianHomePageBodyState createState() => _TechncianHomePageBodyState();
}

class _TechncianHomePageBodyState extends State<TechncianHomePageBody> {
  bool isDisplayed = true;

  // Method to show the shift registration popup
  void _showShiftRegistrationPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CustomText(
            text: 'Đăng kí ca',
            fontWeight: FontWeight.bold,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('9:00 AM - 21:00 PM'),
                onTap: () {
                  // Handle registration logic for 9:00 AM - 5:00 PM
                  Navigator.pop(context); // Close the popup
                },
              ),
              ListTile(
                title: Text('21:00 PM - 9:00 AM'),
                onTap: () {
                  // Handle registration logic for 1:00 PM - 9:00 PM
                  Navigator.pop(context); // Close the popup
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Define the header widget
    Widget headerWidget = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 10, top: 5),
          child: Text(
            'Đơn đang thực hiện ',
            style: TextStyle(
              fontSize: 18.0, // Adjust the font size as needed
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );

    // Define the widget variable based on the condition
    Widget conditionalWidget = isDisplayed
        ? Column(
            children: [
              headerWidget, // Add the header above the ActiveBookingCard
              ActiveBookingCard(),
            ],
          )
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Đơn làm việc của bạn sẽ được hiện thị ở đây.',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          );

    return Scaffold(
      body: Column(
        children: <Widget>[
          conditionalWidget,
          Expanded(
            child: Container(
              child: MyCalendarPage(),
            ),
          )
        ],
      ),

      // Floating Action Button (Add Button)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showShiftRegistrationPopup(
              context); // Show the shift registration popup
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
