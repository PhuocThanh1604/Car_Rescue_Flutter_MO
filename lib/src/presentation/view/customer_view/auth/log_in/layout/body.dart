import 'package:flutter/material.dart';
import 'package:gillar/src/configuration/frontend_configs.dart';
import 'package:gillar/src/presentation/elements/app_button.dart';
import 'package:gillar/src/presentation/elements/auth_field.dart';
import 'package:gillar/src/presentation/elements/custom_text.dart';
import 'package:gillar/src/presentation/view/customer_view/bottom_nav_bar/bottom_nav_bar_view.dart';

import 'log_in_widget.dart';

class LogInBody extends StatelessWidget {
  LogInBody({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:18.0),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Text(
                "Login to \nyour account",
                style: FrontendConfigs.kHeadingStyle,
              ),
              const SizedBox(height:30,),
              CustomTextField(
                isSecure:false,
                  controller: _emailController,
                  icon: "assets/svg/email_icon.svg",
                  text: 'Email',
                  onTap: () {},
                  keyBoardType: TextInputType.emailAddress),
              const SizedBox(height:18,),
              CustomTextField(
                controller: _passwordController,
                icon: "assets/svg/lock_icon.svg",
                text: 'Password',
                onTap: () {},
                keyBoardType: TextInputType.text,
                isPassword: true,
              ),
              const SizedBox(height:12,),
              Row(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                  CustomText(
                    text: 'Forgot Password?',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )
                ],
              ),
              const SizedBox(height:24,),
              AppButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>const BottomNavBarView()));
              }, btnLabel:"Log in"),
              const SizedBox(height:30,),
              Row(children:  [
                Expanded(child: Divider(color:FrontendConfigs.kIconColor,)),
                const SizedBox(width:12,),
                CustomText(text: "Or continue with",fontSize:16,),
                const SizedBox(width:12,),
                Expanded(child: Divider(color:FrontendConfigs.kIconColor,)),
              ],),
              const SizedBox(height:24,),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: const [
                  LogInWidget(logo:"assets/images/facebook.png"),
                  LogInWidget(logo:"assets/images/google.png"),
                  LogInWidget(logo:"assets/images/iphone.png"),
                ],),
              )

            ],
          ),
        ),
      ),
    );
  }
}
