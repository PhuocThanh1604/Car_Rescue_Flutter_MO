import 'package:flutter/material.dart';
import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';

class CityButton extends StatefulWidget {
  CityButton({
    Key? key,
    required this.btnLabel,
  }) : super(key: key);
  final String btnLabel;
  bool isChecked = false;
  @override
  State<CityButton> createState() => _CityButtonState();
}

class _CityButtonState extends State<CityButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.isChecked = !widget.isChecked;
        });
      },
      child: Container(
        height: 51,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: FrontendConfigs.kPrimaryColor, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 30,
              ),
              SizedBox(width: 60, child: CustomText(text: widget.btnLabel)),
              if (widget.isChecked!)
                const Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: SizedBox(
                      width: 10,
                      child: Icon(
                        Icons.check_circle,
                        color: Color(0xFF2DBB54),
                        size: 20,
                      )),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Container(
                    width: 10,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
