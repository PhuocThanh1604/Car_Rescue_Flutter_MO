import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:flutter/material.dart';

class ActiveBookingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: FrontendConfigs.kBackgrColor,
        child: Card(
          elevation: 2.0,
          margin: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                15.0), // Adjust the border radius as needed
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar
                CircleAvatar(
                  radius: 32.0,
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage('assets/images/profile_one.png'),
                ),

                SizedBox(width: 16.0),

                // User Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Pro Name
                    Text(
                      'Hieu Phan',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    // Premium Badge
                    Row(
                      children: [
                        Icon(
                          Icons.gps_fixed, // Premium badge icon
                          color: Colors.yellow,
                          size: 18.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'FPT Campus',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey, // Slate-dark color
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.work_rounded, // Premium badge icon
                          color: Colors.yellow,
                          size: 18.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'Kéo xe',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey, // Slate-dark color
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 2,
                        ),
                        Container(
                          width: 13.0,
                          height: 12.0,
                          margin: EdgeInsets.only(right: 14.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(
                                255, 255, 225, 0), // Active status color
                          ),
                        ),
                        Text(
                          'Đã được phân công',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey, // Slate-dark color
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
