import 'package:CarRescue/src/presentation/elements/custom_dropdown.dart';
import 'package:CarRescue/src/presentation/view/technician_view/auth/number_verification/number_verification_view.dart';
import 'package:flutter/material.dart';

import '../../../../../../configuration/frontend_configs.dart';
import '../../../../../elements/app_button.dart';
import '../../../../../elements/auth_field.dart';

class SignUpBody extends StatefulWidget {
  SignUpBody({Key? key}) : super(key: key);

  @override
  _SignUpBodyState createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _sexController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? _selectedSex;

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
                "Create your \nAccount",
                style: FrontendConfigs.kHeadingStyle,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                isSecure: false,
                controller: _nameController,
                icon: "assets/svg/person_icon.svg",
                text: 'Full Name',
                onTap: () {},
                keyBoardType: TextInputType.text,
              ),
              const SizedBox(
                height: 18,
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
                height: 18,
              ),
              CustomDropdownField(
                text: 'Sex',
                options: ['Male', 'Female', 'Other'],
                selectedValue: _selectedSex,
                onChanged: (value) {
                  setState(() {
                    _selectedSex = value;
                  });
                },
              ),
              const SizedBox(
                height: 18,
              ),
              CustomTextField(
                controller: _addressController,
                icon: "assets/svg/home_icon.svg",
                text: 'Address',
                onTap: () {},
                keyBoardType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              AppButton(
                onPressed: () {
                  // final fullName = _nameController.text;
                  // final email = _emailController.text;
                  // final password = _passwordController.text;
                  // final sex = _selectedSex;
                  // final address = _addressController.text;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NumberVerificationView(),
                    ),
                  );
                },
                btnLabel: "Create Account",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
