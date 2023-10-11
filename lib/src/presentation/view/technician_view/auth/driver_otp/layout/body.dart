import 'package:flutter/material.dart';
import 'package:CarRescue/src/presentation/elements/app_button.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';

import 'package:pinput/pinput.dart';

import '../../../../../../configuration/frontend_configs.dart';
import '../../account_created/account_created_view.dart';

class DriverOTPBody extends StatelessWidget {
  DriverOTPBody({Key? key}) : super(key: key);
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 77,
      height: 56,
      textStyle: TextStyle(
          fontSize: 16,
          color: FrontendConfigs.kPrimaryColor,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: FrontendConfigs.kAuthColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.black, width: 0.1),
      ),
    );

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              const SizedBox(
                height: 34,
              ),
              Image.asset(
                "assets/images/logocarescue.png",
                height: 90,
                width: 180,
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 34,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    text:
                        'Hãy nhập mã xác nhận được gửi đến số \n+84 3********42  ',
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Pinput(
                  controller: pinController,
                  focusNode: focusNode,
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsUserConsentApi,
                  listenForMultipleSmsOnAndroid: true,
                  defaultPinTheme: defaultPinTheme,
                  validator: (value) {
                    return value == '2222' ? null : '';
                  },
                  onClipboardFound: (value) {
                    debugPrint('onClipboardFound: $value');
                    pinController.setText(value);
                  },
                  // hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (pin) {
                    debugPrint('onCompleted: $pin');
                  },
                  onChanged: (value) {
                    debugPrint('onChanged: $value');
                  },
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        width: 22,
                        height: 1,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: FrontendConfigs.kAuthColor,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.black, width: 0.1),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color: FrontendConfigs.kAuthColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 34,
              ),
              RichText(
                  text: TextSpan(
                      text: "Nhấn vào đây",
                      style: TextStyle(
                          color: FrontendConfigs.kPrimaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          decoration: TextDecoration.underline),
                      children: [
                    TextSpan(
                        text: " để gửi lại mã xác nhận trong 60s",
                        style: TextStyle(
                            color: FrontendConfigs.kPrimaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            decoration: TextDecoration.none))
                  ])),
              const SizedBox(
                height: 44,
              ),
              AppButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AccountCreatedView()));
                  },
                  btnLabel: 'Xác nhận')
            ],
          ),
        ),
      ),
    );
  }
}
