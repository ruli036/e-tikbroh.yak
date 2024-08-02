import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_tikbroh_yok/Controllers/home_controller.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as path;

import '../Helpers/helpers.dart';
import '../Server/api_server.dart';

class ProfileController extends GetxController {
  TextEditingController namaUser = TextEditingController();
  TextEditingController noHp = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passwordlama = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final homeC = Get.find<HomeController>();
  RxBool lihatpass = true.obs;
  final keyform = GlobalKey<FormState>();
  final storage = GetStorage();
  var fileImage;
  void lihatpassword() {
    lihatpass.value = !lihatpass.value;
  }

  resetPasswordBaru() async {
    try {
      final respone = await http.post(Uri.parse(ApiUrl.ubahpassword), headers: {
        'Authorization': homeC.Authorization
      }, body: {
        'current': passwordlama.text,
        'newpass': password.text,
        'konfpass': confirmPassword.text,
      });
      final hasil = json.decode(respone.body);
      print('-----------------------------');
      print(hasil);
      print(respone.statusCode);
      if (respone.statusCode == 200) {
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
              GetStorage().erase();
              Get.offAllNamed("/login");
            });
      } else {
        Get.back();
        Get.defaultDialog(
            title: "ERROR",
            barrierDismissible: true,
            content: AlertErrorCodeView(
              text: hasil['message'],
            ));
      }
    } catch (e) {
      Get.back();
      Get.defaultDialog(
          title: "ERROR",
          barrierDismissible: true,
          content: AlertErrorCodeView(
            text: "Server Sedang Dalam Gangguan, Harap Coba Lagi Nanti  ${e}",
          ));
    }
  }

  Future editDataUser() async {
    try {
      final respone = await http.post(Uri.parse(ApiUrl.editUserLogin),
          headers: {
            'Authorization': homeC.Authorization
          },
          body: {
            'email': email.text,
            'nohp': noHp.text,
            'nama': namaUser.text
          });
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
          await StorageAPP.updateDataUserLogin(namaUser.text, noHp.text);
          await homeC.getDataStorage();
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

  Future uploudImage(File imageFile) async {
    try {
      print(imageFile.toString());
      var uri = Uri.parse(ApiUrl.uploudFotoProfile);
      var steam = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var request = http.MultipartRequest("POST", uri);
      var multipartFile = http.MultipartFile("image", steam, length,
          filename: path.basename(imageFile.path));

      request.headers['Authorization'] = homeC.Authorization;
      request.files.add(multipartFile);
      var response = await request.send();
      final respon = await response.stream.bytesToString();
      final hasil = json.decode(respon);
      print(hasil);
      // timeOut();
      bool error = hasil['status'] ?? false;
      String pesan = hasil["message"] ?? "-";
      if (response.statusCode == 401) {
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
      } else if (error != true) {
        Get.back();
        Get.defaultDialog(
            title: "WARNING",
            barrierDismissible: true,
            content: AlertErrorView(
              text: pesan,
              colors: Colors.yellow,
            ));
      } else {
        Get.back();
        StorageAPP.updateFotoProfile(hasil['foto']);
        homeC.getDataStorage();
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

  editImage() {
    Get.defaultDialog(
      title: "Ambil Foto",
      barrierDismissible: true,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () async {
                Get.back();
                fileImage =
                    await getImagefromCamera([CropAspectRatioPreset.square])
                        .then((value) {
                  print("FOTO HASIL");
                  print(value);
                  if (value != null) {
                    Get.defaultDialog(
                        title: "LOADING",
                        barrierDismissible: false,
                        content: LoadingView(text: "Harap Tunggu..."));
                    cekKoneksi(() {
                      uploudImage(value).timeout(const Duration(seconds: 30),
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
                });
              },
              icon: FaIcon(
                FontAwesomeIcons.camera,
                size: 35,
                color: Colors.grey.shade500,
              )),
          IconButton(
              onPressed: () async {
                Get.back();
                fileImage =
                    await getImagefromgalery([CropAspectRatioPreset.square])
                        .then((value) {
                  print("FOTO HASIL");
                  print(value);
                  if (value != null) {
                    Get.defaultDialog(
                        title: "LOADING",
                        barrierDismissible: false,
                        content: LoadingView(text: "Harap Tunggu..."));
                    cekKoneksi(() {
                      uploudImage(value).timeout(const Duration(seconds: 30),
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
                });
              },
              icon: FaIcon(FontAwesomeIcons.solidImage,
                  size: 35, color: Colors.grey.shade500))
        ],
      ),
      textCancel: "Batal",
      confirmTextColor: AppColors.textColor,
    );
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
        Get.defaultDialog(
            title: "LOADING",
            barrierDismissible: false,
            content: LoadingView(text: "Harap Tunggu..."));
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
      }
    }
  }

  validasiEditUser() {
    final form = keyform.currentState;
    if (form!.validate()) {
      Get.defaultDialog(
          title: "LOADING",
          barrierDismissible: false,
          content: LoadingView(text: "Harap Tunggu..."));
      cekKoneksi(() {
        editDataUser().timeout(const Duration(seconds: 30), onTimeout: () {
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

  onTapSettingMenu(index) {
    if (homeC.level.value == 'member') {
      if (index == 0) {
        homeC.onItemTapped(1);
      } else if (index == 1) {
        homeC.onItemTapped(3);
      } else if (index == 2) {
        cekKoneksi(() => Get.toNamed('mitra-view'));
      } else if (index == 3) {
        homeC.onItemTapped(2);
      } else if (index == 4) {
        cekKoneksi(() => Get.toNamed('/lokasi-jemputan'));
      } else if (index == 5) {
        editImage();
      } else {
        Get.toNamed('/ganti-pass-page', arguments: true);
      }
    } else {
      if (index == 0) {
        homeC.onItemTapped(1);
      } else if (index == 1) {
        homeC.onItemTapped(3);
      } else if (index == 2) {
        homeC.onItemTapped(2);
      } else if (index == 3) {
        Get.toNamed('mitra-view');
      } else if (index == 4) {
        editImage();
      } else {
        Get.toNamed('/ganti-pass-page', arguments: true);
      }
    }
  }
}
