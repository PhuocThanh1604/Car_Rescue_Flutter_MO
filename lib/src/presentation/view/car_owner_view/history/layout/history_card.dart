<<<<<<< HEAD
=======
import 'package:CarRescue/src/models/booking.dart';
import 'package:CarRescue/src/models/vehicle_item.dart';
import 'package:CarRescue/src/presentation/elements/booking_status.dart';
import 'package:CarRescue/src/presentation/elements/empty_state.dart';
import 'package:CarRescue/src/presentation/elements/loading_state.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/booking_details/booking_details_view.dart';
import 'package:CarRescue/src/utils/api.dart';
>>>>>>> origin/MinhAndHieu6
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';
<<<<<<< HEAD

import '../../../../../configuration/frontend_configs.dart';
import '../../layout/selection_location_widget.dart';

class HistoryCard extends StatefulWidget {
  HistoryCard(
      {Key? key,
      required this.name,
      required this.image,
      required this.time,
      required this.btnLabel})
      : super(key: key);
  final String name;
  final String image;
  final String time;
  final String btnLabel;

=======
import 'package:intl/intl.dart';
import '../../../../../configuration/frontend_configs.dart';
// import '../../layout/selection_location_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/booking_list/widgets/selection_location_widget.dart';

class HistoryCard extends StatefulWidget {
  HistoryCard({
    Key? key,
    required this.userId,
    required this.addressesDepart,
    required this.subAddressesDepart,
    required this.addressesDesti,
    required this.subAddressesDesti,
    required this.accountId,
  }) : super(key: key);
  final String userId;
  final String accountId;
  final Map<String, String> addressesDepart;
  final Map<String, String> subAddressesDepart;
  final Map<String, String> addressesDesti;
  final Map<String, String> subAddressesDesti;
>>>>>>> origin/MinhAndHieu6
  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

<<<<<<< HEAD
class _HistoryCardState extends State<HistoryCard> {
  bool isShowDetails = false;
  bool isShowButton = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6), borderSide: BorderSide.none),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 12),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        child: Image.asset(
                          widget.image,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: widget.name,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          CustomText(
                            text: widget.time,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 28,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF2DBB54),
                        fixedSize: const Size(90, 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.btnLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Divider(
              color: FrontendConfigs.kIconColor,
            ),
            isShowDetails
                ? SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 36,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  isShowDetails = !isShowDetails;
                                });
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: FrontendConfigs.kPrimaryColor,
                              )))
                    ],
                  ),
            isShowDetails
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset("assets/svg/location_icon.svg",
                                  color: FrontendConfigs.kPrimaryColor),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomText(
                                text: "6.5 km",
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset("assets/svg/watch_icon.svg"),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomText(
                                text: "15 mins",
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svg/wallet_icon.svg",
                                color: FrontendConfigs.kPrimaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomText(
                                text: "\$56.00",
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Date & Time',
                            color: FrontendConfigs.kIconColor,
                          ),
                          CustomText(
                            text: 'Jul 12, 2022 | 12:30 PM',
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Divider(
                        color: FrontendConfigs.kIconColor,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      RideSelectionWidget(
                        icon: 'assets/svg/pickup_icon.svg',
                        title: 'Pick up Location',
                        body: '089 Stark Gateway',
                        onPressed: () {},
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: DottedLine(
                          direction: Axis.vertical,
                          lineLength: 30,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: Colors.black,
                          dashRadius: 2.0,
                          dashGapLength: 4.0,
                          dashGapRadius: 0.0,
                        ),
                      ),
                      RideSelectionWidget(
                        icon: 'assets/svg/location_icon.svg',
                        title: 'Drop off Location',
                        body: '92676 Orion Meadows',
                        onPressed: () {},
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isShowDetails = !isShowDetails;
                                });
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_up_rounded,
                                color: FrontendConfigs.kPrimaryColor,
                              ))
                        ],
                      )
                    ],
                  )
                : const SizedBox(),
          ],
        ),
