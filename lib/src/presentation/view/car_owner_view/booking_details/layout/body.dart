import 'dart:async';
import 'dart:io';

import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/models/booking.dart';
import 'package:CarRescue/src/models/customerInfo.dart';
import 'package:CarRescue/src/models/vehicle_item.dart';
import 'package:CarRescue/src/presentation/elements/booking_status.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';
import 'package:CarRescue/src/presentation/elements/loading_state.dart';
import 'package:CarRescue/src/presentation/elements/slide_confirm_button.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/booking_details/widgets/vehicle_info.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/completed_booking/completed_booking_view.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/homepage/homepage_view.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/wallet/wallet_view.dart';
import 'package:CarRescue/src/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/customer_info.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:slider_button/slider_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class BookingDetailsBody extends StatefulWidget {
  final String userId;
  final String accountId;
  final Booking booking;
  final Map<String, String> addressesDepart;
  final Map<String, String> subAddressesDepart;
  final Map<String, String> addressesDesti;
  final Map<String, String> subAddressesDesti;
  final Function? updateTabCallback;
  final Function? reloadData;
  BookingDetailsBody(
    this.userId,
    this.accountId,
    this.booking,
    this.addressesDepart,
    this.subAddressesDepart,
    this.addressesDesti,
    this.subAddressesDesti,
    this.updateTabCallback,
    this.reloadData,
  );

  @override
  State<BookingDetailsBody> createState() => _BookingDetailsBodyState();
}

class _BookingDetailsBodyState extends State<BookingDetailsBody> {
  bool _isLoading = true;
  AuthService authService = AuthService();
  CustomerInfo? customerInfo;
  Vehicle? vehicleInfo;
  int desiredTabIndex = 0;
  List<String> _imageUrls = [];
  List<String> pickedImages = [];
  Booking? _currentBooking;
  @override
  void initState() {
    super.initState();
    _currentBooking = widget.booking;
    _loadCustomerInfo(widget.booking.customerId);
    _loadVehicleInfo(widget.booking.vehicleId ?? '');
    _loadImageUrls();
  }

  Future<void> _loadImageUrls() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      final urls = await authService.fetchImageUrls(widget.booking.id);

