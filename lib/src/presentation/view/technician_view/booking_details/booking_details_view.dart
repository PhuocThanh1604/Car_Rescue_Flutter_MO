import 'package:CarRescue/src/presentation/elements/custom_appbar.dart';
import 'package:CarRescue/src/presentation/view/technician_view/booking_details/layout/body.dart';
import 'package:flutter/material.dart';

class BookingDetailsView extends StatelessWidget {
  const BookingDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        text: 'Booking Details',
        showText: true,
      ),
      body: BookingDetailsBody(),
    );
  }
}
