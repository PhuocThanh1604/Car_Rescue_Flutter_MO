import 'package:flutter/material.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';

class UploadFileWidget extends StatelessWidget {
  const UploadFileWidget(
      {Key? key, required this.btnLebal, required this.fileName})
      : super(key: key);
  final String btnLebal;
  final String fileName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: fileName,
        ),
        Container(
          height: 49,
          width: 140,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.black, width: 0.3)),
          child: Center(
            child: CustomText(
              text: btnLebal,
            ),
          ),
        )
      ],
    );
  }
}
