import 'dart:convert';

import 'package:e_tikbroh_yok/Controllers/home_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/DriverJson/responJsonDetailJemputanDriver.dart';
import 'package:e_tikbroh_yok/Json/DriverJson/responJsonJemputanDriver.dart';
import 'package:e_tikbroh_yok/Server/api_server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class DaftarJemputanDriverController extends GetxController {
  TextEditingController keteraganTambahan = TextEditingController();
  List<TextEditingController> beratItem = [];
  var Authorization;
  RxBool loading = true.obs;
  RxString pesan = ''.obs;
  RxInt tab = 0.obs;
  ModelDaftarJemputanDriver? modelDaftarJemputanDriver;
  ModelDetailJemputanDriver? modelDetailJemputanDriver;
  final homeC = Get.find<HomeController>();
  final keyFormJemputan = GlobalKey<FormState>();
  Map<dynamic, dynamic> catatBerat = {};
  Future<ModelDaftarJemputanDriver> daftarOrderJemputanDriver() async {
    final respone = await http.get(Uri.parse(ApiUrl.daftarJemputanDriver),
        headers: {'Authorization': Authorization});
    print(
        "------------------------DATA daftar Order jemputan Sampah Driver--------------------------");
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
      pesan.value = "Token sudah kadaluarsaharap, harap login kembali";
      loading.value = false;
    } else if (respone.statusCode == 200) {
      modelDaftarJemputanDriver =
          modelDaftarJemputanDriverFromJson(respone.body);
      loading.value = false;
    } else if (respone.statusCode == 404) {
      modelDaftarJemputanDriver =
          modelDaftarJemputanDriverFromJson(respone.body);
      pesan.value = modelDaftarJemputanDriver!.message;
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
    return modelDaftarJemputanDriverFromJson(respone.body);
  }

  Future simpanBeratItem() async {
    try {
      final respone = await http.post(Uri.parse(ApiUrl.catatBeratDriver),
          headers: {'Authorization': Authorization}, body: catatBerat);
      print(respone.statusCode);
      if (respone.statusCode == 401) {
        Get.back();
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
      } else if (respone.statusCode == 304) {
        Get.back();
        Get.defaultDialog(
            title: "INFO",
            barrierDismissible: true,
            content: AlertErrorView(
              text: 'Tidak ada perubahan data',
              colors: Colors.yellow,
            ),
            textConfirm: "OK",
            onConfirm: () {
              Get.back();
            });
      } else {
        final hasil = json.decode(respone.body);
        print('--------------EDIT DATA USER---------------');
        print(hasil);
        if (hasil['status'] == true) {
          loading.value = true;
          daftarOrderJemputanDriver().whenComplete(() {
            loading.value = false;
            Get.back();
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
                  Get.back();
                  Get.back();
                });
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
      }
    } catch (e) {
      Get.back();
      Get.defaultDialog(
          title: "ERROR",
          barrierDismissible: true,
          content: AlertErrorCodeView(
            text: "Server Sedang Dalam Perbaikan Harap Coba Lagi Nanti  ${e}",
          ));
    }
  }

  Future batalkanJemputanDriver(id) async {
    final respone =
        await http.post(Uri.parse(ApiUrl.batalJemputDriver), headers: {
      'Authorization': Authorization
    }, body: {
      'idorder': id,
      'keterangan': keteraganBataljemput.text,
    });
    print("proses " + id);
    print(respone.statusCode);
    print(json.decode(respone.body));
    if (respone.statusCode == 401) {
      loading.value = false;
      pesan.value = "Token sudah kadaluarsaharap login kembali";
      Get.back();
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
    } else if (respone.statusCode == 200) {
      loading.value = true;
      daftarOrderJemputanDriver().whenComplete(() {
        loading.value = false;
        Get.back();
        Get.back();
      });
      keteraganBataljemput.text = "";
    } else {
      pesan.value = "Gagal mengahapus";
      loading.value = false;
      Get.back();
      Get.defaultDialog(
          title: "WARNING",
          barrierDismissible: true,
          content: AlertErrorView(
            text: pesan.value,
            colors: Colors.yellow,
          ));
    }
  }

  Future refreshData() async {
    loading.value = true;
    daftarOrderJemputanDriver().timeout(const Duration(seconds: 30),
        onTimeout: () {
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
      return modelDaftarJemputanDriverFromJson("");
    });
    await Future.delayed(const Duration(milliseconds: 500));
  }

  validasi(id) {
    final form = keyForm.currentState;
    if (form!.validate()) {
      print(id);
      Get.defaultDialog(
          title: "Loading",
          barrierDismissible: false,
          content: LoadingView(text: "Harap Tunggu..."));
      batalkanJemputanDriver(id).timeout(const Duration(seconds: 30),
          onTimeout: () {
        Get.back();
        Get.back();
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

  validasiSimpanBerat(id) {
    final form = keyFormJemputan.currentState;
    if (form!.validate()) {
      Get.defaultDialog(
          title: "LOADING",
          barrierDismissible: false,
          content: LoadingView(text: "Harap Tunggu..."));
      catatBerat.addAll({
        'idorder': id,
        'keterangan': keteraganTambahan.text,
      });
      print(catatBerat);

      simpanBeratItem().timeout(const Duration(seconds: 30), onTimeout: () {
        Get.back();
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    keteraganTambahan.text = "";
    keteraganBataljemput.text = "";
    Authorization = GetStorage().read(STORAGE_TOKEN);
  }
}
