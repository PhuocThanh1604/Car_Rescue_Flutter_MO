import 'package:CarRescue/src/models/customer.dart';
import 'package:CarRescue/src/presentation/elements/booking_status.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';
import 'package:CarRescue/src/utils/api.dart';
import 'package:flutter/material.dart';
import '../widgets/customer_info.dart';
import '../../../../../models/booking.dart';
import 'package:intl/intl.dart';

class BookingDetailsBody extends StatefulWidget {
  final Booking booking;
  final Map<String, String> addressesDepart;
  final Map<String, String> subAddressesDepart;
  final Map<String, String> addressesDesti;
  final Map<String, String> subAddressesDesti;
  BookingDetailsBody(this.booking, this.addressesDepart,
      this.subAddressesDepart, this.addressesDesti, this.subAddressesDesti);

  @override
  State<BookingDetailsBody> createState() => _BookingDetailsBodyState();
}

class _BookingDetailsBodyState extends State<BookingDetailsBody> {
  AuthService authService = AuthService();
  CustomerInfo? customerInfo;
  @override
  void initState() {
    super.initState();
    _loadCustomerInfo(widget.booking.customerId);
  }

  Future<void> _loadCustomerInfo(String customerId) async {
    Map<String, dynamic>? userProfile =
        await authService.fetchCustomerInfo(customerId);
    print('day la ${userProfile}');
    if (userProfile != null) {
      setState(() {
        customerInfo = CustomerInfo.fromJson(userProfile);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Image URLs (replace with your actual image URLs)
    List<String> imageUrls = [
      "assets/images/towtruck.png",
      "assets/images/tyres.png",
      "assets/images/engine.jpg",
    ];
    // Define a function to display the tapped image in a dialog
    void _showImageDialog(BuildContext context, String imageUrl) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: 400, // Set the width of the dialog as needed
              height: 400, // Set the height of the dialog as needed
              child: Image.asset(
                imageUrl, // Display the tapped image
                fit: BoxFit.contain, // Fit the image to the dialog
              ),
            ),
          );
        },
      );
    }

// ...

    Widget _buildImageSection(List<String> imageUrls) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Hình ảnh"),
          Container(
            height: 200.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      right: 16.0), // Add spacing between images
                  child: InkWell(
                    onTap: () {
                      // Show the image in a dialog when tapped
                      _showImageDialog(context, imageUrls[index]);
                    },
                    child: Container(
                      width: 200.0, // Adjust the width as needed
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imageUrls[index]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            BorderRadius.circular(12.0), // Rounded corners
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Header
          Center(
            child: CustomText(
              text: "Mã đơn hàng: ${widget.booking.id}",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(thickness: 3),
          // Increased spacing

          // Booking Information

          _buildSectionTitle("Thông tin khách hàng"),
          CustomerInfoRow(
            name: customerInfo?.fullname ?? '',
            phone: customerInfo?.phone ?? '',
          ),
          Divider(thickness: 3),
          _buildSectionTitle("Thông tin đơn hàng"),
          _buildInfoRow(
              "Trạng thái",
              BookingStatus(
                status: widget.booking.status,
              )),
          _buildInfoRow(
              "Điểm đi",
              Text(' ${widget.addressesDepart[widget.booking.id]}',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          _buildInfoRow(
              "Điểm đến",
              Text('${widget.addressesDesti[widget.booking.id]}',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          _buildInfoRow(
              "Loại dịch vụ",
              Text(widget.booking.rescueType,
                  style: TextStyle(fontWeight: FontWeight.bold))),
          _buildInfoRow(
              "Ghi chú",
              Text(widget.booking.customerNote,
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Divider(thickness: 3),
          SizedBox(height: 15.0),

          // Image

          _buildImageSection(imageUrls),

          // Additional Details
          // You can replace this with the actual payment details

          // Notes
          _buildSectionTitle("Ghi chú của kĩ thuật viên"),
          _buildInfoRow(
              "Ghi chú",
              Text(widget.booking.staffNote ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          // _buildInfoRow("Lí do huỷ đơn", booking.cancellationReason),
          Divider(thickness: 3),
          SizedBox(height: 8.0),

          // Timing
          _buildSectionTitle("Thời gian"),
          _buildInfoRow(
            "Bắt đầu",
            Text(
              DateFormat('yyyy-MM-dd HH:mm:ss')
                  .format(widget.booking.startTime ?? DateTime.now()),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          _buildInfoRow(
            "Kết thúc ",
            Text(
              DateFormat('yyyy-MM-dd HH:mm:ss')
                  .format(widget.booking.endTime ?? DateTime.now()),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          _buildInfoRow(
            "Được tạo lúc",
            Text(
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(height: 24.0),
          Divider(thickness: 3),
          SizedBox(height: 8.0),
          _buildSectionTitle("Thanh toán"),
          _buildInfoRow("Số lượng",
              Text('2', style: TextStyle(fontWeight: FontWeight.bold))),
          _buildInfoRow("Tổng cộng",
              Text('2', style: TextStyle(fontWeight: FontWeight.bold))),
          SizedBox(height: 24.0),
          Divider(thickness: 3),
          // Conditionally display the order item section
          _buildOrderItemSection(),
          // Action Buttons
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 24.0),
                ElevatedButton(
                  onPressed: () {
                    // Implement Cancel action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(
                        110, 126, 126, 126), // Use red color for Cancel button
                    textStyle: TextStyle(fontSize: 18.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    child: CustomText(
                      text: "Hỗ trợ",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0), // Additional spacing at the bottom
        ],
      ),
    );
  }

  Widget buildBookingStatus(String status) {
    return BookingStatus(status: status);
  }

  Widget _buildOrderItemSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Đơn giá"), // Customize the section title
        // Add order item details here
        _buildInfoRow(
            "Sửa bánh xe",
            Text(
              "\$200.00",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        _buildInfoRow("Bơm bánh xe",
            Text("\$5", style: TextStyle(fontWeight: FontWeight.bold))),
        // Add more order item details as needed
        Divider(thickness: 3),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Center(
          child: CustomText(
            text: title,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ));
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
}
