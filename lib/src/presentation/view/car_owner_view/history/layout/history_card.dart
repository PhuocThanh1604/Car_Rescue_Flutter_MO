import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';

import '../../../../../configuration/frontend_configs.dart';
import '../../layout/selection_location_widget.dart';

class HistoryCard extends StatefulWidget {
  HistoryCard(
      {Key? key,
      required this.name,
      required this.image,
      required this.time,
      required this.btnLabel})
      : super(key: key);
  final String name;
  final String image;
  final String time;
  final String btnLabel;

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  bool isShowDetails = false;
  bool isShowButton = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6), borderSide: BorderSide.none),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 12),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        child: Image.asset(
                          widget.image,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: widget.name,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          CustomText(
                            text: widget.time,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 28,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2DBB54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.btnLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Divider(
              color: FrontendConfigs.kIconColor,
            ),
            isShowDetails
                ? SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 36,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  isShowDetails = !isShowDetails;
                                });
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: FrontendConfigs.kPrimaryColor,
                              )))
                    ],
                  ),
            isShowDetails
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset("assets/svg/location_icon.svg",
                                  color: FrontendConfigs.kPrimaryColor),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomText(
                                text: "6.5 km",
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset("assets/svg/watch_icon.svg"),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomText(
                                text: "15 mins",
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svg/wallet_icon.svg",
                                color: FrontendConfigs.kPrimaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomText(
                                text: "\$56.00",
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Date & Time',
                            color: FrontendConfigs.kIconColor,
                          ),
                          CustomText(
                            text: 'Jul 12, 2022 | 12:30 PM',
                            fontWeight: FontWeight.w600,
                          ),
                        ],
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
                      RideSelectionWidget(
                        icon: 'assets/svg/pickup_icon.svg',
                        title: 'Pick up Location',
                        // body: '089 Stark Gateway',
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
                        // body: '92676 Orion Meadows',
                        onPressed: () {},
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isShowDetails = !isShowDetails;
                                });
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_up_rounded,
                                color: FrontendConfigs.kPrimaryColor,
                              ))
                        ],
                      )
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
