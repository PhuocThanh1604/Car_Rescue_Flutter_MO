import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';
import '../../../../elements/app_button.dart';
import '../payment_view.dart';
import 'widgets/payment_card.dart';

class PaymentBody extends StatelessWidget {
  const PaymentBody({Key? key}) : super(key: key);

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
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: "Total Amount"),
                  InkWell(
                    onTap: () {
                      addTolDialog(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          color: FrontendConfigs.kPrimaryColor,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomText(text: "Add Toll"),
                      ],
                    ),
                  ),
                ],
              ),
              CustomText(
                text: "\$30.00",
                fontSize: 21,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 12,
              ),
              const PaymentCardWidget()
            ],
          ),
        ),
      ),
    );
  }
}
