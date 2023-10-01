import 'package:flutter/material.dart';
import 'package:gillar/src/configuration/frontend_configs.dart';
import 'package:gillar/src/presentation/view/car_owner_view/auth/car_registration/layout/widgets/field_widget.dart';
import 'package:gillar/src/presentation/view/car_owner_view/auth/car_registration/layout/widgets/upload_file_widget.dart';

class CarRegistrationBody extends StatelessWidget {
  CarRegistrationBody({Key? key}) : super(key: key);
  final TextEditingController _carModelController = TextEditingController();
  final TextEditingController _carNumberController = TextEditingController();
  final TextEditingController _carYearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:18.0),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Text(
                "Add Vehicle \nDetails",
                style: FrontendConfigs.kHeadingStyle,
              ),
              const SizedBox(height:18,),
              RegistrationFieldWidget(
                  controller: _carModelController,
                  keyBoardType: TextInputType.number,
                  text: 'Enter Car model'),
              const SizedBox(height:18,),
              RegistrationFieldWidget(
                  controller: _carNumberController,
                  keyBoardType: TextInputType.number,
                  text: 'Enter Car Number Plate'),
              const SizedBox(height:18,),
              RegistrationFieldWidget(
                  controller: _carYearController,
                  keyBoardType: TextInputType.number,
                  text: 'Make Year'),
              const SizedBox(height:12,),
              const UploadFileWidget(btnLebal:'Upload File', fileName:'Upload vehicle Documents'),
              const SizedBox(height:18,),
              const UploadFileWidget(btnLebal:'Upload File', fileName:'Upload Photo of License'),
            ],
          ),
        ),
      ),
    );
  }
}
