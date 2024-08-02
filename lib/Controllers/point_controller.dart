import 'dart:convert';

import 'package:e_tikbroh_yok/Controllers/home_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/responJsonProdukPenukaran.dart';
import 'package:e_tikbroh_yok/Json/responJsonRiwayatPenukaran.dart';
import 'package:e_tikbroh_yok/Server/api_server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PointController extends GetxController {
  final home = Get.find<HomeController>();
  RxList showList = [].obs;
  var Authorization,
      idProduk,
      username,
      foto,
      noHp,
      email,
      namaproduk,
      desc,
      poin,
      gambar,
      mitra,
      poinUser;
  RxInt initialTabIndex = 0.obs;
  ScrollController scrollController = ScrollController();
  ModelRiwayatPenukaran? modelRiwayatPenukaran;
  Rx<List<ItemRiwayat>> dataRiwayat = Rx<List<ItemRiwayat>>([]);
  RxString totalPage = ''.obs;
  RxString page = ''.obs;
  RxString nextUrl = ''.obs;
  RxString pesan = ''.obs;
  RxBool isEndPage = false.obs;
  RxBool loading = true.obs;
  RxInt tab = 0.obs;
  Future<List<ModelProdukPenukaran>> refreshData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return daftarproduk();
  }

  Future refreshDataRiwayat() async {
    loading.value = true;
    riwayat();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<List<ModelProdukPenukaran>> daftarproduk() async {
    final respone = await http.get(Uri.parse(ApiUrl.produktukarpoin),
        headers: {'Authorization': Authorization});
    print(
        "------------------------DATA daftar produk test--------------------------");
    print(respone.statusCode);

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
      print('berhasil');
      loading.value = false;
    } else if (respone.statusCode == 404) {
      print('kosong');
      pesan.value = "Data Belum di tambahkan";
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
    return modelProdukPenukaranFromJson(respone.body);
  }

  Future<ModelRiwayatPenukaran> riwayat() async {
    final respone = await http.get(Uri.parse(ApiUrl.riwayattukarpoin),
        headers: {'Authorization': Authorization});
    print(
        "------------------------DATA daftar produk--------------------------");
    print(respone.statusCode);
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
      final hasil = json.decode(respone.body);
      modelRiwayatPenukaran = modelRiwayatPenukaranFromJson(respone.body);
      dataRiwayat.value = List<ItemRiwayat>.from(
          hasil['data'].map((x) => ItemRiwayat.fromJson(x))).obs;
      totalPage.value = modelRiwayatPenukaran!.totalpage.toString();
      page.value = modelRiwayatPenukaran!.nextpage.toString();
      nextUrl.value = modelRiwayatPenukaran!.urlnext;
      print('berhasil');
      print(totalPage.value);
      print(page.value);
      loading.value = false;
    } else if (respone.statusCode == 404) {
      modelRiwayatPenukaran = modelRiwayatPenukaranFromJson(respone.body);
      print('kosong');
      pesan.value = modelRiwayatPenukaran!.message;
      loading.value = false;
    } else {
      Get.defaultDialog(
          title: "ERROR",
          barrierDismissible: true,
          content: AlertErrorCodeView(
            text: "Server Sedang Dalam Perbaikan, Harap Coba Lagi Nanti",
          ));
      pesan.value = "Server sedang dalam perbaikan";
      loading.value = false;
    }
    return modelRiwayatPenukaranFromJson(respone.body);
  }

  Future nextRiwayat(url) async {
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
    } else if (respone.statusCode == 200) {
      modelRiwayatPenukaran = modelRiwayatPenukaranFromJson(respone.body);
      dataRiwayat.value += List<ItemRiwayat>.from(
          hasil['data'].map((x) => ItemRiwayat.fromJson(x))).obs;
      totalPage.value = modelRiwayatPenukaran!.totalpage.toString();
      page.value = modelRiwayatPenukaran!.nextpage.toString();
      nextUrl.value = modelRiwayatPenukaran!.urlnext;
      print('next berhasil');
      print(dataRiwayat.value.length);
    } else {
      pesan.value = hasil['message'];
    }
    isEndPage.value = false;
  }

  tukarkanPoin() async {
    try {
      final respone = await http.post(Uri.parse(ApiUrl.tukarkanPoin),
          headers: {'Authorization': Authorization},
          body: {'tanggal': DateTime.now().toString(), 'idproduk': idProduk});
      final hasil = json.decode(respone.body);

      print('-----------------------------');
      print(hasil);
      print(respone.statusCode);
      if (respone.statusCode == 200) {
        if (hasil['status'] == true) {
          Get.back();
          Get.defaultDialog(
              title: "INFO",
              barrierDismissible: false,
              content: AlertSuccesView(
                text: hasil['message'],
                colors: Colors.green,
              ),
              textConfirm: "OK",
              onConfirm: () {
                home.getPoin().whenComplete(() {
                  getDataUser();
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

  Future validasi() async {
    Get.back();
    Get.defaultDialog(
        title: "LOADING",
        barrierDismissible: false,
        content: LoadingView(text: "Harap Tunggu..."));
    cekKoneksi(() {
      tukarkanPoin().timeout(const Duration(seconds: 30), onTimeout: () {
        Get.offAllNamed('/home-page');
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

  getDataUser() {
    Authorization = GetStorage().read(STORAGE_TOKEN);
    username = GetStorage().read(STORAGE_NAMA);
    noHp = GetStorage().read(STORAGE_NO_HP);
    email = GetStorage().read(STORAGE_EMAIL);
    foto = GetStorage().read(STORAGE_FOTO);
    poinUser = GetStorage().read(STORAGE_POIN_USER);
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    getDataUser();

    print("bui sakjdnsadnjldnla ");
    print(isEndPage.value);
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
            await nextRiwayat(nextUrl.value)
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
