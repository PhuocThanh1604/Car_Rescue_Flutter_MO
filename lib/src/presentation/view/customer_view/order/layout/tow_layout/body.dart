import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TowBody extends StatefulWidget {
  final LatLng latLng;
  final String address;
  
  const TowBody({super.key, required this.latLng, required this.address});

  @override
  State<TowBody> createState() => _TowBodyState();
}

class _TowBodyState extends State<TowBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Tow"),
            Text("Latitude: ${widget.latLng.latitude}"),
            Text("Longitude: ${widget.latLng.longitude}"),
            Text("Address: ${widget.address}"),
          ],
        )
    );
  }
}