import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/utils/api.dart';
import 'package:CarRescue/src/presentation/view/technician_view/booking_list/booking_view.dart';
import 'package:CarRescue/src/models/booking.dart';
import 'package:CarRescue/src/presentation/view/technician_view/home/layout/widgets/active_booking.dart';
import 'package:CarRescue/src/presentation/view/technician_view/home/layout/widgets/calender.dart';
import 'package:CarRescue/src/presentation/elements/quick_access_buttons.dart';
import 'package:CarRescue/src/presentation/view/technician_view/notification/notification_view.dart';
import 'package:flutter/material.dart';

class TechncianHomePageBody extends StatefulWidget {
  final String userId;

  TechncianHomePageBody({
    required this.userId,
  });

  @override
  _TechncianHomePageBodyState createState() => _TechncianHomePageBodyState();
}

class _TechncianHomePageBodyState extends State<TechncianHomePageBody> {
  List<Booking> bookings = [];
  DateTime? selectedDate; // Change the type to DateTime?
  int completedBookings = 0;
  double averageRating = 4.7;
  AuthService authService = AuthService();
  List<String> recentNotifications = [
    "New booking request from John Doe.",
    "Booking with ID #12345 has been updated.",
    "You received a 5-star rating from Jane Smith.",
  ];
  List<String> weeklyTasks = [
    "Thứ Hai: \n9:00 - 21:00",
    "Thứ Tư: \n21:00 - 9:00",
    "Thứ Hai: \n9:00 - 21:00",
    "Thứ Tư: \n21:00 - 9:00",
  ];

  // Method to show the shift registration popup
  void initState() {
    super.initState();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    try {
      final bookingsFromApi =
          await authService.fetchBookings(widget.userId, 'a');
      completedBookings = bookingsFromApi
          .where((booking) => booking.status == 'COMPLETED')
          .length;

      setState(() {
        bookings = bookingsFromApi;
      });
    } catch (error) {
      print('Error loading data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget weeklyTaskScheduleWidget = Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lịch làm việc tuần',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20), // Increase the spacing

          Wrap(
            spacing: 20, // Adjust spacing between items
            runSpacing: 20, // Adjust spacing between rows
            children: weeklyTasks.map((task) {
              return GestureDetector(
                onTap: () {
                  // Handle task click event
                },
                child: Container(
                  width: double.infinity, // Adjust the card width as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 232, 154, 36),
                        Color(0xffF1C27D)
                      ], // Gradient colors
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.work,
                          color: Colors.white,
                          size: 36,
                        ),
                        SizedBox(height: 10),
                        Text(
                          task,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        // You can add more creative content here if needed
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );

    Widget performanceMetricsWidget = Container(
      padding: EdgeInsets.all(16),
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hiệu suất làm việc trong tuần',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tổng đơn', style: TextStyle(fontSize: 16)),
                  Text(
                    completedBookings.toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Đánh giá', style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      Text(
                        averageRating.toStringAsFixed(1),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.star, color: Colors.amber, size: 24),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
    Widget quickAccessButtonsWidget = Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(153, 255, 255, 255)
            .withOpacity(0.9), // Semi-transparent background
        borderRadius: BorderRadius.circular(10), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              QuickAccessButton(
                label: 'Đơn làm việc',
                icon: Icons.menu_book,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BookingListView(userId: widget.userId),
                    ),
                  );
                },
              ),
              QuickAccessButton(
                label: 'Lịch',
                icon: Icons.calendar_today,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyCalendarPage(),
                    ),
                  );
                },
              ),

              QuickAccessButton(
                label: 'Thông báo',
                icon: Icons.notifications,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationView(),
                    ),
                  );
                },
              ),
              // Add more QuickAccessButton widgets as needed
            ],
          ),
        ],
      ),
    );

    // Define the header widget
    Widget headerWidget = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 15),
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
    bool isDisplayed = bookings.any((booking) => booking.status == 'ASSIGNED');
    Widget conditionalWidget = isDisplayed
        ? Column(
            children: [
              headerWidget, // Add the header above the ActiveBookingCard
              for (var booking
                  in bookings.where((booking) => booking.status == 'ASSIGNED'))
                ActiveBookingCard(
                  userId: booking.technicianId ?? '',
                  avatar: 'assets/images/avatars-2.png',
                  booking: booking,
                ),
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

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          performanceMetricsWidget,
          Divider(
            thickness: 2,
            height: 3,
          ),
          quickAccessButtonsWidget,
          Divider(
            thickness: 2,
            height: 1,
          ),
          conditionalWidget,
          Divider(
            thickness: 2,
            height: 1,
          ),
          weeklyTaskScheduleWidget,
          Divider(
            thickness: 2,
            height: 1,
          ),
        ],
      ),
    );

    // Floating Action Button (Add Button)
  }
}