=======
class _HistoryCardState extends State<HistoryCard>
    with SingleTickerProviderStateMixin {
  bool isDataLoaded = false;
  List<Booking> completedBookings = [];
  List<Booking> canceledBookings = [];
  AuthService authService = AuthService();
  Map<String, String> addressesDepart = {};
  Map<String, String> subAddressesDepart = {};
  Map<String, String> addressesDesti = {};
  Map<String, String> subAddressesDesti = {};
  double ratingStars = 0.0;
  TabController? _tabController;
  bool isCompletedEmpty = false;
  bool isCanceledEmpty = false;
  void initState() {
    super.initState();
    loadCompletedBookings();
    loadCanceledBookings();

    // loadBookings();
  }

  void loadCompletedBookings() async {
    try {
      final List<Booking> completedBookingsFromAPI =
          await AuthService().fetchCarOwnerBookingByCompleted(widget.userId);

      final apiFeedbacks =
          await authService.fetchFeedbackRatings(widget.userId);
      completedBookingsFromAPI.sort((a, b) {
        if (a.createdAt == null) return 1;
        if (b.createdAt == null) return -1;
        return b.createdAt!.compareTo(a.createdAt!);
      });
      List<Future> vehicleAndFeedbackTasks = [];

      for (Booking booking in completedBookingsFromAPI) {
        vehicleAndFeedbackTasks
            .add(_fetchVehicleAndFeedbacks(booking, apiFeedbacks));
      }

      await Future.wait(vehicleAndFeedbackTasks);

      setState(() {
        completedBookings = completedBookingsFromAPI;
        isDataLoaded = true;
      });
      if (completedBookings.isEmpty) {
        isCompletedEmpty = true;
      }
    } catch (e) {
      // Handle any exceptions that occur during the API request
      print('Error loading bookings: $e');
    }
  }

  void loadCanceledBookings() async {
    try {
      setState(() {
        // This seems like a naming error. You might want to change this to canceledBookings.
        isDataLoaded = false;
      });
      final List<Booking> canceledBookingsFromAPI =
          await AuthService().fetchCarOwnerBookingByCanceled(widget.userId);
      canceledBookingsFromAPI.sort((a, b) {
        if (a.createdAt == null) return 1;
        if (b.createdAt == null) return -1;
        return b.createdAt!.compareTo(a.createdAt!);
      });
      List<Future> vehicleTasks = [];

      for (Booking booking in canceledBookingsFromAPI) {
        vehicleTasks.add(_fetchVehicleForBooking(booking));
      }

      await Future.wait(vehicleTasks);

      setState(() {
        canceledBookings =
            canceledBookingsFromAPI; // This seems like a naming error. You might want to change this to canceledBookings.
        isDataLoaded = true;
      });
      if (canceledBookings.isEmpty) {
        // This seems like a naming error. You might want to change this to canceledBookings.
        isCanceledEmpty = true;
      }
    } catch (e) {
      // Handle any exceptions that occur during the API request
      print('Error loading bookings: $e');
    }
  }

  Future<void> _fetchVehicleForBooking(Booking booking) async {
    Vehicle vehicleInfoFromAPI =
        await authService.fetchVehicleInfo(booking.vehicleId ?? '');
    booking.vehicleInfo = vehicleInfoFromAPI;
  }

  Future<void> _fetchVehicleAndFeedbacks(
      Booking booking, Map<String, Map<String, dynamic>> apiFeedbacks) async {
    Vehicle vehicleInfoFromAPI =
        await authService.fetchVehicleInfo(booking.vehicleId ?? '');

    booking.vehicleInfo = vehicleInfoFromAPI;
    var feedbackForBooking = apiFeedbacks[booking.id];
    booking.rating = feedbackForBooking?['rating']?.toDouble();
    booking.note = feedbackForBooking?['note'];
  }

  // void loadBookings() async {
  //   try {
  //     final List<Booking> data =
  //         await AuthService().fetchCarOwnerBookings(widget.userId, '');
  //     data.sort((a, b) {
  //       if (a.createdAt == null) return 1;
  //       if (b.createdAt == null) return -1;
  //       return b.createdAt!.compareTo(a.createdAt!);
  //     });
  //     for (Booking booking in data) {
  //       Vehicle vehicleInfoFromAPI =
  //           await authService.fetchVehicleInfo(booking.vehicleId ?? '');
  //       booking.vehicleInfo = vehicleInfoFromAPI;

  //       if (booking.status.toUpperCase() == 'COMPLETED') {
  //         final Map<String, Map<String, dynamic>> apiFeedbacks =
  //             await authService.fetchFeedbackRatings(widget.userId);

  //         var feedbackForBooking = apiFeedbacks[booking.id];

  //         booking.rating = feedbackForBooking?['rating']?.toDouble();
  //         booking.note = feedbackForBooking?['note'];

  //         print('Feedbacks from API: ${apiFeedbacks}');
  //       }
  //     }

  //     // Use `setState` to reflect changes
  //     setState(() {
  //       canceledBookings = data.where((booking) {
  //         final status = booking.status.trim().toUpperCase();
  //         return status == 'CANCELLED';
  //       }).toList();
  //       print(canceledBookings);

  //       // Additional line to print the rating for debugging
  //       print('Rating stars: $ratingStars');

  //       isDataLoaded = true; // Mark the data as loaded
  //     });
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: TabBar(
              controller: _tabController,
              indicatorColor: FrontendConfigs.kPrimaryColor,
              tabs: [
                Tab(
                  child: Center(
                    child: Text(
                      'Đã hoàn thành',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Center(
                    child: Text(
                      'Đã hủy',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: FrontendConfigs.kBackgrColor,
              child: TabBarView(
                controller: _tabController,
                children: [
                  !isDataLoaded
                      ? LoadingState()
                      : isCompletedEmpty
                          ? EmptyState()
                          : _buildBookingListView(completedBookings),
                  Column(
                    children: [
                      Expanded(
                        child: !isDataLoaded
                            ? LoadingState()
                            : isCanceledEmpty
                                ? EmptyState()
                                : _buildOtherListView(canceledBookings),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleRefresh() async {
    // Call setState to reload the screen or perform other refresh logic
    setState(() {
      loadCanceledBookings();
      loadCompletedBookings();
    });
    // Wait for a short delay to simulate network refresh
    await Future.delayed(Duration(seconds: 6));
  }

  Widget _buildBookingListView(List<Booking> bookings) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];

          String formattedStartTime = DateFormat('dd/MM/yyyy | HH:mm')
              .format(booking.createdAt ?? DateTime.now());

          return Container(
            color: FrontendConfigs.kBackgrColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color.fromARGB(86, 115, 115, 115),
                            width: 2.0,
                          ),
                          color: Color.fromARGB(0, 255, 255, 255),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(115, 47, 47, 47),
                          backgroundImage:
                              AssetImage('assets/images/logocarescue.png'),
                          radius: 20,
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: CustomText(
                          text: formattedStartTime,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(booking.rescueType),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                child: Text(
                                  '${booking.vehicleInfo!.licensePlate}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: FrontendConfigs.kAuthColor),
                                ),
                              ),
                              Text(
                                ' | ${booking.vehicleInfo!.manufacturer}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: FrontendConfigs.kAuthColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(booking.note ?? 'Không có'),
                          BookingStatus(
                              status: booking
                                  .status), // Your existing BookingStatus widget
                          SizedBox(height: 8.0),
                          if (booking.status.toUpperCase() ==
                              'COMPLETED') // Spacing
                            Container(
                              child: RatingBar.builder(
                                itemSize: 12,
                                initialRating: booking.rating!,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  size: 10,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            )
                        ],
                      ),
                    ),
                    Divider(
                      color: FrontendConfigs.kIconColor,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      "assets/svg/location_icon.svg",
                                      color: FrontendConfigs.kIconColor),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CustomText(
                                      text: '6.5km',
                                      fontWeight: FontWeight.w600,
                                      color: FrontendConfigs.kAuthColor)
                                ],
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset("assets/svg/watch_icon.svg",
                                      color: FrontendConfigs.kIconColor),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CustomText(
                                      text: "15 mins",
                                      fontWeight: FontWeight.w600,
                                      color: FrontendConfigs.kAuthColor)
                                ],
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/wallet_icon.svg",
                                    color: FrontendConfigs.kIconColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CustomText(
                                      text: "\$56.00",
                                      fontWeight: FontWeight.w600,
                                      color: FrontendConfigs.kAuthColor)
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: FrontendConfigs.kIconColor,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: RideSelectionWidget(
                            icon: 'assets/svg/pickup_icon.svg',
                            title: widget.addressesDepart[booking.id] ??
                                '', // Use addresses parameter
                            body: widget.subAddressesDepart[booking.id] ?? '',
                            onPressed: () {},
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 29),
                          child: DottedLine(
                            direction: Axis.vertical,
                            lineLength: 30,
                            lineThickness: 1.0,
                            dashLength: 4.0,
                            dashColor: Colors.black,
                            dashRadius: 2.0,
                            dashGapLength: 4.0,
                            dashGapRadius: 0.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: RideSelectionWidget(
                            icon: 'assets/svg/location_icon.svg',
                            title: widget.addressesDesti[booking.id] ?? '',
                            body: widget.subAddressesDesti[booking.id] ?? '',
                            onPressed: () {},
                          ),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            TextButton(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookingDetailsView(
                                        userId: widget.userId,
                                        accountId: widget.accountId,
                                        booking: booking,
                                        addressesDepart: widget.addressesDepart,
                                        addressesDesti: widget.addressesDesti,
                                        subAddressesDepart:
                                            widget.subAddressesDepart,
                                        subAddressesDesti:
                                            widget.subAddressesDesti),
                                  ),
                                );
                              },
                              child: CustomText(
                                text: 'Chi tiết',
                                fontWeight: FontWeight.bold,
                                color: FrontendConfigs.kAuthColor,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOtherListView(List<Booking> bookings) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];

          String formattedStartTime = DateFormat('dd/MM/yyyy | HH:mm')
              .format(booking.createdAt ?? DateTime.now());

          return Container(
            color: FrontendConfigs.kBackgrColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color.fromARGB(86, 115, 115, 115),
                            width: 2.0,
                          ),
                          color: Color.fromARGB(0, 255, 255, 255),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(115, 47, 47, 47),
                          backgroundImage:
                              AssetImage('assets/images/logocarescue.png'),
                          radius: 20,
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: CustomText(
                          text: formattedStartTime,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(booking.rescueType),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                child: Text(
                                  '${booking.vehicleInfo!.licensePlate}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: FrontendConfigs.kAuthColor),
                                ),
                              ),
                              Text(
                                ' | ${booking.vehicleInfo!.manufacturer}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: FrontendConfigs.kAuthColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(booking.note ?? 'Không có'),
                          BookingStatus(
                              status: booking
                                  .status), // Your existing BookingStatus widget
                          SizedBox(height: 8.0),
                          if (booking.status.toUpperCase() ==
                              'COMPLETED') // Spacing
                            Container(
                              child: RatingBar.builder(
                                itemSize: 12,
                                initialRating: booking.rating!,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  size: 10,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            )
                        ],
                      ),
                    ),
                    Divider(
                      color: FrontendConfigs.kIconColor,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      "assets/svg/location_icon.svg",
                                      color: FrontendConfigs.kIconColor),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CustomText(
                                      text: '6.5km',
                                      fontWeight: FontWeight.w600,
                                      color: FrontendConfigs.kAuthColor)
                                ],
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset("assets/svg/watch_icon.svg",
                                      color: FrontendConfigs.kIconColor),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CustomText(
                                      text: "15 mins",
                                      fontWeight: FontWeight.w600,
                                      color: FrontendConfigs.kAuthColor)
                                ],
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/wallet_icon.svg",
                                    color: FrontendConfigs.kIconColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CustomText(
                                      text: "\$56.00",
                                      fontWeight: FontWeight.w600,
                                      color: FrontendConfigs.kAuthColor)
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: FrontendConfigs.kIconColor,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: RideSelectionWidget(
                            icon: 'assets/svg/pickup_icon.svg',
                            title: widget.addressesDepart[booking.id] ??
                                '', // Use addresses parameter
                            body: widget.subAddressesDepart[booking.id] ?? '',
                            onPressed: () {},
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 29),
                          child: DottedLine(
                            direction: Axis.vertical,
                            lineLength: 30,
                            lineThickness: 1.0,
                            dashLength: 4.0,
                            dashColor: Colors.black,
                            dashRadius: 2.0,
                            dashGapLength: 4.0,
                            dashGapRadius: 0.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: RideSelectionWidget(
                            icon: 'assets/svg/location_icon.svg',
                            title: widget.addressesDesti[booking.id] ?? '',
                            body: widget.subAddressesDesti[booking.id] ?? '',
                            onPressed: () {},
                          ),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            TextButton(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookingDetailsView(
                                        userId: widget.userId,
                                        accountId: widget.accountId,
                                        booking: booking,
                                        addressesDepart: widget.addressesDepart,
                                        addressesDesti: widget.addressesDesti,
                                        subAddressesDepart:
                                            widget.subAddressesDepart,
                                        subAddressesDesti:
                                            widget.subAddressesDesti),
                                  ),
                                );
                              },
                              child: CustomText(
                                text: 'Chi tiết',
                                fontWeight: FontWeight.bold,
                                color: FrontendConfigs.kAuthColor,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
>>>>>>> origin/MinhAndHieu6
      ),
    );
  }
}
