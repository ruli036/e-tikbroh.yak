import 'dart:convert';

import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/DriverJson/responJsonDetailJemputanDriver.dart';
import 'package:e_tikbroh_yok/Server/api_server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class DetailJemputanController extends GetxController {
  var Authorization;
  RxBool loading = true.obs;
  RxString pesan = ''.obs;
  RxBool riwayat = false.obs;
  RxString idOrder = ''.obs;
  ModelDetailJemputanDriver? modelDetailJemputanDriver;

  Future detailOrderJemputanDriver(idorder) async {
    final respone = await http.post(Uri.parse(ApiUrl.detailOrderJemputDriver),
        headers: {'Authorization': Authorization}, body: {'idorder': idorder});
    print(
        "------------------------DATA Detail Order jemputan Sampah DRIVER--------------------------");
    print(respone.statusCode);
    print(json.decode(respone.body));
    if (respone.statusCode == 401) {
      Get.defaultDialog(
        title: "INFO",
        barrierDismissible: true,
        content: AlertUpdateApp(text: "Sesi Login Berkhir"),
        confirmTextColor: AppColors.textColor,
        textConfirm: "Ok",
        onConfirm: () {
          GetStorage().erase();
          Get.offAllNamed("/login");
        },
      );
      pesan.value = "Token sudah kadaluarsaharap login kembali";
      loading.value = false;
    } else if (respone.statusCode == 200) {
      modelDetailJemputanDriver =
          modelDetailJemputanDriverFromJson(respone.body);

      final hasil = json.decode(respone.body);
      if (hasil['status'] == true) {
        loading.value = false;
      } else {
        pesan.value = "Belum ada pengajuan penjemputan sampah";
        loading.value = false;
      }
    } else if (respone.statusCode == 404) {
      modelDetailJemputanDriver =
          modelDetailJemputanDriverFromJson(respone.body);
      pesan.value = modelDetailJemputanDriver!.message;
      loading.value = false;
    } else {
      Get.defaultDialog(
          title: "ERROR",
          barrierDismissible: true,
          content: AlertErrorCodeView(
            text: "Server Sedang Dalam Perbaikan, Harap Coba Lagi Nanti",
          ));
      pesan.value = "Server Dalam Perbaikan";
      loading.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Authorization = GetStorage().read(STORAGE_TOKEN);
    riwayat.value = Get.arguments[0];
    idOrder.value = Get.arguments[1];
    detailOrderJemputanDriver(idOrder.value)
        .timeout(const Duration(seconds: 30), onTimeout: () {
      Get.offAllNamed('/home-page');
      loading.value = false;
      pesan.value = "Koneksi internet tidak stabil";
      Get.defaultDialog(
          title: "WARNING",
          barrierDismissible: true,
          content: AlertErrorView(
            text:
                "Waktu pemanggilan berakhir, harap pastikan koneksi anda stabil",
            colors: Colors.yellow,
          ));
    });
  }
}
