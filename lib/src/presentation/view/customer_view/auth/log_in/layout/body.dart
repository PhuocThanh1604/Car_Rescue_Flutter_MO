import 'package:CarRescue/src/models/customer.dart';
import 'package:get_storage/get_storage.dart';
import 'package:CarRescue/src/providers/gmail_provider.dart';
import 'package:CarRescue/src/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/presentation/elements/app_button.dart';
import 'package:CarRescue/src/presentation/elements/auth_field.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';
import 'package:CarRescue/src/presentation/view/customer_view/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'log_in_widget.dart';

class LogInBody extends StatefulWidget {
  LogInBody({Key? key}) : super(key: key);

  @override
  State<LogInBody> createState() => _LogInBodyState();
}

class _LogInBodyState extends State<LogInBody> {
  GmailProvider gmailProvider = GmailProvider();
  LoginProvider loginProvider = LoginProvider();
  final box = GetStorage();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: <String>[
  //     'email',
  //     'https://www.googleapis.com/auth/contacts.readonly',
  //   ],
  // );
  // Environment._googleSignIn;

  @override
  void initState() {
    // _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
    //   setState(() {
    //     _currentUser = account;
    //   });
    // } as void Function(GoogleSignInAccount? event)?);
    super.initState();
  }

  void _handleSignInWithGmail() async {
  String? token = await gmailProvider.handleSignIn();
  if (token != null) {
    final loginResponse = await loginProvider.loginWithGmail(token);
    Customer customer = loginResponse!.customer;
    if (loginResponse != null) {
      box.write("accessToken", loginResponse.accessToken);
      box.write("refreshToken", loginResponse.refreshToken);
      box.write("customer", customer.toJson());

      // Hiển thị thông báo thành công bằng fluttertoast
      Fluttertoast.showToast(
        msg: "Đăng nhập thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomNavBarView()));
    } else {
      // Xử lý trường hợp không đăng nhập thành công
      Fluttertoast.showToast(
        msg: "Đăng nhập không thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  } else {
    print("Không tìm thấy token");
  }
}

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
                "Login to \nyour account",
                style: FrontendConfigs.kHeadingStyle,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                  isSecure: false,
                  controller: _emailController,
                  icon: "assets/svg/email_icon.svg",
                  text: 'Email',
                  onTap: () {},
                  keyBoardType: TextInputType.emailAddress),
              const SizedBox(
                height: 18,
              ),
              CustomTextField(
                controller: _passwordController,
                icon: "assets/svg/lock_icon.svg",
                text: 'Password',
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
                    text: 'Forgot Password?',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              AppButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNavBarView()));
                  },
                  btnLabel: "Log in"),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: Divider(
                    color: FrontendConfigs.kIconColor,
                  )),
                  const SizedBox(
                    width: 12,
                  ),
                  CustomText(
                    text: "Or continue with",
                    fontSize: 16,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: Divider(
                    color: FrontendConfigs.kIconColor,
                  )),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    LogInWidget(
                      logo: "assets/images/google.png",
                      onPressed: () {
                        _handleSignInWithGmail();
                        // _handleSignOutWithGmail();
                      },
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
