import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gillar/src/presentation/view/car_owner_view/payment/payment_view.dart';
import 'package:gillar/src/presentation/view/car_owner_view/trip_details/trip_details_view.dart';

import '../../../../../../configuration/frontend_configs.dart';
import '../../../../../elements/app_button.dart';
import '../../../../../elements/custom_text.dart';
import '../../../layout/driver_profile_widget.dart';

Future<void> showRatingSheet(context) {
  return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 18,
              ),
              Container(
                height: 3,
                width: 36,
                decoration: BoxDecoration(
                  color: const Color(0xffE0E0E0),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              CustomText(
                text: 'Arrived at the destination',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              const SizedBox(
                height: 8,
              ),
              Divider(
                color: FrontendConfigs.kIconColor,
              ),
              const SizedBox(
                height: 8,
              ),
              DriverProfileWidget(onTapped: (){}),
              const SizedBox(
                height: 8,
              ),
              Divider(
                color: FrontendConfigs.kIconColor,
              ),
              CustomText(
                text: 'How was your trip with the driver?',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 8,
              ),
              CustomText(
                text: 'Rate accordingly',
                color: FrontendConfigs.kIconColor,
              ),
              const SizedBox(
                height: 8,
              ),
              RatingBar.builder(
                initialRating: 3,
                glowColor: Colors.amberAccent,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/svg/rating_star.svg',
                    height: 28,
                    width: 28,
                  ),
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap:(){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 45,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xff252525).withOpacity(0.15)),
                      child: Center(
                        child: CustomText(
                          text: 'Cancel',
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const PaymentView()));
                    },
                    child: Container(
                      height: 45,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color:Color(0xFF2DBB54),),
                      child: Center(
                          child: CustomText(
                            text: 'Submit',
                            color: Colors.white,
                          )),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      });
}
Future<void> goingTOPickingUpSheet(context) {
  return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize:MainAxisSize.min,
            children: [
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 3,
                    width: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xffE0E0E0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              DriverProfileWidget(onTapped: (){}),
              const SizedBox(
                height: 24,
              ),
              AppButton(onPressed: (){
                showRatingSheet(context);
              }, btnLabel:'End Trip'),
              const SizedBox(
                height:10,
              ),
            ],
          ),
        );
      });
}
