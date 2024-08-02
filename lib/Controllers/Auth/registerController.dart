import 'dart:convert';

import 'package:e_tikbroh_yok/Controllers/Auth/lupaPassController.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Server/api_server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'requestOtpController.dart';

class RegitrasiController extends GetxController {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  RxBool lihatpass = true.obs;
  final keyform = GlobalKey<FormState>();
  final storage = GetStorage();
  bool isLogin = false;
  bool resetPassword = false;
  void lihatpassword() {
    lihatpass.value = !lihatpass.value;
  }

  final RegistrasiC = Get.find<RequestOtpController>();
  final ResetPasswodC = Get.find<LupaPasswordController>();
  registrasiUser() async {
    try {
      final respone = await http.post(Uri.parse(ApiUrl.registrasi), body: {
        'email': RegistrasiC.email.text,
        'nohp': RegistrasiC.noHp.text,
        'nama': RegistrasiC.namaUser.text,
        'pass': password.text,
        'level': RegistrasiC.statusUser.value
      });
      final hasil = json.decode(respone.body);
      print('-----------------------------');
      print(hasil);
      print(respone.statusCode);
      if (hasil['status'] == true) {
        Get.back();
        Get.defaultDialog(
            title: "INFO",
            barrierDismissible: true,
            content: AlertSuccesView(
              text: hasil['message'],
              colors: Colors.green,
            ),
            textConfirm: "OK",
            onConfirm: () {
              Get.offAllNamed('/login');
            });
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
    } catch (e) {
      Get.back();
      Get.defaultDialog(
          title: "ERROR",
          barrierDismissible: true,
          content: AlertErrorCodeView(
            text: "Server sedang dalam perbaikan, harap coba lagi nanti! ${e}",
          ));
    }
  }

  resetPasswordBaru() async {
    try {
      print(ResetPasswodC.email.text);
      print(password.text);
      final respone = await http.post(Uri.parse(ApiUrl.resetPassword),
          body: {'email': ResetPasswodC.email.text, 'pass': password.text});
      final hasil = json.decode(respone.body);
      // timeOut(hasil);
      print('-----------------------------');
      print(hasil);
      print(respone.statusCode);
      if (respone.statusCode == 200) {
        if (hasil['status'] == true) {
          Get.back();
          Get.defaultDialog(
              title: "INFO",
              barrierDismissible: true,
              content: AlertSuccesView(
                text: hasil['message'],
                colors: Colors.green,
              ),
              textConfirm: "OK",
              onConfirm: () {
                Get.offAllNamed('/login');
              });
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
            title: "WARNING",
            barrierDismissible: true,
            content: AlertErrorView(
              text: "${hasil['message']} ${respone.statusCode}",
              colors: Colors.yellow,
            ));
      }
    } catch (e) {
      Get.back();
      Get.defaultDialog(
          title: "ERROR",
          barrierDismissible: true,
          content: AlertErrorCodeView(
            text: "server sedang dalam perbaikan, harap coba lagi nanti!  ${e}",
          ));
    }
  }

  validasi() {
    final form = keyform.currentState;
    if (form!.validate()) {
      if (password.text != confirmPassword.text) {
        Get.defaultDialog(
            title: "WARNING",
            barrierDismissible: true,
            content: AlertErrorView(
              text: "Confirmasi Password Tidak Cocok",
              colors: Colors.yellow,
            ));
      } else {
        print(resetPassword);
        Get.defaultDialog(
            title: "LOADING",
            barrierDismissible: false,
            content: LoadingView(text: "Harap Tunggu..."));
        if (resetPassword == true) {
          print("REset pass");
          cekKoneksi(() {
            resetPasswordBaru().timeout(const Duration(seconds: 30),
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
            registrasiUser().timeout(const Duration(seconds: 30),
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
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    resetPassword = Get.arguments;
  }
}
