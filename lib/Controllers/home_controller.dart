import 'dart:async';
import 'dart:convert';

import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/responJsonDashboart.dart';
import 'package:e_tikbroh_yok/Json/responJsonIklanMitra.dart';
import 'package:e_tikbroh_yok/Server/api_server.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../Helpers/constans.dart';
import '../Helpers/helpers.dart';

class HomeController extends GetxController {
  var Authorization;
  RxString email = "".obs;
  RxString nama = "".obs;
  RxString nohp = "".obs;
  RxString level = "".obs;
  RxDouble startValue = 0.0.obs;
  RxDouble endValue = 50.0.obs;
  RxString foto =
      "https://rimsdev.com/alazcamobile/assets/img/profile/default.png".obs;
  RxInt selectedIndex = 0.obs;
  String date = DateFormat('dd').format(DateTime.now());
  String month = DateFormat('MMMM').format(DateTime.now());
  String year = DateFormat('yyyy').format(DateTime.now());
  DateTime? currentBackPressTime;
  RxList idMeteran = [].obs;
  RxList imageSlider = [].obs;
  RxBool loading = true.obs;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  ModelDaftarIklan? modelDaftarIklan;
  ModelIklanMitra? modelIklanMitra;
  ModelPoinUser? modelPointDashboart;
  Future daftarIklan() async {
    try {
      final respone = await http.get(Uri.parse(ApiUrl.daftariklan),
          headers: {'Authorization': Authorization});
      print(
          "------------------------DATA daftar Iklan--------------------------");
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
      } else if (respone.statusCode == 200) {
        modelDaftarIklan = modelDaftarIklanFromJson(respone.body);
        modelDaftarIklan!.data.forEach((element) {
          imageSlider.value.addAll({element.gambar});
        });
        loading.value = false;
      } else {
        imageSlider.value.addAll({objectApp.logoApp});
        loading.value = false;
      }
    } catch (e) {
      Get.defaultDialog(
          title: "ERROR",
          barrierDismissible: true,
          content: AlertErrorCodeView(
            text: "Server Sedang Dalam Perbaikan Harap Coba Lagi Nanti  ${e}",
          ));
    }
  }

  Future<ModelIklanMitra> daftarIklanmitra() async {
    final respone = await http.get(Uri.parse(ApiUrl.daftariklanmitra),
        headers: {'Authorization': Authorization});
    print(
        "------------------------DATA daftar Iklan Mitra--------------------------");
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
    } else if (respone.statusCode == 200) {
      modelIklanMitra = modelIklanMitraFromJson(respone.body);
      loading.value = false;
    } else {
      imageSlider.value.addAll({objectApp.logoApp});
      loading.value = false;
    }

    return modelIklanMitraFromJson(respone.body);
  }

  Future getPoin() async {
    try {
      final respone = await http.get(Uri.parse(ApiUrl.getPoin),
          headers: {'Authorization': Authorization});
      print("------------------------Get Poin-------------------------");
      print(respone.statusCode);
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
      } else if (respone.statusCode == 200) {
        modelPointDashboart = modelPoinUserFromJson(respone.body);
        GetStorage()
            .write(STORAGE_POIN_USER, modelPointDashboart!.selisih.poin);
        GetStorage()
            .write(STORAGE_NOMINAL_POIN, modelPointDashboart!.selisih.rupiah);
      } else {
        Get.defaultDialog(
            title: "WARNING",
            barrierDismissible: true,
            content: AlertErrorView(
              text: hasil['message'],
              colors: Colors.yellow,
            ));
      }
    } catch (e) {
      Get.defaultDialog(
          title: "ERROR",
          barrierDismissible: true,
          content: AlertErrorCodeView(
            text: "Server Sedang Dalam Perbaikan Harap Coba Lagi Nanti  ${e}",
          ));
    }
  }

  void onItemTapped(int index) {
    print(index);
    selectedIndex.value = index;
  }

  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Row(
      children: [
        Icon(
          Icons.info,
          color: Colors.yellow.shade300,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Coming Soon!',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: objectApp.fontApp),
          ),
        ),
      ],
    ),
    backgroundColor: AppColors.themeColor,
    duration: const Duration(milliseconds: 1300),
  );

  onTapSettingMenu(index, context) {
    if (level.value == 'member') {
      if (index == 0) {
        Get.toNamed('order-jemputan');
      } else if (index == 1) {
        onItemTapped(3);
      } else if (index == 2) {
        Get.toNamed('mitra-view');
      } else if (index == 3) {
        onItemTapped(2);
      } else if (index == 4) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        onItemTapped(4);
      }
    } else {
      if (index == 0) {
        onItemTapped(1);
      } else if (index == 1) {
        Get.toNamed('mitra-view');
      } else if (index == 2) {
        onItemTapped(3);
      } else if (index == 3) {
        onItemTapped(2);
      } else if (index == 4) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        onItemTapped(4);
      }
    }
  }
  onTapSettingMenuV2(index, context) {
    if (level.value == 'member') {
      if (index == 0) {
        onItemTapped(3);
      } else if (index == 1) {
        onItemTapped(1);
      } else {
        Get.toNamed('mitra-view');
      }
    } else {
      if (index == 0) {
        onItemTapped(3);
      } else if (index == 1) {
        onItemTapped(1);
      } else {
        Get.toNamed('mitra-view');
      }
    }
  }

  Future refreshData() async {
    loading.value = true;
    getDataStorage();
    getPoin().whenComplete(() {
      daftarIklan();
    }).timeout(const Duration(seconds: 30), onTimeout: () {
      loading.value = false;
      Get.defaultDialog(
          title: "WARNING",
          barrierDismissible: false,
          content: AlertErrorView(
            text:
                "Waktu pemanggilan berakhir, harap pastikan koneksi anda stabil",
            colors: Colors.yellow,
          ),
          onConfirm: () => Get.offAllNamed('/home-page'));
    });
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<bool> onWillPop(context) async {
    if (selectedIndex.value == 0) {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          content: Row(
            children: [
              Icon(
                Icons.info,
                color: Colors.yellow.shade300,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Tekan sekali lagi untuk keluar!',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: objectApp.fontApp),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.themeColor,
          duration: const Duration(milliseconds: 1300),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return Future.value(false);
      }
      SystemNavigator.pop();
      return Future.value(true);
    } else {
      selectedIndex.value = 0;
      return Future.value(false);
    }
  }

  Future getDataStorage() async {
    Authorization = GetStorage().read(STORAGE_TOKEN);
    email.value = await GetStorage().read(STORAGE_EMAIL);
    foto.value = await GetStorage().read(STORAGE_FOTO);
    nama.value = await GetStorage().read(STORAGE_NAMA);
    nohp.value = await GetStorage().read(STORAGE_NO_HP);
    level.value = await GetStorage().read(STORAGE_STATUS_USER);
    print(idMeteran.value);
    print('======================Id Meteran Local=====================');
    print(foto.value);
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    getDataStorage();
    getPoin().whenComplete(() {
      daftarIklan();
    }).timeout(const Duration(seconds: 30), onTimeout: () {
      loading.value = false;
      Get.defaultDialog(
          title: "WARNING",
          barrierDismissible: false,
          content: AlertErrorView(
            text:
                "Waktu pemanggilan berakhir, harap pastikan koneksi anda stabil",
            colors: Colors.yellow,
          ),
          onConfirm: () => Get.offAllNamed('/home-page'));
    });
  }
}
