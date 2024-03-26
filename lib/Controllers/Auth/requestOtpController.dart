import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Helpers/helpers.dart';

class RequestOtpController extends GetxController {
  TextEditingController namaUser = TextEditingController();
  TextEditingController noHp = TextEditingController();
  TextEditingController email = TextEditingController();
  RxString statusUser = "member".obs;
  final keyform = GlobalKey<FormState>();
  final storage = GetStorage();

  void onClick(value) {
    statusUser.value = value;
  }

  validasi() {
    final form = keyform.currentState;
    if (form!.validate()) {
      Get.defaultDialog(
          title: "LOADING",
          barrierDismissible: false,
          content: LoadingView(text: "Mengirim Kode OTP"));
      cekKoneksi(() {
        requestOTP(email.text).timeout(const Duration(seconds: 30),
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
