import 'dart:async';
import 'dart:ui' as ui;
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/layout/driver_profile_widget.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/trip_details/layout/widgets/trip_details_card.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../elements/round_button.dart';
import '../../layout/driver_home_switch.dart';
import '../../layout/selection_location_widget.dart';
import 'widgets/trip_row_widget.dart';

class TripDetailsBody extends StatefulWidget {
  @override
  State<TripDetailsBody> createState() => TripDetailsBodyState();
}

class TripDetailsBodyState extends State<TripDetailsBody> {
  final Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor? destinationIcon;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Set<Marker> markers = {};
  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future setSourceAndDestinationIcons() async {
    final Uint8List icon1 =
        await getBytesFromAsset('assets/images/marker.png', 240);

    destinationIcon = await BitmapDescriptor.fromBytes(icon1);
    setState(() {});
    return Future.value(true);
  }

  @override
  void initState() {
    setSourceAndDestinationIcons().then((value) {
      markers.addAll([
        Marker(
            markerId: const MarkerId('2'),
            position: const LatLng(37.42796133580664, -122.085749655962),
            icon: destinationIcon!),
        // Polyline(polylineId: )
      ]);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(markers.length);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(children: [
            const RideSelectionCard(),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 200,
              child: GoogleMap(
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                mapToolbarEnabled: false,
                markers: markers,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Card(
              elevation: 0.5,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              child: SizedBox(
                height: 87,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "\$56.00",
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      text: "Payment made successfully by cash",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: FrontendConfigs.kIconColor,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Card(
              elevation: 0.5,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              child: SizedBox(
                height: 87,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "14 min",
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                          CustomText(
                            text: "Time",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: FrontendConfigs.kIconColor,
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        color: FrontendConfigs.kIconColor,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "10 km",
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                          CustomText(
                            text: "Distance",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: FrontendConfigs.kIconColor,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Card(
                elevation: 0.5,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(children: [
                    const TripRowWidget(
                      title: 'Date & Time',
                      value: 'Jul 10 2022',
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const TripRowWidget(
                      title: 'Payment Method',
                      value: 'Credit Card',
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const TripRowWidget(
                      title: 'Service Type',
                      value: 'E - Class',
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Your Ratted',
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        SvgPicture.asset('assets/svg/rating.svg')
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const TripRowWidget(
                      title: 'Trip Fare',
                      value: '\$48.00',
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const TripRowWidget(
                      title: '+Tax',
                      value: '\$2.00',
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const TripRowWidget(
                      title: '+Tolls',
                      value: '\$6.00',
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                  ]),
                ))
          ]),
        ),
      ),
    );
  }
}
