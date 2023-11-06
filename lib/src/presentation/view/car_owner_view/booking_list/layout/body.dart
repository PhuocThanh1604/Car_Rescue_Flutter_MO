import 'package:CarRescue/src/models/customer.dart';
import 'package:CarRescue/src/models/vehicle_item.dart';
import 'package:CarRescue/src/presentation/elements/booking_status.dart';
import 'package:CarRescue/src/models/booking.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/booking_list/widgets/selection_location_widget.dart';
import 'package:CarRescue/src/utils/api.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/booking_details/booking_details_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
// Import the geocoding package

class BookingListBody extends StatefulWidget {
  final List<Booking> bookings; // Define the list of bookings
  final String userId;

  final Map<String, String> addressesDepart;
  final Map<String, String> subAddressesDepart;
  final Map<String, String> addressesDesti;
  final Map<String, String> subAddressesDesti;
  BookingListBody({
    Key? key,
    required this.bookings,
    required this.userId,
    required this.addressesDepart,
    required this.subAddressesDepart,
    required this.subAddressesDesti,
    required this.addressesDesti,
  }) : super(key: key);

  @override
  _BookingListBodyState createState() => _BookingListBodyState();
}

class _BookingListBodyState extends State<BookingListBody> {
  List<Booking> assignedBookings = [];
  List<Booking> otherBookings = [];
  String addressDep = '';
  AuthService authService = AuthService();
  bool isDataLoaded = false;
  Vehicle? vehicleInfo;
  @override
  void initState() {
    super.initState();
    separateBookings();
  }

  void separateBookings() async {
    try {
      final List<Booking> data =
          await AuthService().fetchCarOwnerBookings(widget.userId, '');
      print(data);
      data.sort((a, b) {
        if (a.startTime == null && b.startTime == null)
          return 0; // Both are null, so they're considered equal
        if (a.startTime == null)
          return 1; // a is null, so it should come after b
        if (b.startTime == null)
          return -1; // b is null, so it should come after a
        return b.startTime!.compareTo(
            a.startTime!); // Both are non-null, proceed with the comparison
      });

      for (Booking booking in data) {
        Vehicle vehicleInfoFromAPI =
            await authService.fetchVehicleInfo(booking.vehicleId ?? '');
        booking.vehicleInfo = vehicleInfoFromAPI;
      }

      // Use `setState` to reflect changes
      setState(() {
        assignedBookings = data.where((booking) {
          final status = booking.status.trim().toUpperCase();
          return status == 'ASSIGNED';
        }).toList();

        otherBookings = data.where((booking) {
          final status = booking.status.trim().toUpperCase();
          return status != 'ASSIGNED';
        }).toList();

        isDataLoaded = true; // Mark the data as loaded
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isDataLoaded) {
      return Center(child: CircularProgressIndicator());
    }
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              child: TabBar(
                indicatorColor: FrontendConfigs.kPrimaryColor,
                tabs: [
                  Tab(
                    child: Center(
                      child: Text(
                        'Đang hoạt động',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Center(
                      child: Text(
                        'Lịch sử đơn hàng',
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
                  children: [
                    _buildBookingListView(assignedBookings),
                    Column(
                      children: [
                        Expanded(
                          child: _buildBookingListView(otherBookings),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingListView(List<Booking> bookings) {
    return ListView.builder(
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
                    trailing: BookingStatus(
                        status:
                            booking.status), // Use the BookingStatusWidget here
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
                                SvgPicture.asset("assets/svg/location_icon.svg",
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingDetailsView(
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
    );
  }
}