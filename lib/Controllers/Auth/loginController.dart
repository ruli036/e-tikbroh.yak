import 'dart:convert';

import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/responJsonLogin.dart';
import 'package:e_tikbroh_yok/Server/api_server.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool lihatpass = true.obs;
  final keyform = GlobalKey<FormState>();
  String token = "";
  ResponLogin? responLogin;

  void lihatpassword() {
    lihatpass.value = !lihatpass.value;
  }

  Future getFirebaseAuthToken(authorization) async {
    String? tokenFirebase = await FirebaseMessaging.instance.getToken();
    if (tokenFirebase != "") {
      print(
          "-------------------------tokenFirebase----------------------------");
      print(tokenFirebase);
      final respone =
          await http.post(Uri.parse(ApiUrl.registertoken), headers: {
        'Authorization': authorization
      }, body: {
        'token': tokenFirebase,
      });
      final hasil = json.decode(respone.body);
      print(hasil);
    } else {
      print("TOKEN NULL");
    }
  }

  Future daftarLokasi(Authorization) async {
    final respone = await http.get(Uri.parse(ApiUrl.daftarTitikJemputan),
        headers: {'Authorization': Authorization});
    final hasil = json.decode(respone.body);
    print(
        "------------------------DATA daftar lokasi jemputan--------------------------");
    print(respone.statusCode);
    print(json.decode(respone.body));
    if (respone.statusCode == 200) {
      StorageAPP.updateDataLokasi(hasil['data']);
    }
  }

  login() async {
    try {
      final respone = await http.post(Uri.parse(ApiUrl.login),
          body: {'email': email.text, 'pass': password.text});
      print(
          "-----------------------------------------LOGIN----------------------------------");
      print(respone.statusCode);
      final hasil = json.decode(respone.body);
      print("LOGIN");
      print(hasil);
      if (hasil['status'] == true) {
        responLogin = ResponLogin.fromJson(hasil);
        await getFirebaseAuthToken(responLogin!.token);
        await daftarLokasi(responLogin!.token);
        await StorageAPP.storageLogin(
          email.text,
          responLogin!.status,
          responLogin!.token,
          responLogin!.nama,
          responLogin!.nohp,
          responLogin!.foto,
          responLogin!.level,
        );
        Get.back();
        Get.offAllNamed('/home-page');
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
          title: "WARNING",
          barrierDismissible: true,
          content: AlertErrorView(
            text: "Server Sedang Dalam Perbaikan Harap Coba Lagi Nanti ${e}",
            colors: Colors.red,
          ),
          textConfirm: "Close App",
          confirmTextColor: Colors.white,
          onConfirm: () {
            SystemNavigator.pop();
            print("Close App");
          });
    }
  }

  validasi() {
    final form = keyform.currentState;
    if (form!.validate()) {
      Get.defaultDialog(
          title: "LOADING",
          barrierDismissible: false,
          content: LoadingView(text: "Harap Tunggu..."));
      cekKoneksi(() {
        login().timeout(const Duration(seconds: 30), onTimeout: () {
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
