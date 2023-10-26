import 'package:CarRescue/src/models/customer.dart';
import 'package:CarRescue/src/presentation/elements/custom_appbar.dart';
import 'package:CarRescue/src/utils/api.dart';
import 'package:flutter/material.dart';
import 'layout/body.dart';
import '../../../../models/booking.dart';

import 'dart:convert';

class BookingListView extends StatefulWidget {
  const BookingListView({Key? key, required this.userId}) : super(key: key);
  final String userId;
  @override
  _BookingListViewState createState() => _BookingListViewState();
}

enum SortType { statusAssigned, dateNow, defaultSort }

class _BookingListViewState extends State<BookingListView> {
  List<Booking> bookings = [];
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
      final bookingsFromApi = await authService.fetchBookings(
          widget.userId, '97757c05-1a15-4009-a156-e43095dddd81');
      await _getDestiForBookings(bookingsFromApi);
      await _getAddressesForBookings(bookingsFromApi);

      setState(() {
        bookings = bookingsFromApi;

        // Sort by dateNow initially
      });
    } catch (error) {
      print('Error loading data: $error');
    }
  }

  Future<void> _getAddressesForBookings(List<Booking> bookings) async {
    for (Booking booking in bookings) {
      final String departure = booking.departure;

      // Extract latitude and longitude from the departure string
      final latMatch = RegExp(r'lat:\s?([\-0-9.]+)').firstMatch(departure);
      final longMatch = RegExp(r'long:\s?([\-0-9.]+)').firstMatch(departure);

      if (latMatch != null && longMatch != null) {
        final double? lat = double.tryParse(latMatch.group(1) ?? '');
        final double? long = double.tryParse(longMatch.group(1) ?? '');

        if (lat != null && long != null) {
          final addressInfo =
              await authService.getAddressFromCoordinates(lat, long);
          print(lat);
          setState(() {
            addressesDepart[booking.id] =
                addressInfo['address'] ?? 'Address not found';
            subAddressesDepart[booking.id] =
                addressInfo['subAddress'] ?? 'Subaddress not found';
          });
        }
      }
    }
  }

  Future<void> _getDestiForBookings(List<Booking> bookings) async {
    for (Booking booking in bookings) {
      final String destination = booking.destination;

      // Extract latitude and longitude from the destination string
      final latMatch = RegExp(r'lat:\s?([\-0-9.]+)').firstMatch(destination);
      final longMatch = RegExp(r'long:\s?([\-0-9.]+)').firstMatch(destination);

      if (latMatch != null && longMatch != null) {
        final double? lat = double.tryParse(latMatch.group(1) ?? '');
        final double? long = double.tryParse(longMatch.group(1) ?? '');

        if (lat != null && long != null) {
          final addressInfo =
              await authService.getAddressFromCoordinates(lat, long);
          setState(() {
            addressesDesti[booking.id] =
                addressInfo['address'] ?? 'Address not found';
            subAddressesDesti[booking.id] =
                addressInfo['subAddress'] ?? 'Subaddress not found';
          });
        }
      }
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
