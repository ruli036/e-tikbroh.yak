import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Controllers/splash_screen_controller.dart';

class SplasScreenView extends StatelessWidget {
  const SplasScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final splashC = Get.find<SplasScreenController>();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.themeColor, // Set your desired color here
      statusBarIconBrightness: Brightness.light, // or Brightness.dark
    ));
    return WillPopScope(
      onWillPop: () {
        return splashC.keluar();
      },
      child: Scaffold(
        backgroundColor: AppColors.color4,
          body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            height: size(context).height,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(size(context).height / 10)),
                Center(
                  child: Image.asset(
                    objectApp.logoApp,
                    scale: 2.5,
                  ),
                ),
                const CircularProgressIndicator()
              ],
            ),
          ),
        ),
      )),
    );
  }
}
