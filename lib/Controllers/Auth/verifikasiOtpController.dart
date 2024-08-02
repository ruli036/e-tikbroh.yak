import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Helpers/helpers.dart';
import '../../Helpers/widgets.dart';
import '../../Server/api_server.dart';
import 'lupaPassController.dart';
import 'requestOtpController.dart';

class VerifikasiOtpController extends GetxController {
  final TextEditingController fieldOne = TextEditingController();
  final TextEditingController fieldTwo = TextEditingController();
  final TextEditingController fieldThree = TextEditingController();
  final TextEditingController fieldFour = TextEditingController();
  final TextEditingController fieldFive = TextEditingController();
  RxString otp = ''.obs;
  RxInt time = 60.obs;
  RxBool KirimKodeUlang = false.obs;
  bool resetPassword = false;
  final RegistrasiC = Get.find<RequestOtpController>();
  final ResetPasswordC = Get.find<LupaPasswordController>();
  verifikasiOtp() async {
    try {
      final respone = await http.post(Uri.parse(ApiUrl.verivikasiOtp),
          body: {'email': RegistrasiC.email.text, 'otp': otp.value});
      print('-----------------------------');
      print(respone.statusCode);
      final hasil = json.decode(respone.body);
      if (respone.statusCode == 200) {
        print(hasil);
        if (hasil['status'] == true) {
          Get.back();
          Get.toNamed('/registrasi-user', arguments: false);
        } else {
          Get.back();
          Get.defaultDialog(
              title: "WARNING",
              barrierDismissible: true,
              content: AlertErrorView(
                text: hasil['message'],
                colors: Colors.yellow,
              ));
        }
      } else {
        Get.back();
        Get.defaultDialog(
            title: "ERROR",
            barrierDismissible: true,
            content: AlertErrorCodeView(
              text: "${hasil['message']} ${respone.statusCode}",
            ));
      }
    } catch (e) {
      Get.back();
      Get.defaultDialog(
          title: "ERROR",
          barrierDismissible: true,
          content: AlertErrorCodeView(
            text: "server sedang dalam perbaikan, harap coba lagi nanti! ${e}",
          ));
    }
  }

  verifikasiOtpResetPass() async {
    try {
      final respone = await http.post(Uri.parse(ApiUrl.verivikasiOtpResetPass),
          body: {'email': ResetPasswordC.email.text, 'otp': otp.value});
      final hasil = json.decode(respone.body);
      if (respone.statusCode == 200) {
        print(hasil);
        if (hasil['status'] == true) {
          Get.back();
          Get.toNamed('/reset-pass', arguments: true);
        } else {
          Get.back();
          Get.defaultDialog(
              title: "WARNING",
              barrierDismissible: true,
              content: AlertErrorView(
                text: hasil['message'],
                colors: Colors.yellow,
              ));
        }
      } else {
        Get.back();
        Get.defaultDialog(
            title: "ERROR",
            barrierDismissible: true,
            content: AlertErrorCodeView(
              text: "${hasil['message']} ${respone.statusCode}",
            ));
      }
    } catch (e) {
      Get.back();
      Get.defaultDialog(
          title: "ERROR",
          barrierDismissible: true,
          content: AlertErrorCodeView(
              text:
                  "server sedang dalam perbaikan, harap coba lagi nanti!  ${e}"));
    }
  }

  validasi() {
    if (otp.value.length == 5) {
      print(resetPassword);
      print(ResetPasswordC.email.text);
      print(otp.value);
      Get.defaultDialog(
          title: "LOADING",
          barrierDismissible: false,
          content: LoadingView(text: "Verifikasi Kode OTP"));
      if (resetPassword == true) {
        cekKoneksi(() {
          verifikasiOtpResetPass().timeout(const Duration(seconds: 30),
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
      } else {
        cekKoneksi(() {
          verifikasiOtp().timeout(const Duration(seconds: 30), onTimeout: () {
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

  requestOptAgain() {
    Get.defaultDialog(
        title: "LOADING",
        barrierDismissible: false,
        content: LoadingView(text: "Mengirim Kode OTP"));
    if (resetPassword == true) {
      cekKoneksi(() {
        requestOTPResetPassword(ResetPasswordC.email.text)
            .timeout(const Duration(seconds: 30), onTimeout: () {
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
    } else {
      cekKoneksi(() {
        requestOTP(RegistrasiC.email.text).timeout(const Duration(seconds: 30),
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
    time.value = 60;
    KirimKodeUlang.value = false;
  }

  void timer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time.value == 0) {
        KirimKodeUlang.value = true;
      } else {
        time.value--;
      }
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    timer();
    resetPassword = Get.arguments;
  }
}
