import 'dart:convert';

import 'package:e_tikbroh_yok/Controllers/home_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/DriverJson/responJsonDetailJemputanDriver.dart';
import 'package:e_tikbroh_yok/Json/DriverJson/responJsonJemputanDriver.dart';
import 'package:e_tikbroh_yok/Json/MemberJson/responJsonDetailJemputan.dart';
import 'package:e_tikbroh_yok/Json/MemberJson/responJsonKategoriSampah.dart';
import 'package:e_tikbroh_yok/Json/MemberJson/responJsonOrderJemputanProses.dart';
import 'package:e_tikbroh_yok/Server/api_server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class DaftarJemputanController extends GetxController {
  var Authorization;
  RxString pesan = ''.obs;
  RxBool loading = true.obs;
  RxBool loadingkategori = true.obs;
  Rx<List<DataProses>> proses = Rx<List<DataProses>>([]);
  ModelResponProsesJemputan ? modelResponProsesJemputan;
  ModelKategoriSampah? modelKategoriSampah;
  ModelDetailJemputan? modelDetailJemputan;
  RxList switchValues = [].obs;

  Future refreshData() async {
    loading.value = true;
    proses.value.clear();
    JemputanProses().then((value) {
      kategoriSampah();
    }).timeout(const Duration(seconds: 30), onTimeout: () {
      loading.value = false;
      Get.defaultDialog(
          title: "WARNING",
          barrierDismissible: true,
          content: AlertErrorView(
            text:
            "Waktu pemanggilan berakhir, harap pastikan koneksi anda stabil",
            colors: Colors.yellow,
          ));
    });
    await Future.delayed(const Duration(milliseconds: 500));
  }
  Future kategoriSampah() async {
    Authorization = await GetStorage().read(STORAGE_TOKEN);
    final respone = await http.get(Uri.parse(ApiUrl.kategoriSampah),
        headers: {'Authorization': Authorization});
    print(
        "------------------------DATA daftar Kategori Sampah--------------------------");
    print(respone.statusCode);
    print(json.decode(respone.body));
    modelKategoriSampah = modelKategoriSampahFromJson(respone.body);
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
      loadingkategori.value = false;
      pesan.value = "Token sudah kadaluarsaharap login kembali";
    } else if (respone.statusCode == 200) {
      modelKategoriSampah!.kategori.forEach((element) {
        switchValues.value.addAll({false});
      });
      loadingkategori.value = false;
    } else if (respone.statusCode == 404) {
      pesan.value = "Kategori Sampah Belum Ditambahkan";
      loadingkategori.value = false;
    } else {
      Get.defaultDialog(
          title: "ERROR",
          barrierDismissible: true,
          content: AlertErrorCodeView(
            text: "Server Sedang Dalam Perbaikan, Harap Coba Lagi Nanti",
          ));
      pesan.value = "Server Dalam Perbaikan";
      loadingkategori.value = false;
    }
  }
  Future JemputanProses() async {
    final respone = await http.get(Uri.parse(ApiUrl.orderjemputproses),
        headers: {'Authorization': Authorization});
    print(
        "------------------------DATA daftar Order jemputan Sampah--------------------------");
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
      loading.value = false;
      pesan.value = "Token sudah kadaluarsaharap login kembali";
    } else if (respone.statusCode == 200) {

      final hasil = json.decode(respone.body);
      proses.value = await List<DataProses>.from(hasil['data'].map((x) => DataProses.fromJson(x))).obs;
      print('berhasil');
      loading.value = false;
    } else if (respone.statusCode == 404) {
      modelResponProsesJemputan = modelResponProsesJemputanFromJson(respone.body);
      pesan.value = modelResponProsesJemputan!.message;
      loading.value = false;
    } else if (respone.statusCode == 405) {
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
  Future batalkanOrderan(id) async {
    try {
      final respone =
      await http.post(Uri.parse(ApiUrl.batalkanOrderan), headers: {
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
        Get.back();
        Get.back();
        keteraganBataljemput.text = '';
        final hasil = json.decode(respone.body);
        if (hasil['status'] == true) {
          loading.value = true;
          Get.defaultDialog(
              title: "INFO",
              barrierDismissible: false,
              content: AlertSuccesView(
                text: hasil['message'],
                colors: Colors.yellow,
              ),
              textConfirm: "OK",
              onConfirm: () {
                Get.back();
              });
          JemputanProses().whenComplete(() {
            loading.value = false;
          });
        } else {
          pesan.value = "Gagal mengahapus";
          loading.value = false;
          Get.back();
          Get.defaultDialog(
              title: "WARNING",
              barrierDismissible: false,
              content: AlertErrorView(
                text: hasil['message'],
                colors: Colors.yellow,
              ));
        }
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
    } catch (e) {
      Get.back();
      Get.back();
      Get.defaultDialog(
          title: "ERROR",
          barrierDismissible: true,
          content: AlertErrorView(
            text: '$e',
            colors: Colors.yellow,
          ));
    }
  }
  viewDetail(idorder) {
    detailOrderJemputan(idorder).timeout(const Duration(seconds: 30),
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
  }
  validasiHapus(id) {
    final form = keyForm.currentState;
    if (form!.validate()) {
      print(id);
      Get.defaultDialog(
          title: "Loading",
          barrierDismissible: false,
          content: LoadingView(text: "Harap Tunggu..."));
      batalkanOrderan(id).timeout(const Duration(seconds: 30), onTimeout: () {
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
  Future detailOrderJemputan(idorder) async {
    loading.value = true;
    final respone = await http.post(Uri.parse(ApiUrl.detailOrderJemput),
        headers: {'Authorization': Authorization}, body: {'idorder': idorder});
    print(
        "------------------------DATA Detail Order jemputan Sampah--------------------------");
    print(respone.statusCode);
    print(json.decode(respone.body));
    final hasil = json.decode(respone.body);
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
      loading.value = false;
      pesan.value = "Token sudah kadaluarsaharap login kembali";
    } else if (respone.statusCode == 200) {
      modelDetailJemputan = modelDetailJemputanFromJson(respone.body);
      if (hasil['status'] == true) {
        loading.value = false;
      } else {
        loading.value = false;
        pesan.value = "Belum ada pengajuan penjemputan sampah";
      }
    } else if (respone.statusCode == 404) {
      modelDetailJemputan = modelDetailJemputanFromJson(respone.body);
      pesan.value = modelDetailJemputan!.message;
      loading.value = false;
    } else {
      Get.defaultDialog(
          title: "ERROR",
          barrierDismissible: true,
          content: AlertErrorCodeView(
            text: "Server Sedang Dalam Perbaikan, Harap Coba Lagi Nanti",
          ));
      loading.value = false;
      pesan.value = "Server Dalam Perbaikan";
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Authorization = GetStorage().read(STORAGE_TOKEN);
    kategoriSampah().timeout(const Duration(seconds: 60), onTimeout: () {
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
