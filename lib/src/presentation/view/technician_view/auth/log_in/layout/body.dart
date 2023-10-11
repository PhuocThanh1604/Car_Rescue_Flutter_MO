import 'package:flutter/material.dart';
import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/presentation/elements/app_button.dart';
import 'package:CarRescue/src/presentation/elements/auth_field.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';
import 'package:CarRescue/src/presentation/view/technician_view/bottom_nav_bar/bottom_nav_bar_view.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class TechnicianLogInBody extends StatefulWidget {
  TechnicianLogInBody({Key? key}) : super(key: key);

  @override
  _TechnicianLogInBodyState createState() => _TechnicianLogInBodyState();
}

class _TechnicianLogInBodyState extends State<TechnicianLogInBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = ''; // To store the error message

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://rescuecapstoneapi.azurewebsites.net/api/Login/Login'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        setState(() {
          errorMessage = 'Login failed. Please check your credentials.';
        });
        return false;
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        errorMessage = 'An error occurred during login.';
      });
      return false;
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
                keyBoardType: TextInputType.emailAddress,
              ),
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
                  login(_emailController.text.toString(),
                          _passwordController.text.toString())
                      .then((loginSuccessful) {
                    if (loginSuccessful) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomNavBarView(),
                        ),
                      );
                    } else {
                      // Handle login failure or show an error message
                    }
                  }).catchError((error) {
                    // Handle login errors here
                  });
                },
                btnLabel: "Log in",
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
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: FrontendConfigs.kIconColor,
                    ),
                  ),
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
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
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
                          'Sign in with Google',
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
            ],
          ),
        ),
      ),
    );
  }
}
