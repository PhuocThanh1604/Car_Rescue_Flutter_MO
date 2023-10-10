import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';
import 'package:CarRescue/src/presentation/view/technician_view/booking_details/booking_details_view.dart';
import 'package:CarRescue/src/presentation/view/technician_view/booking_details/layout/body.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Booking {
  final String type;
  final String staffNote;
  final String cancellationReason;
  final DateTime startTime;
  final DateTime endTime;
  final String status;
  final String departure;
  final String destination;

  Booking({
    required this.type,
    required this.staffNote,
    required this.cancellationReason,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.departure,
    required this.destination,
  });
}

class BookingListBody extends StatelessWidget {
  final List<Booking> bookings = [
    Booking(
        type: 'Kéo xe',
        staffNote: 'Please prepare presentation materials.',
        cancellationReason: '',
        startTime: DateTime.now().add(Duration(hours: 1)),
        endTime: DateTime.now().add(Duration(hours: 2)),
        status: 'Completed',
        departure: 'Nhà Văn hóa Sinh viên ĐHQG TP.HCM',
        destination: 'FPT University'),
    Booking(
        type: 'Sữa chửa',
        staffNote: 'Follow-up checkup.',
        cancellationReason: 'Patient rescheduled.',
        startTime: DateTime.now().add(Duration(days: 1)),
        endTime: DateTime.now().add(Duration(days: 1, hours: 2)),
        status: 'Assigned',
        departure: 'FPT Campus',
        destination: 'Crescent Mall Quan 7'),
    Booking(
        type: 'Kéo xe',
        staffNote: 'Agenda and materials ready.',
        cancellationReason: 'Change in schedule.',
        startTime: DateTime.now().add(Duration(days: 2)),
        endTime: DateTime.now().add(Duration(days: 2, hours: 3)),
        status: 'Cancelled',
        departure: 'FPT Campus',
        destination: 'Nha Van Hoa'),
    // Add more bookings here
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];

        // Format the startTime and endTime properties
        String formattedStartTime =
            DateFormat('dd/MM/yyyy | HH:mm').format(booking.startTime);

        // Determine the status background color based on the status
        Color statusColor;
        TextStyle statusTextStyle;
        switch (booking.status.toLowerCase()) {
          case 'completed':
            statusColor = Color(0xffdff6de);
            statusTextStyle = TextStyle(
                color: Color(0xff00721e),
                fontWeight: FontWeight.bold // Text color for 'Completed'
                );
            break;
          case 'assigned':
            statusColor = Color(0xffc9e5fb);
            statusTextStyle = TextStyle(
                color: Color(0xff276fdb),
                fontWeight: FontWeight.bold // Text color for 'Completed'
                );
            break;
          case 'cancelled':
            statusColor = Color.fromARGB(255, 251, 201, 201);
            statusTextStyle = TextStyle(
                color: Color.fromARGB(255, 219, 39, 39),
                fontWeight: FontWeight.bold // Text color for 'Completed'
                );
            break;
          default:
            statusColor = Colors.blue;
            statusTextStyle = TextStyle(
              color: Colors.white, // Text color for 'Completed'
            ); // Default color
            break;
        }

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
                mainAxisSize: MainAxisSize.min,
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
                          backgroundImage: AssetImage(
                            'assets/images/logocarescue.png', // Replace with your avatar image
                          ),
                          radius: 20,
                        ),
                      ),
                      title: CustomText(
                        text: formattedStartTime,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      subtitle: Text(booking.type),
                      trailing: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor, // Status background color
                          borderRadius: BorderRadius.circular(
                              5.0), // Adjust the radius as needed
                        ),
                        child: Text(
                          booking.status, // Display the status text
                          style: statusTextStyle,
                        ),
                      )),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.gps_fixed),
                    title: CustomText(
                      text: booking.departure,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: CustomText(
                      text: booking.destination,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  if (booking.cancellationReason.isNotEmpty)
                    ListTile(
                      leading: Icon(Icons.cancel),
                      title: Text('Cancellation Reason:'),
                      subtitle: Text(booking.cancellationReason),
                    ),
                  ButtonBar(
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookingDetailsView()));
                        },
                        child: Icon(Icons.arrow_right_alt_rounded),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
