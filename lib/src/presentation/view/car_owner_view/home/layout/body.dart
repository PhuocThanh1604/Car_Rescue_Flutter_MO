import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gillar/src/presentation/view/car_owner_view/layout/driver_home_switch.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../home_view.dart';
import 'widgets/request_bottom_sheet.dart';

class DriverHomeBody extends StatefulWidget {
  @override
  State<DriverHomeBody> createState() => DriverHomeBodyState();
}

class DriverHomeBodyState extends State<DriverHomeBody> {
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
        await getBytesFromAsset('assets/images/passenger_marker.png', 120);

    destinationIcon = await BitmapDescriptor.fromBytes(icon1);
    setState(() {});
    return Future.value(true);
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 5),(){
      requestBottomSheet(context);
    });
    setSourceAndDestinationIcons().then((value) {
      markers.addAll([
        Marker(
            markerId: const MarkerId('2'),
            position: const LatLng(37.42796133580664, -122.085749655962),
            icon: destinationIcon!),
      ]);
      setState(() {});
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    print(markers.length);
    return Stack(children: [
      GoogleMap(
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        mapToolbarEnabled: false,
        markers: markers,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
       SwitchWidget(onPressed: () { scaffoldKey.currentState?.openDrawer(); },),

    ]);
  }
}
