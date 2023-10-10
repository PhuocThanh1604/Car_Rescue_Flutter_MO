import 'package:CarRescue/src/presentation/elements/custom_text.dart';
import 'package:flutter/material.dart';

class BookingDetailsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Header
          Center(
            child: CustomText(
              text: "Mã đơn hàng: 3457622",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(thickness: 3),
          SizedBox(height: 24.0), // Increased spacing

          // Booking Information

          _buildSectionTitle("Thông tin đơn hàng"),
          _buildInfoRow("Điểm đi", "Nhà Văn hóa Sinh viên ĐHQG TP.HCM"),
          _buildInfoRow("Điểm đến", "FPT University"),
          _buildInfoRow("Loại dịch vụ", "Kéo xe"),
          _buildInfoRow("Ghi chú", "Ghi chú khách hàng"),
          Divider(thickness: 3),
          SizedBox(height: 15.0),

          // Image
          _buildSectionTitle("Hình ảnh"),
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/towtruck.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12.0), // Rounded corners
            ),
          ),
          SizedBox(height: 24.0),
          Divider(thickness: 3),
          // Additional Details
          _buildSectionTitle("Thanh toán"),
          _buildInfoRow("Số lượng", "2"),
          _buildInfoRow("Tổng cộng", "\$200.00"),
          Divider(thickness: 3),
          SizedBox(height: 8.0),

          // Notes
          _buildSectionTitle("Ghi chú của kĩ thuật viên"),
          _buildInfoRow("Ghi chú", "Ghi chú."),
          _buildInfoRow("Lí do huỷ đơn", "Không huỷ"),
          Divider(thickness: 3),
          SizedBox(height: 8.0),

          // Timing
          _buildSectionTitle("Timing"),
          _buildInfoRow("Start Time", "01/10/2023 | 10:00 AM"),
          _buildInfoRow("End Time", "01/10/2023 | 12:00 PM"),
          _buildInfoRow("Created At", "01/01/2023 | 09:00 AM"),
          SizedBox(height: 24.0),

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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue, // Custom section title color
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
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
          Flexible(
            child: Text(
              value,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right, // Align text to the right
            ),
          ),
        ],
      ),
    );
  }
}
