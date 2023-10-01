import 'package:flutter/material.dart';
import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';

class PaymentCardWidget extends StatelessWidget {
  const PaymentCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Toll Amount',
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: FrontendConfigs.kIconColor,
                  ),
                  CustomText(
                    text: '\$0.00',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: 'Payment method',
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: FrontendConfigs.kIconColor),
                  CustomText(
                    text: 'E-Wallet',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: 'Ride Fare',
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: FrontendConfigs.kIconColor),
                  CustomText(
                    text: '\$27.00',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Divider(
                color: FrontendConfigs.kIconColor,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Total Amount',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    text: '\$30.00',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
