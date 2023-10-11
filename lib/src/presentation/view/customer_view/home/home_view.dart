import 'dart:async';
import 'dart:ui' as ui;
import 'package:CarRescue/src/enviroment/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_place/google_place.dart';
import 'package:geolocator/geolocator.dart';
import 'package:CarRescue/src/presentation/elements/app_button.dart';
import 'package:CarRescue/src/providers/google_map_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'layout/bottom_sheets/pick_up_sheet.dart';
import 'layout/widget/home_field.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart' as place;

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => HomeViewState();
}

final GlobalKey<ScaffoldMessengerState> homeScaffoldKey =
    GlobalKey<ScaffoldMessengerState>();

class HomeViewState extends State<HomeView> {
  final TextEditingController _pickUpController = TextEditingController();
  // final TextEditingController _dropLocationController = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController controller;
  LocationProvider service = LocationProvider();
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

  List<Prediction> predictions = [];
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
    // Timer(
    //   const Duration(seconds: 5),
    //   () => piUpLocationBottomSheet(context),
    // );
  }

  @override
  void dispose() {
    _isMounted = false;
    _pickUpController.dispose();
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
              bottom: 250,
              right: 16,
              child: FloatingActionButton(
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
            minHeight: 200,
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
                  const SizedBox(height: 18),
                  HomeField(
                    svg: 'assets/svg/pickup_icon.svg',
                    hint: 'Enter your pickup location',
                    controller: _pickUpController,
                    inputType: TextInputType.text,
                    onTextChanged: onSearchTextChanged,
                   ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: predictions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(predictions[index].description!),
                          onTap: () {
                            // Xử lý khi người dùng chọn một dự đoán
                            print(predictions[index].description);
                            // Có thể thực hiện thêm các thao tác sau khi chọn dự đoán
                            searchAndMoveCamera(predictions[index].description!);
                          },
                        );
                      },
                    ),
                  ),
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

  void onSearchTextChanged(String query) async {
    try {
      final response = await service.getPlacePredictions(query);
      setState(() {
        predictions = response.predictions;
      });
      print(predictions[0].description);
    } catch (e) {
      print('Error: $e');
    }
  }

  // Future<void> _handlePressButton() async {
  //   stopListeningToLocationUpdates();
  //   Prediction? p = await PlacesAutocomplete.show(
  //       context: context,
  //       apiKey: _kGoogleApiKey,
  //       onError: onError,
  //       mode: _mode,
  //       language: 'vn',
  //       strictbounds: false,
  //       types: [""],
  //       decoration: InputDecoration(
  //         hintText: "Location",
  //         focusedBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(20),
  //             borderSide: BorderSide(color: Colors.white)),
  //       ),
  //       components: [place.Component(place.Component.country, "vn")]);
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

  //   markers.clear();
  //   markers.add(Marker(markerId: const MarkerId("0"),position: LatLng(lat,lng),icon: destinationIcon!));
  //   setState(() {
  //     if (_isMounted) {
  //       controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  //     }
  //   });
    }
