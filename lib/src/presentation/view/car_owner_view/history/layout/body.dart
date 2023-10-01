import 'package:flutter/material.dart';
import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/history/campleted/completed_view.dart';

import '../canceled/canceled_view.dart';

class HistoryBody extends StatelessWidget {
  const HistoryBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            TabBar(
                indicatorColor: FrontendConfigs.kPrimaryColor,
                labelColor: FrontendConfigs.kPrimaryColor,
                labelStyle: TextStyle(
                  color: FrontendConfigs.kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(
                    color: FrontendConfigs.kIconColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                indicatorWeight: 1,
                tabs: const [
                  Tab(
                    text: "Completed",
                  ),
                  Tab(
                    text: "Canceled",
                  ),
                ]),
            const SizedBox(
              height: 18,
            ),
            const Expanded(
              child: TabBarView(children: [CompletedView(), CanceledView()]),
            ),
          ],
        ),
      ),
    );
  }
}
