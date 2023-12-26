import 'package:flutter/material.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';
import 'package:CarRescue/src/presentation/view/select_city/layout/custom_button.dart';

class SelectCityBody extends StatelessWidget {
  const SelectCityBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
<<<<<<< HEAD
              Transform.translate(
                offset: const Offset(-12, 0),
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 100,
                  width: 100,
=======
              Center(
                child: Image.asset(
                  "assets/images/logocarescue.png",
                  height: 200,
                  width: 500,
>>>>>>> origin/MinhAndHieu6
                ),
              ),
              const SizedBox(
                height: 18,
              ),
<<<<<<< HEAD
              RichText(
                  text: const TextSpan(
                      text: "  Be your own ",
                      style: TextStyle(
                          color: Color(0xff2F2E41),
                          fontWeight: FontWeight.w400,
                          // letterSpacing: 2,
                          fontSize: 15),
                      children: [
                    TextSpan(
                      text: "Concierge.",
                      style: TextStyle(
                          color: Color(0xFF2DBB54),
                          fontWeight: FontWeight.w600,
                          // letterSpacing: 2,
                          fontSize: 15),
                    )
                  ])),
=======
>>>>>>> origin/MinhAndHieu6
              const SizedBox(
                height: 44,
              ),
              CustomText(
<<<<<<< HEAD
                text: "Select your city",
=======
                text: "Chọn thành phố bạn đang sống",
>>>>>>> origin/MinhAndHieu6
                fontSize: 21,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
              const SizedBox(
                height: 12,
              ),
<<<<<<< HEAD
              CityButton(btnLabel: "Ibiza"),
              const SizedBox(
                height: 18,
              ),
              CityButton(btnLabel: "Santorini"),
              const SizedBox(
                height: 18,
              ),
              CityButton(btnLabel: "Dubai"),
=======

              CityButton(btnLabel: "TP Hồ Chí Minh"),
              const SizedBox(
                height: 18,
              ),
              CityButton(
                btnLabel: "Hà Nội (Sớm ra mắt)",
                isDisabled: true,
              ),
>>>>>>> origin/MinhAndHieu6
            ],
          ),
        ),
      ),
    );
  }
}
