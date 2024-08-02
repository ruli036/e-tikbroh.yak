import 'dart:convert';

import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/responJsonMutasiPoin.dart';
import 'package:e_tikbroh_yok/Server/api_server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class MutasiPointController extends GetxController {
  RxList showList = [].obs;
  var Authorization;
  ScrollController scrollController = ScrollController();
  ModelMutasiPoin? modelMutasiPoin;
  Rx<List<DataMutasi>> dataMutasi = Rx<List<DataMutasi>>([]);
  RxString totalPage = ''.obs;
  RxString page = ''.obs;
  RxString nextUrl = ''.obs;
  RxString pesan = ''.obs;
  RxBool isEndPage = false.obs;
  RxBool loading = true.obs;
  RxInt tab = 0.obs;
  Future refreshData() async {
    loading.value = true;
    getMutasi();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<ModelMutasiPoin> getMutasi() async {
    final respone = await http.get(Uri.parse(ApiUrl.getmutasipoin),
        headers: {'Authorization': Authorization});
    print("------------------------AKTIFITAS POIN--------------------------");
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
    } else if (respone.statusCode == 200) {
      final hasil = json.decode(respone.body);
      dataMutasi.value = List<DataMutasi>.from(
          hasil['data'].map((x) => DataMutasi.fromJson(x))).obs;
      modelMutasiPoin = modelMutasiPoinFromJson(respone.body);
      totalPage.value = modelMutasiPoin!.totalpage.toString();
      page.value = modelMutasiPoin!.nextpage.toString();
      nextUrl.value = modelMutasiPoin!.urlnext;
      print('berhasil');
      loading.value = false;
    } else if (respone.statusCode == 404) {
      modelMutasiPoin = modelMutasiPoinFromJson(respone.body);
      pesan.value = modelMutasiPoin!.message;
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
    return modelMutasiPoinFromJson(respone.body);
  }

  Future nextMutasiPoin(url) async {
    isInitialized = true;
    final respone = await http
        .get(Uri.parse(url), headers: {'Authorization': Authorization});
    print(
        "------------------------DATA next riwayat penukaran--------------------------");
    print(respone.statusCode);
    final hasil = json.decode(respone.body);
    print(hasil);
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
      isEndPage.value = false;
    } else if (respone.statusCode == 200) {
      modelMutasiPoin = modelMutasiPoinFromJson(respone.body);
      dataMutasi.value += List<DataMutasi>.from(
          hasil['data'].map((x) => DataMutasi.fromJson(x))).obs;
      totalPage.value = modelMutasiPoin!.totalpage.toString();
      page.value = modelMutasiPoin!.nextpage.toString();
      nextUrl.value = modelMutasiPoin!.urlnext;
      print('next berhasil');
      print(dataMutasi.value.length);
      isEndPage.value = false;
    } else {
      isEndPage.value = false;
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    Authorization = GetStorage().read(STORAGE_TOKEN);
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("bottom Page");
        print(isEndPage.value.toString());
        print(totalPage.value.toString());
        print(page.value.toString());
        isEndPage.value = true;
        if (totalPage.value != page.value) {
          if (isInitialized == false) {
            await nextMutasiPoin(nextUrl.value)
                .timeout(const Duration(seconds: 30), onTimeout: () {
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
