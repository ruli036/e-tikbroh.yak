import 'dart:convert';

import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/DriverJson/responJsonDetailJemputanDriver.dart';
import 'package:e_tikbroh_yok/Json/DriverJson/responJsonRiwayatJemputanDriver.dart';
import 'package:e_tikbroh_yok/Server/api_server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class DaftarRiwayatJemputanDriverController extends GetxController {
  TextEditingController keteraganBataljemput = TextEditingController();
  TextEditingController keteraganTambahan = TextEditingController();
  List<TextEditingController> beratItem = [];
  var Authorization;
  RxBool loading = true.obs;
  RxBool isEndPage = false.obs;
  RxString pesan = ''.obs;
  RxString totalPage = ''.obs;
  RxString page = ''.obs;
  ModelRiwayatJemputanDriver? modelRiwayatJemputanDriver;
  ModelDetailJemputanDriver? modelDetailJemputanDriver;
  final keyForm = GlobalKey<FormState>();
  final keyFormJemputan = GlobalKey<FormState>();
  Map<dynamic, dynamic> catatBerat = {};
  Rx<List<DataRiwayat>> dataRiwayat = Rx<List<DataRiwayat>>([]);
  ScrollController scrollController = ScrollController();

  Future daftarRiwayatOrderJemputanDriver() async {
    final respone = await http.get(
        Uri.parse(ApiUrl.daftarRiwayatJemputanDriver),
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
      pesan.value = "Token sudah kadaluarsaharap login kembali";
      loading.value = false;
    } else if (respone.statusCode == 200) {
      modelRiwayatJemputanDriver =
          modelRiwayatJemputanDriverFromJson(respone.body);
      page.value = modelRiwayatJemputanDriver!.nextpage.toString();
      totalPage.value = modelRiwayatJemputanDriver!.totalpage.toString();
      final hasil = json.decode(respone.body);
      dataRiwayat.value = List<DataRiwayat>.from(
          hasil['data'].map((x) => DataRiwayat.fromJson(x))).obs;
      print(totalPage.value);
      print(page.value);
      loading.value = false;
    } else if (respone.statusCode == 404) {
      modelRiwayatJemputanDriver =
          modelRiwayatJemputanDriverFromJson(respone.body);
      pesan.value = modelRiwayatJemputanDriver!.message;
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

  Future nextDaftarRiwayatOrderJemputanDriver(_page) async {
    isInitialized = true;
    final respone = await http.get(
        Uri.parse("${ApiUrl.daftarRiwayatJemputanDriver}/${_page}"),
        headers: {'Authorization': Authorization});
    print(
        "------------------------DATA daftar Order jemputan Sampah Driver ${_page}--------------------------");
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
      isEndPage.value = false;
    } else if (respone.statusCode == 200) {
      modelRiwayatJemputanDriver =
          modelRiwayatJemputanDriverFromJson(respone.body);
      page.value = modelRiwayatJemputanDriver!.nextpage.toString();
      totalPage.value = modelRiwayatJemputanDriver!.totalpage.toString();
      final hasil = json.decode(respone.body);
      dataRiwayat.value += List<DataRiwayat>.from(
          hasil['data'].map((x) => DataRiwayat.fromJson(x))).obs;
      isEndPage.value = false;
    } else if (respone.statusCode == 404) {
      modelRiwayatJemputanDriver =
          modelRiwayatJemputanDriverFromJson(respone.body);
      pesan.value = modelRiwayatJemputanDriver!.message;
      isEndPage.value = false;
    } else {
      pesan.value = "Server Dalam Perbaikan";
      isEndPage.value = false;
    }
  }

  Future refreshData() async {
    loading.value = true;
    dataRiwayat.value.clear();
    daftarRiwayatOrderJemputanDriver().timeout(const Duration(seconds: 30),
        onTimeout: () {
      Get.offAllNamed('/home-page');
      loading.value = false;
      isEndPage.value = false;
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
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    Authorization = GetStorage().read(STORAGE_TOKEN);
    scrollController.addListener(() async {
      print(scrollController.position.pixels);
      print("----------------------------");
      print(isEndPage.value.toString());
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("bottom Page");
        print(isEndPage.value.toString());
        print(totalPage.value.toString());
        print(page.value.toString());

        isEndPage.value = true;
        if (totalPage.value != page.value) {
          if (isInitialized == false) {
            await nextDaftarRiwayatOrderJemputanDriver(page)
                .timeout(const Duration(seconds: 30), onTimeout: () {
              pesan.value =
                  "Waktu pemanggilan berakhir, harap pastikan koneksi anda stabil";
              isEndPage.value = false;
              isInitialized = false;
            }).whenComplete(() {
              isEndPage.value = false;
              isInitialized = false;
            });
          }
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }
}
