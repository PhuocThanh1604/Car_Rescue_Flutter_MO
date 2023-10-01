import 'package:flutter/material.dart';
import 'package:gillar/src/presentation/elements/custom_text.dart';
import 'package:gillar/src/presentation/view/select_city/layout/custom_button.dart';

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
              Transform.translate(
                offset: const Offset(-12, 0),
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 100,
                  width: 100,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
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
              const SizedBox(
                height: 44,
              ),
              CustomText(
                text: "Select your city",
                fontSize: 21,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
              const SizedBox(
                height: 12,
              ),
               CityButton(btnLabel: "Ibiza"),
              const SizedBox(
                height: 18,
              ),
               CityButton(btnLabel: "Santorini"),
              const SizedBox(
                height: 18,
              ),
               CityButton(btnLabel: "Dubai"),
            ],
          ),
        ),
      ),
    );
  }
}
