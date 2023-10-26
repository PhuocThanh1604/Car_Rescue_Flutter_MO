// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:ui' as ui;
import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/models/enum.dart';
import 'package:CarRescue/src/models/location_info.dart';
import 'package:CarRescue/src/presentation/elements/custom_appbar.dart';

import 'package:CarRescue/src/presentation/view/customer_view/order/layout/order_view.dart';
import 'package:CarRescue/src/providers/google_map_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:CarRescue/src/presentation/elements/app_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'layout/widget/home_field.dart';

// import 'package:google_api_headers/google_api_headers.dart';
// import 'package:google_maps_webservice/places.dart';

class HomeView extends StatefulWidget {
  final String services;

  HomeView({required this.services});

  @override
  State<HomeView> createState() => HomeViewState();
}

final GlobalKey<ScaffoldMessengerState> homeScaffoldKey =
    GlobalKey<ScaffoldMessengerState>();

class HomeViewState extends State<HomeView> {
  final TextEditingController _pickUpController = TextEditingController();
  final TextEditingController _dropLocationController = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer();
  ServiceType selectedService = ServiceType.repair;
  PanelController _pc = new PanelController();
  late GoogleMapController controller;
  LocationProvider service = LocationProvider();
  StreamSubscription<Position>? _positionStreamSubscription;
  late LatLng _latLng;
  Position? position;
  BitmapDescriptor? destinationIcon;
  bool _isMounted = false;
  late Future<List<LocationInfo>> predictions;

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
      if (currentPosition != null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition.latitude,
          currentPosition.longitude,
        );
        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks[0];
          String address =
              "${placemark.street}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}, ${placemark.country}";
          setState(() {
            _pickUpController.text = address;
          });
        } else {
          print("No placemark found.");
        }
      }
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
    predictions = Future.value([]);
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
    _dropLocationController.dispose();
    super.dispose();
    // Cancel sự kiện async trong dispose
    _positionStreamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        text: 'Map Location',
        showText: true,
      ),
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
          Positioned(
            top: 0, // Đặt ở phía trên cùng
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          if (position != null)
            Positioned(
              bottom: 300,
              right: 16,
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
            controller: _pc,
            minHeight: 200,
            maxHeight: 250,
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
                  // Hiển thị trường đầu vào dựa trên dịch vụ được chọn
                  HomeField(
                    onTap: () {
                      if (_pc.isPanelOpen) {
                        _pc.close(); // Đóng panel nếu đã mở
                      } else {
                        _pc.open(); // Mở panel nếu đã đóng
                      }
                    },
                    svg: 'assets/svg/pickup_icon.svg',
                    hint: 'Enter your pickup location',
                    controller: _pickUpController,
                    inputType: TextInputType.text,
                    onTextChanged: onSearchTextChanged,
                  ),
                  FutureBuilder<List<LocationInfo>>(
                    future: predictions, // query là tham số tìm kiếm
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Trạng thái đang tải dữ liệu
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        // Xử lý lỗi nếu có
                        return Text('Error: ${snapshot.error}');
                      } else {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          // Dữ liệu đã được tải thành công
                          final predictions = snapshot.data;

                          return Expanded(
                              child: Column(
                            children: [
                              if (predictions!.isNotEmpty)
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: predictions.length,
                                    itemBuilder: (context, index) {
                                      final prediction = predictions[index];
                                      return ListTile(
                                        title: Text(prediction.display),
                                        onTap: () {
                                          _pickUpController.text =
                                              prediction.display;
                                          getLatLng(prediction.display);
                                          // setState(() {
                                          //   _latLng = LatLng(
                                          //       prediction.latitude,
                                          //       prediction.longitude);
                                          // });
                                          clearPredictions();
                                        },
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ));
                        } else {
                          // Không có dữ liệu hoặc dữ liệu rỗng
                          return Text('');
                        }
                      }
                    },
                  ),
                  if (predictions == Future.value([]))
                    SizedBox(
                      height: 10,
                    ),
                  AppButton(
                    onPressed: () {
                      // _handlePressButton();
                      // stopListeningToLocationUpdates();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => OrderView(
                                  latLng: _latLng,
                                  address: _pickUpController.text,
                                  serviceType: widget.services,
                                )),
                      );
                    },
                    btnLabel: "Xác nhận địa điểm",
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> onSearchTextChanged(String query) async {
    try {
      final response = await service.getDisplayNamesByVietMap(query);
      setState(() {
        predictions =
            Future.value(response); // Gán danh sách LocationInfo vào Future
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void getLatLng(String query) async {
    final response = await service.searchPlaces(query);
    setState(() {
      _latLng = LatLng(response.latitude, response.longitude);
    });
    _updateCameraPosition(_latLng);
  }

  void clearPredictions() {
    setState(() {
      predictions = Future.value([]);
    });
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
