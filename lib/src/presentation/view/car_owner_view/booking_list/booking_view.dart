import 'package:CarRescue/src/models/vehicle_item.dart';
import 'package:CarRescue/src/models/customer.dart';
import 'package:CarRescue/src/presentation/elements/custom_appbar.dart';
import 'package:CarRescue/src/models/booking.dart';
import 'package:CarRescue/src/utils/api.dart';
import 'package:flutter/material.dart';
import 'layout/body.dart';

class BookingListView extends StatefulWidget {
  const BookingListView({Key? key, required this.userId}) : super(key: key);
  final String userId;
  @override
  _BookingListViewState createState() => _BookingListViewState();
}

enum SortType { statusAssigned, dateNow, defaultSort }

class _BookingListViewState extends State<BookingListView> {
  List<Booking> bookings = [];
  Vehicle? CarInfo;
  AuthService authService = AuthService();
  Map<String, String> addressesDepart = {};
  Map<String, String> subAddressesDepart = {};
  Map<String, String> addressesDesti = {};
  Map<String, String> subAddressesDesti = {};
  String customerName = '';
  String customerPhone = '';
  @override
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final bookingsFromApi =
          await authService.fetchCarOwnerBookings(widget.userId, '');

      await authService.getDestiForBookings(
          bookingsFromApi, setState, addressesDesti, subAddressesDesti);
      await authService.getAddressesForBookings(
          bookingsFromApi, setState, addressesDepart, subAddressesDepart);

      setState(() {
        bookings = bookingsFromApi;

        // Sort by dateNow initially
      });
    } catch (error) {
      print('Error loading data1: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, text: 'Đơn làm việc', showText: true),
      body: BookingListBody(
        userId: widget.userId,
        bookings: bookings,
        addressesDepart: addressesDepart,
        addressesDesti: addressesDesti,
        subAddressesDepart: subAddressesDepart,
        subAddressesDesti: subAddressesDesti,
      ),
    );
  }
}
