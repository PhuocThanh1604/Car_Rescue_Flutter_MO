import 'package:flutter/material.dart';

import '../layout/history_card.dart';

class CanceledView extends StatelessWidget {
  const CanceledView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount:8,
              shrinkWrap:true,
              // physics:const NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                return HistoryCard(
                  name: 'Daniel Austin',
                  image: 'assets/images/profile.png',
                  time: 'Jul 12, 2022',
                  btnLabel: 'Canceled',
                );
              }),
        ),
      ],
    );
  }
}
