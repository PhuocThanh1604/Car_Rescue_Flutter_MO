// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:ui' as ui;
<<<<<<< Updated upstream
=======
import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/models/vehicle_item.dart';
import 'package:CarRescue/src/presentation/elements/custom_appbar.dart';
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:CarRescue/src/presentation/elements/app_button.dart';
import 'package:CarRescue/src/providers/location_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'layout/bottom_sheets/pick_up_sheet.dart';
import 'layout/widget/home_field.dart';
<<<<<<< Updated upstream
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
=======
// import 'package:google_api_headers/google_api_headers.dart';
// import 'package:google_maps_webservice/places.dart';
>>>>>>> Stashed changes

class HomeView extends StatefulWidget {
  Vehicle? vehicle;
  HomeView({
    Key? key,
    required this.vehicle,
  }) : super(key: key);
  @override
  State<HomeView> createState() => HomeViewState();
}

const _kGoogleApiKey = 'AIzaSyB2fhukchi90Nc1P1i-9s2kJRjlEpw4r0k';
final GlobalKey<ScaffoldMessengerState> homeScaffoldKey =
    GlobalKey<ScaffoldMessengerState>();

class HomeViewState extends State<HomeView> {
  final TextEditingController _pickUpController = TextEditingController();
  // final TextEditingController _dropLocationController = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController controller;
  LocationService service = LocationService();
  // final Mode _mode = Mode.overlay;
  StreamSubscription<Position>? _positionStreamSubscription;
  late LatLng _latLng;
  Position? position;
  BitmapDescriptor? destinationIcon;
  bool _isMounted = false;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.762622, 106.660172),
    zoom: 10,
  );

  Future<void> requestLocationPermission() async {
    var res = await Geolocator.checkPermission();
    if (res != LocationPermission.always &&
        res != LocationPermission.whileInUse) {
      await Geolocator.requestPermission();
    }

    // Lấy vị trí hiện tại
    getCurrentLocation();

    // Theo dõi vị trí và cập nhật Marker
    startListeningToLocationUpdates();
  }

  Set<Marker> markers = {};
  // static const CameraPosition _kLake = CameraPosition(
  //   bearing: 192.8334901395799,
  //   target: LatLng(37.43296265331129, -122.08832357078792),
  //   tilt: 59.440717697143555,
  //   zoom: 19.151926040649414,
  // );

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
        await getBytesFromAsset('assets/images/driver_marker.png', 240);

    destinationIcon = BitmapDescriptor.fromBytes(icon1);
  }

  // Cập nhật Marker dựa trên vị trí hiện tại
  void updateMarker(LatLng latLng) {
    markers.clear();
    if (position != null && destinationIcon != null) {
      markers.addAll([
        Marker(
            markerId: const MarkerId('2'),
            position: latLng,
            icon: destinationIcon!),
        // Polyline(polylineId: )
      ]);
      print("Position: $position");
    }
  }

  void _updateCameraPosition(LatLng latLng) async {
    controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng,
          zoom: 15.0, // Điều chỉnh mức zoom theo nhu cầu của bạn
        ),
      ),
    );
    updateMarker(latLng);
  }

  void getCurrentLocation() async {
    Position? currentPosition;
    try {
      currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
    } catch (e) {
      print("Lỗi khi lấy vị trí: $e");
    }
    if (currentPosition != null && _isMounted) {
      setState(() {
        position = currentPosition;
        _latLng = LatLng(position!.latitude, position!.longitude);
      });
      updateMarker(_latLng);
    }
  }

  void startListeningToLocationUpdates() {
    _positionStreamSubscription =
        Geolocator.getPositionStream().listen((event) {
      if (_isMounted) {
        if (event == true) {
          setState(() {
            position = event;
            _latLng = LatLng(position!.latitude, position!.longitude);
            updateMarker(_latLng);
          });
        }
      }
    });
  }

  void searchAndMoveCamera(String searchText) async {
    try {
      LatLng newPosition = await service.searchPlaces(searchText);
      setState(() {
        _latLng = newPosition;
      });
      _updateCameraPosition(_latLng);
    } catch (e) {
      // Xử lý lỗi ở đây
      print('Error: $e');
    }
  }

  void stopListeningToLocationUpdates() {
    _positionStreamSubscription?.cancel();
    print("Stop Listening to Location");
  }

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    requestLocationPermission();
    setSourceAndDestinationIcons();
    Timer(
      const Duration(seconds: 5),
      () => piUpLocationBottomSheet(context),
    );
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
    // Cancel sự kiện async trong dispose
    _positionStreamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      body: Stack(
        children: [
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
          if (position != null)
            Positioned(
              top: 50,
              left: 10,
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                elevation: 0,
                heroTag: null, // Set the heroTag property to null
                mini: true, // Set the mini property to true
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back_sharp,
                  color: FrontendConfigs.kIconColor,
                ),
              ),
            ),
          Positioned(
            bottom: 270,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: FrontendConfigs.kPrimaryColor,
              mini: true,
              onPressed: () {
                getCurrentLocation();
                startListeningToLocationUpdates();
                _updateCameraPosition(LatLng(
                  position!.latitude,
                  position!.longitude,
                ));
              },
              child: Icon(Icons.my_location),
            ),
          ),
          SlidingUpPanel(
            minHeight: 250,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            panel: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    alignment: Alignment.center,
                    height: 3,
                    width: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xffE0E0E0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                NetworkImage('https://example.com/avatar.jpg'),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.vehicle?.manufacturer ?? '',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                widget.vehicle?.licensePlate ?? '',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  HomeField(
                    svg: 'assets/svg/pickup_icon.svg',
                    hint: 'Enter your pickup location',
                    controller: _pickUpController,
                    inputType: TextInputType.text,
                  ),
                  const SizedBox(height: 18),
                  // HomeField(
                  //   svg: 'assets/svg/location_icon.svg',
                  //   hint: 'Where you want to go?',
                  //   controller: _dropLocationController,
                  //   inputType: TextInputType.text,
                  // ),
                  AppButton(
                      onPressed: () {
                        // _handlePressButton();
                        stopListeningToLocationUpdates();
                        searchAndMoveCamera(_pickUpController.text);
                      },
                      btnLabel: "Confirm Location"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Future<void> _handlePressButton() async {
  //   stopListeningToLocationUpdates();
  //   Prediction? p = await PlacesAutocomplete.show(
  //       context: context,
  //       apiKey: _kGoogleApiKey,
  //       onError: onError,
  //       mode: _mode,
  //       language: 'en',
  //       strictbounds: false,
  //       types: [""],
  //       decoration: InputDecoration(
  //         hintText: "Location",
  //         focusedBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(20),
  //             borderSide: BorderSide(color: Colors.white)),
  //       ),
  //       components: [Component(Component.country, "vn")]);
  //   if (p != null) {
  //     displayPrediction(p, homeScaffoldKey.currentState);
  //   }
  // }

  // void onError(PlacesAutocompleteResponse response) {
  //   homeScaffoldKey.currentState!
  //       .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  // }

  // Future<void> displayPrediction(
  //     Prediction p, ScaffoldMessengerState? currentState) async {
  //   GoogleMapsPlaces places = GoogleMapsPlaces(
  //       apiKey: _kGoogleApiKey,
  //       apiHeaders: await const GoogleApiHeaders().getHeaders());

  //   PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

  //    setState(() {
  //      _latLng = LatLng(
  //           detail.result.geometry!.location.lat,
  //           detail.result.geometry!.location.lng,
  //         );
  //    });

  //   updateMarker(_latLng);
  //   _updateCameraPosition(_latLng);

  //   // markers.clear();
  //   // markers.add(Marker(markerId: const MarkerId("0"),position: LatLng(lat,lng),icon: destinationIcon!));
  //   // setState(() {
  //   //   if (_isMounted) {
  //   //     controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  //   //   }
  //   // });
  // }
}
