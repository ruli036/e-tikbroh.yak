import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Helpers/widgets.dart';

class LupaPasswordController extends GetxController {
  TextEditingController email = TextEditingController();
  final keyform = GlobalKey<FormState>();
  final storage = GetStorage();

  validasi() {
    final form = keyform.currentState;
    if (form!.validate()) {
      Get.defaultDialog(
          title: "LOADING",
          barrierDismissible: false,
          content: LoadingView(text: "Mengirim Kode OTP"));
      cekKoneksi(() {
        requestOTPResetPassword(email.text).timeout(const Duration(seconds: 30),
            onTimeout: () {
          Get.back();
          Get.defaultDialog(
              title: "WARNING",
              barrierDismissible: true,
              content: AlertErrorView(
                text:
                    "Waktu pemanggilan berakhir, harap pastikan koneksi anda stabil",
                colors: Colors.yellow,
              ));
        });
      });
    }
  }
}
