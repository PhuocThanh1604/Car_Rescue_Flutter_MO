import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';
import 'package:CarRescue/src/presentation/view/customer_view/home/home_view.dart';
import 'package:CarRescue/src/presentation/view/customer_view/order/layout/repair_layout/body.dart';
import 'package:CarRescue/src/presentation/view/customer_view/order/layout/tow_layout/body.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderView extends StatelessWidget {
  final LatLng latLng;
  final String address;
  final String serviceType;
  const OrderView({Key? key, required this.latLng, required this.address, required this.serviceType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget body;
    
    if (serviceType == "Fixing") {
      body = RepairBody(latLng: latLng, address: address);
    } else if (serviceType == "Towing") {
      body = TowBody(latLng: latLng, address: address);
    } else {
      // Handle other cases or provide a default body.
      body = Text("Invalid service type");
    }
    return Scaffold(
        appBar:AppBar(
          backgroundColor:Colors.transparent,
          elevation:0,
          leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
          //  Navigator.of(context).pushReplacement(
          //                   MaterialPageRoute(
          //                       builder: (context) => HomeView(services:serviceType == "repair"?"repair":"tow")),
          //                 );
          Navigator.of(context).pop();
          },
        ),
          title:CustomText(text: 'Đơn đặt',fontSize:16,color:FrontendConfigs.kPrimaryColor,),
          centerTitle:true,
        ),
      body:body,
    );
  }
}