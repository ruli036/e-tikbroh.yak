import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/splash_screen_controller.dart';

class SplasScreenView extends StatelessWidget {
  const SplasScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final splashC = Get.find<SplasScreenController>();
    return WillPopScope(
      onWillPop: () {
        return splashC.keluar();
      },
      child: Scaffold(
          body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: size(context).height,
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(size(context).height / 10)),
                    Center(
                      child: Image.asset(
                        objectApp.logoApp,
                        scale: 2,
                      ),
                    ),
                    const CircularProgressIndicator()
                  ],
                ),
              ),
            ),
            BagroundAuthentication(
                buttonview: keyboardIsVisible(context) ? false : true,
                bottomview: false,
                text: "e-Tikbroh Yak",
                title: "Web",
                onTap: () {})
          ],
        ),
      )),
    );
  }
}
