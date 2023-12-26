<<<<<<< HEAD

=======
>>>>>>> origin/MinhAndHieu6
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import '../../../../../../configuration/frontend_configs.dart';
import '../../../../../elements/custom_text.dart';
<<<<<<< HEAD
import '../../../layout/driver_profile_widget.dart';
=======
// import '../../../layout/driver_profile_widget.dart';
>>>>>>> origin/MinhAndHieu6
import '../../../layout/selection_location_widget.dart';
import 'pick_up_bottom_sheet.dart';

Future<void> requestBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      context: context,
      builder: (dialogContext) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "New Request",
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
                height: 8,
              ),
<<<<<<< HEAD
              DriverProfileWidget(onTapped: (){}),
=======
              // DriverProfileWidget(onTapped: () {}),
>>>>>>> origin/MinhAndHieu6
              const SizedBox(
                height: 8,
              ),
              Divider(
                color: FrontendConfigs.kIconColor,
              ),
              const SizedBox(
                height: 8,
              ),
              RideSelectionWidget(
                icon: 'assets/svg/pickup_icon.svg',
                title: 'Pick up Location',
                body: '089 Stark Gateway',
                onPressed: () {},
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: DottedLine(
                  direction: Axis.vertical,
                  lineLength: 30,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 2.0,
                  dashGapLength: 4.0,
                  dashGapRadius: 0.0,
                ),
              ),
              RideSelectionWidget(
                icon: 'assets/svg/location_icon.svg',
                title: 'Drop off Location',
                body: '92676 Orion Meadows',
                onPressed: () {},
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
<<<<<<< HEAD
                    onTap:(){
=======
                    onTap: () {
>>>>>>> origin/MinhAndHieu6
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
                          text: 'Reject',
                        ),
                      ),
                    ),
                  ),
                  InkWell(
<<<<<<< HEAD
                    onTap:(){
                      Navigator.pop(dialogContext);
                pickUpBottomSheetSheet(context);
=======
                    onTap: () {
                      Navigator.pop(dialogContext);
                      pickUpBottomSheetSheet(context);
>>>>>>> origin/MinhAndHieu6
                    },
                    child: Container(
                      height: 45,
                      width: 150,
                      decoration: BoxDecoration(
<<<<<<< HEAD
                          borderRadius: BorderRadius.circular(6),
                          color: Color(0xFF2DBB54),),
                      child: Center(
                          child: CustomText(
                            text: 'Accept',
                            color: Colors.white,
                          )),
=======
                        borderRadius: BorderRadius.circular(6),
                        color: Color(0xFF2DBB54),
                      ),
                      child: Center(
                          child: CustomText(
                        text: 'Accept',
                        color: Colors.white,
                      )),
>>>>>>> origin/MinhAndHieu6
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      });
<<<<<<< HEAD
}
=======
}
>>>>>>> origin/MinhAndHieu6
