import 'package:flutter/material.dart';
import 'package:CarRescue/src/presentation/elements/app_button.dart';
import 'package:CarRescue/src/presentation/elements/custom_appbar.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/trip_details/trip_details_view.dart';

import '../../../../configuration/frontend_configs.dart';
import '../../../elements/custom_text.dart';
import 'layout/body.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, showText: true, text: 'Payment Detail'),
      body: const PaymentBody(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 18.0, left: 18, bottom: 10),
        child: AppButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TripDetailsView()));
          },
          btnLabel: 'Done',
        ),
      ),
    );
  }
}

Future<void> addTolDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
          // insetPadding:const EdgeInsets.all(6),
          contentPadding: const EdgeInsets.all(12),
          insetPadding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: 'Add Toll',
                fontSize: 21,
                fontWeight: FontWeight.w600,
              )
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: "Enter sum of the all toll price",
                  color: FrontendConfigs.kIconColor,
                ),
                const SizedBox(
                  height: 6,
                ),
                SizedBox(
                  height: 52,
                  child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Toll Price \$0.00',
                          hintStyle: TextStyle(
                              color: FrontendConfigs.kIconColor,
                              fontSize: 16,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none),
                          fillColor: FrontendConfigs.kAuthColor,
                          filled: true)),
                ),
                const SizedBox(
                  height: 18,
                ),
                AppButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  btnLabel: 'Done',
                ),
                const SizedBox(
                  height: 18,
                ),
              ],
            ),
          ));
    },
  );
}
