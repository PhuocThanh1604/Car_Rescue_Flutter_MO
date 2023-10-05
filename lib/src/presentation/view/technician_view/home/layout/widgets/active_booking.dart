import 'package:flutter/material.dart';

class ActiveBookingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE0AC69),
            Color(0xFF8D5524)
          ], // Customize gradient colors here
        ),
        borderRadius:
            BorderRadius.circular(8.0), // Optional: Add rounded corners
      ),
      child: Card(
        elevation: 2.0,
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        'Towing',
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
                        'Assigned',
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
      ),
    );
  }
}
