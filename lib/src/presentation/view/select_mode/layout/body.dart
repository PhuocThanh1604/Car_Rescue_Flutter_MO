import 'package:flutter/material.dart';
import 'package:CarRescue/src/presentation/elements/app_button.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/auth/log_in/log_in_view.dart';
import 'package:CarRescue/src/presentation/view/customer_view/auth/log_in/log_in_view.dart';

class SelectModeBody extends StatelessWidget {
  const SelectModeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/selection_bg.png",
                    ),
                    fit: BoxFit.cover)),
            child: Container(
              // color: Colors.black.withOpacity(0.30),
              decoration: const BoxDecoration(),
            )),
        // Positioned.fill(
        //   child: ,
        // ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/app_logo.png",
                height: 100,
                width: 100,
              ),
              const SizedBox(
                height: 8,
              ),
              RichText(
                  text: const TextSpan(
                      text: "Welcome to",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 2,
                          fontSize: 16),
                      children: [
                    TextSpan(
                      text: " RAIDO.",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    )
                  ])),
              const SizedBox(
                height: 18,
              ),
              CustomText(
                text:
                    "The best taxi booking app of the century to make \nyour day great",
                color: Colors.white,
              ),
              const SizedBox(
                height: 12,
              ),
              AppButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PassengerLogInView()));
                },
                btnLabel: "I’m a Passenger",
              ),
              const SizedBox(
                height: 18,
              ),
              AppButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DriverLogInView()));
                },
                btnLabel: "I’am a Driver",
              )
            ],
          ),
        )
      ],
    );
  }
}