      if (urls.isNotEmpty) {
        // If URLs are not empty, update the state with these URLs.
        setState(() {
          _imageUrls = urls;
        });
      } else {
        // If URLs are empty, you might want to update the state accordingly or show a message.
        print('No image URLs found');
      }
    } catch (e) {
      // Handle exception by showing an error or a message to the user.
      print('Failed to fetch image URLs: $e');
      // You might want to set _imageUrls to an empty list or handle the error state.
    } finally {
      // Stop loading whether the fetch was successful or not.
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadCustomerInfo(String customerId) async {
    Map<String, dynamic>? userProfile =
        await authService.fetchCustomerInfo(customerId);
    print(userProfile);
    if (userProfile != null) {
      setState(() {
        customerInfo = CustomerInfo.fromJson(userProfile);
      });
    }
    _updateLoadingStatus();
  }

  Future<void> _loadVehicleInfo(String vehicleId) async {
    try {
      Vehicle? fetchedVehicleInfo =
          await authService.fetchVehicleInfo(vehicleId);
      print('Fetched vehicle: $fetchedVehicleInfo');

      setState(() {
        vehicleInfo = fetchedVehicleInfo;
      });
    } catch (e) {
      print('Error loading vehicle info: $e');
    }
    _updateLoadingStatus();
  }

  void _updateLoadingStatus() {
    if (customerInfo != null && vehicleInfo != null) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Add the file path to your imageUrls list
      setState(() {
        _imageUrls.add(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  void _openImageDialog(
      BuildContext context, int index, List<String> allImages) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: PhotoViewGallery.builder(
          itemCount: allImages.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: allImages[index].startsWith('http')
                  ? NetworkImage(allImages[index]) as ImageProvider<Object>
                  : allImages[index].startsWith('assets/')
                      ? AssetImage(allImages[index]) as ImageProvider<Object>
                      : FileImage(File(allImages[index]))
                          as ImageProvider<Object>,
              minScale: PhotoViewComputedScale.contained * 0.1,
              maxScale: PhotoViewComputedScale.covered * 2,
            );
          },
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: BoxDecoration(
            color: const Color.fromARGB(0, 0, 0, 0),
          ),
          pageController: PageController(initialPage: index),
          onPageChanged: (int index) {
            // You can track page changes if you need to.
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Image URLs (replace with your actual image URLs)

    if (_isLoading) {
      return LoadingState();
    }
    if (_isLoading)
      Opacity(
        opacity: 0.3,
        child: ModalBarrier(dismissible: false),
      );
    // Define a function to display the tapped image in a dialog

// ...
    Future<void> _refreshData() async {
      // reloadBookingsData();
    }

    return Scaffold(
      backgroundColor: FrontendConfigs.kBackgrColor,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Header
              Center(
                child: Column(
                  children: [
                    CustomText(
                      text: "Mã đơn hàng",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: " ${widget.booking.id}",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: CustomerInfoRow(
                    name: customerInfo?.fullname ?? '',
                    phone: customerInfo?.phone ?? 'Chưa thêm số điện thoại',
                    avatar: customerInfo?.avatar ?? '',
                  ),
                ),
              ),
              Divider(thickness: 1),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: VehicleInfoRow(
                    manufacturer: vehicleInfo?.manufacturer ?? '',
                    type: vehicleInfo?.type ?? '',
                    licensePlate: vehicleInfo?.licensePlate ?? '',
                    image: vehicleInfo?.image ?? '',
                  ),
                ),
              ),
              Divider(thickness: 1),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildInfoRow(
                          "Trạng thái",
                          BookingStatus(
                            status: _currentBooking?.status ?? '',
                          )),
                      _buildInfoRow(
                          "Điểm đi",
                          Text(' ${widget.addressesDepart[widget.booking.id]}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15))),
                      _buildInfoRow(
                          "Điểm đến",
                          Text('${widget.addressesDesti[widget.booking.id]}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15))),
                      _buildInfoRow(
                          "Loại dịch vụ",
                          Text(widget.booking.rescueType,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15))),
                      _buildInfoRow(
                          "Ghi chú",
                          Text(widget.booking.customerNote,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15))),
                      if (widget.booking.status.toUpperCase() == 'CANCELLED')
                        _buildInfoRow(
                            "Lí do hủy đơn",
                            Text(
                                widget.booking.cancellationReason ??
                                    'Không Cung Cấp Lí Do',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15))),
                      if (widget.booking.status.toUpperCase() == 'COMPLETED')
                        _buildInfoRow(
                          'Đánh giá',
                          Container(
                            child: RatingBar.builder(
                              itemSize: 19,
                              initialRating: widget.booking.rating!,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                size: 10,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ),
                        ),
                      if (widget.booking.status.toUpperCase() == 'COMPLETED')
                        _buildInfoRow(
                            'Nội dung ',
                            Text(
                              widget.booking.note ?? 'Không có nội dung',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15.0),

              // Image
              if (_imageUrls.isNotEmpty)
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildImageSection(_imageUrls),
                        SizedBox(height: 15.0),
                        Divider(thickness: 1),
                      ],
                      // _buildInfoRow(
                      //     "Ghi chú NV",
                      //     Text(widget.booking.staffNote ?? '',
                      //         style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                  ),
                ),
              // _buildInfoRow("Lí do huỷ đơn", booking.cancellationReason),

              SizedBox(height: 8.0),

              // Timing
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildOrderItemSection(),
                      _buildInfoRow(
                          "Số lượng",
                          Text('2',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      _buildInfoRow(
                          "Tổng cộng",
                          Text('2',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        "Bắt đầu",
                        Text(
                          DateFormat('yyyy-MM-dd HH:mm:ss').format(
                              widget.booking.startTime ?? DateTime.now()),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      _buildInfoRow(
                        "Kết thúc ",
                        Text(
                          DateFormat('yyyy-MM-dd HH:mm:ss').format(
                              _currentBooking?.endTime ?? DateTime.now()),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      _buildInfoRow(
                        "Được tạo lúc",
                        Text(
                          DateFormat('yyyy-MM-dd HH:mm:ss').format(
                              widget.booking.createdAt ?? DateTime.now()),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (widget.booking.status == 'ASSIGNED')
                Container(
                  width: double.infinity,
                  child: SliderButton(
                    alignLabel: Alignment.center,
                    shimmer: true,
                    baseColor: Colors.white,
                    buttonSize: 45,
                    height: 60,
                    backgroundColor: FrontendConfigs.kActiveColor,
                    action: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      bool isSuccess =
                          await authService.startOrder(widget.booking.id);
                      if (isSuccess) {
                        setState(() {
                          _isLoading = false;
                        });
                        //
                        //Navigate back to the previous screen
                        widget.updateTabCallback!(2);
                        widget.reloadData;
                        Navigator.pop(context,
                            'reload'); // This pops the `BookingDetailsBody` screen.

                        // Set the specific tab you want to navigate to
                      }
                    },
                    label: const Text(
                      "Bắt đầu",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    icon: SvgPicture.asset("assets/svg/cancel_icon.svg"),
                  ),
                )
              else if (_currentBooking != null &&
                  _currentBooking?.status == 'INPROGRESS')
                Container(
                  width: double.infinity,
                  child: SliderButton(
                    alignLabel: Alignment.center,
                    shimmer: true,
                    baseColor: Colors.white,
                    buttonSize: 45,
                    height: 60,
                    backgroundColor: FrontendConfigs.kActiveColor,
                    action: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      bool isSuccess =
                          await authService.endOrder(widget.booking.id);
                      if (isSuccess) {
                        // Fetch the updated data and wait for it to complete
                        Booking updatedBooking = await authService
                            .fetchCarOwnerBookingById(widget.booking.id);

                        // Update the local state with the fetched booking details
                        setState(() {
                          _currentBooking = updatedBooking;
                          _isLoading = false;
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingCompletedScreen(
                              widget.userId,
                              widget.accountId,
                              _currentBooking!,
                              widget.addressesDepart,
                              widget.subAddressesDepart,
                              widget.addressesDesti,
                              widget.subAddressesDesti,
                            ),
                          ),
                        );
                      } else {
                        setState(() {
                          _isLoading = false;
                        });
                        // Handle error if the endOrder API call was not successful
                      }
                    },
                    label: const Text(
                      "Kết thúc",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    icon: SvgPicture.asset("assets/svg/cancel_icon.svg"),
                  ),
                )
              else if (widget.booking.status == 'ASSIGNING')
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green, // color for accept button
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          bool decision = true;
                          bool isSuccess = await authService.acceptOrder(
                              widget.booking.id, decision);

                          if (isSuccess) {
                            setState(() {
                              _isLoading = false;
                            });
                            widget.updateTabCallback!(1);
                            widget.reloadData;
                            Navigator.pop(context,
                                'reload'); // This pops the `BookingDetailsBody` screen.
                          }
                          // widget.updateTabCallback!(1);
                        },
                        child: Text(
                          "Đồng ý",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                        width:
                            2), // Optional: you can use this for a small gap between the buttons
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, // color for cancel button
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () async {
                          bool decision = false;
                          await authService.acceptOrder(
                              widget.booking.id, decision);
                        },
                        child: Text(
                          "Hủy",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 12.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildImageSection(List<String> imageUrls) {
    final allImages = [...imageUrls, ...pickedImages];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Hình ảnh"),
        Container(
          height: 200.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // fixed to 5 slots for images
            itemBuilder: (context, index) {
              // If there's an image at this index, show it
              if (index < allImages.length) {
                ImageProvider imageProvider;

                // Check if the image is an asset or a picked image

                if (allImages[index].startsWith('http')) {
                  imageProvider = NetworkImage(allImages[index]);
                } else if (allImages[index].startsWith('assets/')) {
                  imageProvider = AssetImage(allImages[index]);
                } else {
                  imageProvider = FileImage(File(allImages[index]));
                }

                // imageProvider = FileImage(File(allImages[index]));

                return Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: InkWell(
                    onTap: () {
                      _openImageDialog(context, index, allImages);
                    },
                    child: Container(
                      width: 200.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                );
              }

              // Otherwise, show an add button
              else if (widget.booking.status.toUpperCase() != 'COMPLETED' &&
                  widget.booking.status.toUpperCase() != 'INPROGRESS') {
                return Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: InkWell(
                    onTap: _addImage,
                    child: Container(
                      width: 200.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                        child: Icon(Icons.add,
                            size: 60.0, color: Colors.grey[400]),
                      ),
                    ),
                  ),
                );
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAddImageSection() {
    return Column(
      children: [
        _buildSectionTitle("Hình ảnh"),
        Center(
          child: Column(
            children: [
              Icon(Icons.camera_alt, size: 60.0, color: Colors.grey[400]),
              TextButton(
                onPressed: _addImage,
                child: Text("Add Image"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItemSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(
            "Sửa bánh xe",
            Text(
              "\$200.00",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        _buildInfoRow("Bơm bánh xe",
            Text("\$5", style: TextStyle(fontWeight: FontWeight.bold))),
        // Add more order item details as needed
        Divider(thickness: 1),
        SizedBox(
          height: 6,
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, Widget value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(width: 8.0), // Add spacing between label and value
          value
        ],
      ),
    );
  }

  Widget _buildCustomerInfoSection(CustomerInfo? customerInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.0),
        Row(
          children: [
            Icon(Icons.person, color: Colors.grey[600], size: 20.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                customerInfo?.fullname ?? '',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Icon(Icons.phone, color: Colors.grey[600], size: 20.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                customerInfo?.phone ?? 'Chưa thêm số điện thoại',
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Icon(Icons.image,
                color: Colors.grey[600],
                size: 20.0), // Assuming this is an avatar icon
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                customerInfo?.avatar ?? '',
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
      ],
    );
  }

  Widget _buildBookingInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.0),
        _buildInfoRow(
            "Trạng thái", BookingStatus(status: _currentBooking?.status ?? '')),
        _buildInfoRow(
            "Điểm đi", Text('${widget.addressesDepart[widget.booking.id]}')),
        _buildInfoRow(
            "Điểm đến", Text('${widget.addressesDesti[widget.booking.id]}')),
        _buildInfoRow("Loại xe", Text(vehicleInfo!.type)),
        _buildInfoRow("Biển số xe", Text(vehicleInfo!.licensePlate)),
        _buildInfoRow("Loại dịch vụ", Text(widget.booking.rescueType)),
        _buildInfoRow("Ghi chú", Text(widget.booking.customerNote)),
        SizedBox(height: 10.0),
      ],
    );
  }
}
