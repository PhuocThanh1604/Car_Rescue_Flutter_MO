<<<<<<< HEAD
=======
import 'package:CarRescue/src/providers/firebase_message_provider.dart';
import 'package:CarRescue/src/utils/api.dart';
>>>>>>> origin/MinhAndHieu6
import 'package:flutter/material.dart';
import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/presentation/elements/app_button.dart';
import 'package:CarRescue/src/presentation/elements/auth_field.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';
<<<<<<< HEAD
import 'package:CarRescue/src/presentation/view/car_owner_view/home/home_view.dart';
import 'package:CarRescue/src/presentation/view/customer_view/bottom_nav_bar/bottom_nav_bar_view.dart';

import 'log_in_widget.dart';

class DriverLogInBody extends StatelessWidget {
  DriverLogInBody({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
=======
import 'package:CarRescue/src/presentation/view/car_owner_view/bottom_nav_bar/bottom_nav_bar_view.dart';

class CarOwnerLogInBody extends StatefulWidget {
  CarOwnerLogInBody({
    Key? key,
  }) : super(key: key);

  @override
  State<CarOwnerLogInBody> createState() => _CarOwnerLogInBodyState();
}

class _CarOwnerLogInBodyState extends State<CarOwnerLogInBody> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  String? deviceToken;
  String errorMessage = '';
  void initState() {
    super.initState();
    FireBaseMessageProvider().getDeviceToken().then((token) {
      setState(() {
        deviceToken = token;
        print(deviceToken);
      });
    });
  }
>>>>>>> origin/MinhAndHieu6

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
<<<<<<< HEAD
                "Login to \nyour account",
=======
                "Đăng nhập \ntài khoản",
>>>>>>> origin/MinhAndHieu6
                style: FrontendConfigs.kHeadingStyle,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
<<<<<<< HEAD
                  isSecure: false,
                  controller: _emailController,
                  icon: "assets/svg/email_icon.svg",
                  text: 'Email',
                  onTap: () {},
                  keyBoardType: TextInputType.emailAddress),
=======
                isSecure: false,
                controller: _emailController,
                icon: "assets/svg/email_icon.svg",
                text: 'Email',
                onTap: () {},
                keyBoardType: TextInputType.emailAddress,
              ),
>>>>>>> origin/MinhAndHieu6
              const SizedBox(
                height: 18,
              ),
              CustomTextField(
                controller: _passwordController,
                icon: "assets/svg/lock_icon.svg",
<<<<<<< HEAD
                text: 'Password',
=======
                text: 'Mật khẩu',
>>>>>>> origin/MinhAndHieu6
                onTap: () {},
                keyBoardType: TextInputType.text,
                isPassword: true,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(
<<<<<<< HEAD
                    text: 'Forgot Password?',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
=======
                    text: 'Quên mật khẩu?',
                    fontSize: 16,
                    color: FrontendConfigs.kAuthColor,
>>>>>>> origin/MinhAndHieu6
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              AppButton(
<<<<<<< HEAD
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DriverHomeView()));
                  },
                  btnLabel: "Log in"),
              const SizedBox(
                height: 30,
=======
                onPressed: () async {
                  final result = await AuthService().loginCarOwner(
                      _emailController.text.toString(),
                      _passwordController.text.toString(),
                      deviceToken ?? '');

                  if (result != null) {
                    // Successfully logged in, navigate to the next screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavBarView(
                          accountId: result.accountId,
                          userId: result.userId,
                        ),
                      ),
                    );
                  } else {
                    // Handle login failure or show an error message
                    setState(() {
                      errorMessage =
                          'Login failed. Please check your credentials.';
                    });
                  }
                },
                btnLabel: "Đăng nhập",
              ),
              const SizedBox(
                height: 8, // Adjust the height as needed
              ),
              // Display the error message below the button
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              const SizedBox(
                height: 22,
>>>>>>> origin/MinhAndHieu6
              ),
              Row(
                children: [
                  Expanded(
<<<<<<< HEAD
                      child: Divider(
                    color: FrontendConfigs.kIconColor,
                  )),
=======
                    child: Divider(
                      color: FrontendConfigs.kIconColor,
                    ),
                  ),
>>>>>>> origin/MinhAndHieu6
                  const SizedBox(
                    width: 12,
                  ),
                  CustomText(
<<<<<<< HEAD
                    text: "Or continue with",
                    fontSize: 16,
=======
                    text: "Hoặc tiếp tục với",
                    fontSize: 16,
                    color: FrontendConfigs.kAuthColor,
>>>>>>> origin/MinhAndHieu6
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
<<<<<<< HEAD
                      child: Divider(
                    color: FrontendConfigs.kIconColor,
                  )),
=======
                    child: Divider(
                      color: FrontendConfigs.kIconColor,
                    ),
                  ),
>>>>>>> origin/MinhAndHieu6
                ],
              ),
              const SizedBox(
                height: 24,
              ),
<<<<<<< HEAD
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    LogInWidget(logo: "assets/images/facebook.png"),
                    LogInWidget(logo: "assets/images/google.png"),
                    LogInWidget(logo: "assets/images/iphone.png"),
                  ],
                ),
              )
=======
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Image(
                        image: AssetImage("assets/images/google.png"),
                        height: 18.0,
                        width: 36,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 24, right: 8),
                        child: Text(
                          'Đăng nhập với Google',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
>>>>>>> origin/MinhAndHieu6
            ],
          ),
        ),
      ),
    );
  }
}
