import 'package:CarRescue/src/presentation/view/technician_view/auth/log_in/log_in_view.dart';
import 'package:CarRescue/src/presentation/view/technician_view/edit_profile/edit_profile_view.dart';
import 'package:CarRescue/src/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';
import 'row_widget.dart';
import '../../auth/log_in/layout/body.dart';

class ProfileBody extends StatefulWidget {
  ProfileBody({Key? key, required this.userId, required this.accountId})
      : super(key: key);
  final String userId;
  final String accountId;

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final Color redColor = const Color(0xffFF455B);
  bool isFirstSelected = false;

  bool isSecondSelected = false;

  bool isThirdSelected = false;
  String userName = '';
  String phoneNumber = '';
  String avatarTech = '';
  AuthService authService = AuthService();
  Map<String, dynamic>? userProfileData;
  @override
  void initState() {
    super.initState();
    // Call the function to fetch user data when the widget is initialized
    fetchUserProfileData();
  }

  // Function to fetch user profile data
  void fetchUserProfileData() async {
    try {
      final userProfile = await authService.fetchTechProfile(widget.userId);

      if (userProfile != null) {
        print('User Profile: $userProfile');
        // Extract the 'data' map from the response
        final Map<String, dynamic> data = userProfile['data'];

        // Extract 'fullname' and 'phone' values from the 'data' map
        final String fullName = data['fullname'];
        final String phone = data['phone'];

        // Update the state with the extracted values or 'N/A' if they are null
        setState(() {
          userName = fullName;
          phoneNumber = phone;
        });
      } else {
        // Handle the case where the userProfile is null
        // Set default values for userName and phoneNumber
        setState(() {
          userName = 'N/A';
          phoneNumber = 'N/A';
        });
      }
    } catch (e) {
      // Handle any exceptions that occur during the API request
      print('Error fetching user profile1: $e');
      // You can set an error message or handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 37,
                      backgroundImage: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/car-rescue-399511.appspot.com/o/images%2Favatars-2.png?alt=media&token=ebea458f-13c0-4c20-9d52-15eca7f652ac&_gl=1*1fo3xxj*_ga*NDA4Mjk5NjgwLjE2OTc4OTc1Nzc.*_ga_CW55HF8NVT*MTY5NzkxMDU5MC41LjEuMTY5NzkxMDYwMi40OC4wLjA.'), // Use 'backgroundImage' to set the image
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    CustomText(
                      text: userName,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    CustomText(
                      text: phoneNumber,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SettingWidget(
              icon: "assets/svg/user.svg",
              title: "John_wick",
              name: 'Chỉnh sửa thông tin',
              onTap: () async {
                // Navigate to EditProfileView
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileView(
                      userId: widget.userId,
                      accountId: widget.accountId,
                    ),
                  ),
                );

                // Check if the result indicates a successful update
                if (result == 'Profile updated successfully') {
                  // Fetch updated data here
                  fetchUserProfileData();
                }
              },
            ),
            const SizedBox(
              height: 24,
            ),
            SettingWidget(
              icon: "assets/svg/privacy.svg",
              title: "John_wick",
              name: 'Chính sách riêng tư',
              onTap: () {},
            ),
            const SizedBox(
              height: 24,
            ),
            SettingWidget(
              icon: "assets/svg/help_center.svg",
              title: "",
              name: 'Trung tâm hỗ trợ',
              onTap: () {},
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () async {
                // Perform logout actions (e.g., clear session, remove tokens, etc.)

                // Navigate to the login screen and replace the current screen
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TechnicianLogInView(),
                  ),
                );
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg/exit.svg",
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Text(
                    "Đăng xuất",
                    style: TextStyle(
                      color: redColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
