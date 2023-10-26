<<<<<<< Updated upstream
=======
import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/auth/log_in/layout/body.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/auth/log_in/log_in_view.dart';
import 'package:CarRescue/src/presentation/view/technician_view/auth/log_in/log_in_view.dart';
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'package:CarRescue/src/presentation/elements/app_button.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';

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
<<<<<<< Updated upstream
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/selection_bg.png",
                    ),
                    fit: BoxFit.cover)),
=======
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/towtruck.png",
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7),
                    BlendMode.srcOver,
                  )),
            ),
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
              Image.asset(
                "assets/images/app_logo.png",
                height: 100,
                width: 100,
=======
              Center(
                child: Image.asset(
                  "assets/images/logo-no-background.png",
                  height: 200,
                  width: 300,
                ),
>>>>>>> Stashed changes
              ),
              const SizedBox(
                height: 9,
              ),
              RichText(
                  text: TextSpan(
                      text: "Chào mừng đến với",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                          fontSize: 16),
                      children: [
                    TextSpan(
                      text: " RAIDO.",
                      style: TextStyle(
<<<<<<< Updated upstream
                          color: Colors.white,
=======
                          color: Color(0xffffdc00),
>>>>>>> Stashed changes
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    )
                  ])),
              const SizedBox(
                height: 18,
              ),
<<<<<<< Updated upstream
              CustomText(
                text:
                    "The best taxi booking app of the century to make \nyour day great",
                color: Colors.white,
              ),
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
                btnLabel: "I’m a Passenger",
=======
                btnLabel: "Tôi là khách hàng",
              ),
              const SizedBox(
                height: 18,
              ),
              AppButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TechnicianLogInView()));
                },
                btnLabel: "Tôi là kĩ thuật viên",
>>>>>>> Stashed changes
              ),
              const SizedBox(
                height: 18,
              ),
              AppButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CarOwnerLogInView()));
                },
<<<<<<< Updated upstream
                btnLabel: "I’am a Driver",
=======
                btnLabel: "Tôi là chủ xe cứu hộ",
>>>>>>> Stashed changes
              )
            ],
          ),
        )
      ],
    );
  }
}
