<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';

import '../../../../../configuration/frontend_configs.dart';
import 'row_widget.dart';

class ProfileBody extends StatefulWidget {
=======
import 'package:CarRescue/src/models/customer.dart';
import 'package:CarRescue/src/presentation/view/customer_view/profile/edit_profile/edit_profile_view.dart';
import 'package:CarRescue/src/presentation/view/select_city/select_city_view.dart';
import 'package:CarRescue/src/providers/customer_profile_provider.dart';

import 'package:CarRescue/src/providers/gmail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';
import 'package:get_storage/get_storage.dart';

import 'row_widget.dart';

class ProfileBody extends StatefulWidget {
  
>>>>>>> origin/MinhAndHieu6
  ProfileBody({Key? key}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final Color redColor = const Color(0xffFF455B);

<<<<<<< HEAD
=======
  GmailProvider gmailProvider = GmailProvider();

>>>>>>> origin/MinhAndHieu6
  bool isFirstSelected = false;

  bool isSecondSelected = false;

  bool isThirdSelected = false;

<<<<<<< HEAD
=======
  Customer customer = Customer.fromJson(GetStorage().read('customer') ?? {});

  String avt = '';

  String fullname = '';
  
  String phone = '';

  void _handleSignOut() async {
    gmailProvider.handleSignOut();
    if (customer.id != '') {
      GetStorage().remove("customer");
    }
    Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => SelectCityView(),
            ),
            (route) => false, // Loại bỏ tất cả các màn hình khỏi ngăn xếp
          );
   
  }

  void _fetchCustomer(String id)async{
    try{
    final fetchData = await CustomerProfileProvider().getCustomerById(id);
    setState(() {
      avt = fetchData.avatar;
      fullname = fetchData.fullname;
      phone = fetchData.phone;
    });
    }catch(e){
      print("Lỗi: ${e}}");
    }
  }



  @override
  void dispose() {
    super.dispose();
  }
  @override
  void initState() {
    _fetchCustomer(customer.id);
    print("Id: ${customer.id}");
    print("AccId: ${customer.accountId}");
    // _handleUpdateProfile();
    super.initState();
  }

>>>>>>> origin/MinhAndHieu6
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
                      child: Padding(
<<<<<<< HEAD
                        padding: const EdgeInsets.all(0.20),
                        child: Image.asset(
                          "assets/images/profile.png",
                          fit: BoxFit.cover,
                        ),
                      ),
=======
                          padding: const EdgeInsets.all(0.20),
                          child: CircleAvatar(
                              radius: 60,
                              backgroundImage: avt != ''
                                  ? Image.network(avt).image
                                       // Sử dụng NetworkImage cho hình ảnh từ mạng
                                  : AssetImage(
                                      'assets/images/profile.png'), // Sử dụng AssetImage cho hình ảnh từ tài nguyên cục bộ
                            ),),
>>>>>>> origin/MinhAndHieu6
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    CustomText(
<<<<<<< HEAD
                      text: "Andrew Johns",
=======
                      text: fullname,
>>>>>>> origin/MinhAndHieu6
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    CustomText(
<<<<<<< HEAD
                      text: '+1 343-234-4544',
=======
                      text: phone,
>>>>>>> origin/MinhAndHieu6
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
              name: 'Edit profile',
<<<<<<< HEAD
              onTap: () {},
=======
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => EditProfileViewCustomer(id: customer.id, accountId: customer.accountId,)),
                );
                // Navigator.pushNamed(context, "/editProfile");
              },
>>>>>>> origin/MinhAndHieu6
            ),
            const SizedBox(
              height: 24,
            ),
            SettingWidget(
              icon: "assets/svg/notification_icon.svg",
              title: "+966 1114141",
              name: 'Notification',
              onTap: () {},
            ),
            const SizedBox(
              height: 24,
            ),
            SettingWidget(
              icon: "assets/svg/wallet_icon.svg",
              title: "Payment",
              name: 'Payment',
              height: 16,
              weight: 16,
              onTap: () {},
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SettingWidget(
                    icon: "assets/svg/language.svg",
                    title: "",
                    name: 'Language',
                    isShow: true,
                    onTap: () {},
                  ),
                  Row(
                    children: const [
                      Text("English (US)",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                      SizedBox(
                        width: 3,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            SettingWidget(
              icon: "assets/svg/privacy.svg",
              title: "John_wick",
              name: 'Privacy Policy',
              onTap: () {},
            ),
            const SizedBox(
              height: 24,
            ),
            SettingWidget(
              icon: "assets/svg/help_center.svg",
              title: "",
              name: 'Help Center',
              onTap: () {},
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
<<<<<<< HEAD
              onTap: () {},
=======
              onTap: () {
                _handleSignOut();
              },
>>>>>>> origin/MinhAndHieu6
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
                    "Log out",
                    style: TextStyle(
                        color: redColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
