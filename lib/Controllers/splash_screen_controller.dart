import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

import '../Helpers/constans.dart';
import '../Helpers/helpers.dart';
import '../Helpers/widgets.dart';
import '../Server/api_server.dart';

class SplasScreenController extends GetxController {
  double app_version = 1.3;
  String app_version_db = '';
  String link =
      'https://play.google.com/store/apps/details?id=com.usyiah.e_tikbroh_yok&hl=en-ID';
  String Authorization = '';
  bool status_login = false;
  keluar() {
    SystemNavigator.pop();
  }

  Future cekVersion() async {
    try {
      final respone = await http.get(Uri.parse(ApiUrl.cekVersionApp));
      print(respone.statusCode);
      if (respone.statusCode == 200) {
        final hasil = json.decode(respone.body);
        print("hasil");
        print(hasil);
        if (hasil['status'] == true) {
          app_version_db = hasil['version'];
          print(app_version_db);
          print(app_version);
          if (app_version == double.parse(app_version_db)) {
            cekLogin().whenComplete(() {
              daftarLokasi(Authorization).then((value) {
                timer();
              });
            });
          } else {
            Get.defaultDialog(
                title: "INFO",
                barrierDismissible: true,
                content: AlertUpdateApp(
                    text:
                        "aplikasi yang anda gunakan memiliki beberapa perubahan"),
                confirmTextColor: AppColors.textColor,
                textConfirm: "Update",
                textCancel: "Close App",
                onConfirm: () {
                  SystemNavigator.pop();
                  launchInBrowserUpdate();
                },
                onCancel: () {
                  SystemNavigator.pop();
                });
          }
        } else {
          Get.defaultDialog(
              title: "WARNING",
              barrierDismissible: true,
              content: AlertErrorView(
                text: "Server Sedang Dalam Perbaikan Harap Coba Lagi Nanti",
                colors: Colors.red,
              ),
              textConfirm: "Close App",
              confirmTextColor: Colors.white,
              onConfirm: () {
                SystemNavigator.pop();
                print("Close App");
              });
        }
      } else {
        print("Time Out");
        Get.offAllNamed("/login");
        return;
      }
    } catch (e) {
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

  Future<void> launchInBrowserUpdate() async {
    await launchUrlString(link);
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

  Future cekLogin() async {
    status_login = GetStorage().read(STORAGE_STATUS_LOGIN) ?? false;
    Authorization = GetStorage().read(STORAGE_TOKEN) ?? '';
    print('----------------------------------');
    print(status_login);
    print(Authorization);
  }

  void timer() {
    Timer(const Duration(seconds: 2), () {
      if (status_login == false) {
        Get.offAllNamed('/login');
      } else {
        Get.offAllNamed('/home-page');
      }
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    cekVersion().timeout(const Duration(seconds: 30), onTimeout: () {
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

    /// handle notif on terminate
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        // var id = message.data['idsambunganbaru'];
        // final selesai = message.data['selesai'] ?? 'false';
        // Get.toNamed('/traking-sambungan-baru', arguments: id);
        print(message.notification!.title);
        // if (selesai == 'true') {
        //   syncDataPelangga(true);
        // }
      }
    });

    /// handle notif on baground
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message != null) {
        // var id = message.data['idsambunganbaru'];
        // final selesai = message.data['selesai'] ?? 'false';
        // Get.toNamed('/traking-sambungan-baru', arguments: id);
        print(message.notification!.title);
        // if (selesai == 'true') {
        //   syncDataPelangga(true);
        // }
      }
    });

    /// handle notif on app open
    FirebaseMessaging.onMessage.listen((message) {
      if (message != null) {
        // var id = message.data['idsambunganbaru'];
        // final selesai = message.data['selesai'] ?? 'false';
        // Get.toNamed('/traking-sambungan-baru', arguments: id);
        // if (selesai == 'true') {
        //   syncDataPelangga(true);
        // }
        print(message.notification!.title);
      }
    });
  }
}
