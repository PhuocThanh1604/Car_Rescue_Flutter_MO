import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_svg/flutter_svg.dart';
import 'package:CarRescue/src/presentation/elements/custom_text.dart';

import 'layout/body.dart';

class SelectModeView extends StatelessWidget {
  const SelectModeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
<<<<<<< HEAD
        actions: [_popMenu()],
=======
>>>>>>> origin/MinhAndHieu6
      ),
      body: const SelectModeBody(),
    );
  }

<<<<<<< HEAD
  Widget _popMenu() {
    return PopupMenuButton(
        icon: const Icon(
          Icons.more_vert,
          size: 20,
          color: Colors.white,
        ),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none),
        itemBuilder: (context) => [
              PopupMenuItem(
                  height: 40,
                  child: CustomText(
                    text: 'English',
                  )),
              PopupMenuItem(
                  height: 40,
                  child: CustomText(
                    text: 'Spanish',
                  ))
            ]);
  }
=======
  // Widget _popMenu() {
  //   return PopupMenuButton(
  //       icon: const Icon(
  //         Icons.more_vert,
  //         size: 20,
  //         color: Colors.white,
  //       ),
  //       shape: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(6),
  //           borderSide: BorderSide.none),
  //       itemBuilder: (context) => [
  //             PopupMenuItem(
  //                 height: 40,
  //                 child: CustomText(
  //                   text: 'English',
  //                 )),
  //             PopupMenuItem(
  //                 height: 40,
  //                 child: CustomText(
  //                   text: 'Spanish',
  //                 ))
  //           ]);
  // }
>>>>>>> origin/MinhAndHieu6
}
