import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/models/vehicle_item.dart';
import 'package:CarRescue/src/presentation/elements/quick_access_buttons.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/car_view/car_view.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/booking_list/booking_view.dart';
import 'package:CarRescue/src/models/booking.dart';
import 'package:CarRescue/src/models/booking.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/edit_profile/edit_profile_view.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/profile/profile_view.dart';
import 'package:CarRescue/src/presentation/view/technician_view/home/layout/widgets/active_booking.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/homepage/widgets/calender.dart';
import 'package:CarRescue/src/presentation/view/technician_view/notification/notification_view.dart';
import 'package:CarRescue/src/utils/api.dart';
import 'package:flutter/material.dart';

class CarOwnerHomePageBody extends StatefulWidget {
  final String userId;
  final String fullname;
  final String avatar;
  final String accountId;
  const CarOwnerHomePageBody({
    required this.userId,
    required this.fullname,
    required this.avatar,
    required this.accountId,
  });

  @override
  _CarOwnerHomePageBodyState createState() => _CarOwnerHomePageBodyState();
}

class _CarOwnerHomePageBodyState extends State<CarOwnerHomePageBody> {
  final AuthService authService = AuthService();
  List<Booking> bookings = [];
  List<String> weeklyTasks = [
    "Thứ Hai: \n9:00 - 21:00",
    "Thứ Tư: \n21:00 - 9:00",
    "Thứ Hai: \n9:00 - 21:00",
    "Thứ Tư: \n21:00 - 9:00",
  ];

  DateTime? selectedDate;
  int completedBookings = 0;
  double averageRating = 4.7;

  @override
  void initState() {
    super.initState();
    fetchCarOwnerBookings();
  }

  Future<void> fetchCarOwnerBookings() async {
    try {
      final bookingsFromApi =
          await authService.fetchCarOwnerBookings(widget.userId, 'a');
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

  Widget buildWeeklyTaskSchedule() {
    return Container(
      color: FrontendConfigs.kBackgrColor,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lịch làm việc tuần',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: FrontendConfigs.kAuthColor,
            ),
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: weeklyTasks.map((task) {
              return Container(
                color: FrontendConfigs.kIconColor,
                width: double.infinity,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(10),
                //   gradient: LinearGradient(
                //     colors: [Color(0xffFF5252), Color(0xffFFCDD2)],
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight,
                //   ),
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.grey.withOpacity(0.3),
                //       spreadRadius: 2,
                //       blurRadius: 5,
                //       offset: Offset(0, 3),
                //     ),
                //   ],
                // ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          task,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.work,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget buildPerformanceMetrics() {
    return Container(
      padding: EdgeInsets.all(16),
      color: FrontendConfigs.kBackgrColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hiệu suất làm việc trong tuần',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: FrontendConfigs.kAuthColor,
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
  }

  Widget buildQuickAccessButtons() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: FrontendConfigs.kBackgrColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              QuickAccessButton(
                label: 'Xe của tôi',
                icon: Icons.fire_truck_outlined,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CarListView(
                        userId: widget.userId,
                      ),
                    ),
                  );
                },
              ),
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
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          // Image container
          Container(
            color: FrontendConfigs.kBackgrColor,
            width: double.infinity,
            height: 300,
            child: Opacity(
              opacity: 0.3,
              child: Transform.translate(
                offset: Offset(0, -50), // Shifts the image up by 50 pixels
                child: ClipRect(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image(
                      image: AssetImage('assets/images/towtruck4.png'),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Content with Padding instead of Transform
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  EdgeInsets.only(top: 170), // Pushes content up by 150 pixels
              child: Column(
                children: [
                  buildPerformanceMetrics(),
                  Divider(thickness: 1, height: 0.5),
                  buildQuickAccessButtons(),
                  Divider(
                    thickness: 1,
                    height: 0.5,
                  ),
                  buildWeeklyTaskSchedule(),

                  // ... Add more widgets as needed
                ],
              ),
            ),
          ),
          // Icon overlay
          Positioned(
              top: 65,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileView(
                              userId: widget.userId,
                              accountId: widget.accountId,
                            )),
                  );
                },
                child: CircleAvatar(
                  radius: 32,
                  child: ClipOval(
                    child: Image(
                      image: NetworkImage(widget.avatar),
                      width: 64, // double the radius
                      height: 64, // double the radius
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )),
          // Welcome text on top left
          Positioned(
            top: 75,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Xin chào,',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(206, 130, 130, 130),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${widget.fullname}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.5,
                    color: FrontendConfigs.kAuthColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
