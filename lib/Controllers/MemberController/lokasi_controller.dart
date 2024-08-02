import 'dart:convert';
import 'dart:io';

import 'package:e_tikbroh_yok/Controllers/MemberController/order_jemputan_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/MemberJson/responJsonDaftarLokasi.dart';
import 'package:e_tikbroh_yok/Server/api_server.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as path;

class LokasiController extends GetxController {
  TextEditingController namaTempat = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController detailTempat = TextEditingController();
  RxBool loading = true.obs;
  RxString pesan = ''.obs;
  var foto, Authorization;

  final keyform = GlobalKey<FormState>();
  final orderJemputanC = Get.find<OrderJemputanController>();
  ModelDaftarLokasiJemputan? daftarLokasiJemputan;

  Future daftarLokasi() async {
    loading.value = true;
    print(loading.value);
    final respone = await http.get(Uri.parse(ApiUrl.daftarTitikJemputan),
        headers: {'Authorization': Authorization});
    print(
        "------------------------DATA daftar lokasi jemputan--------------------------");
    print(respone.statusCode);
    print(json.decode(respone.body));
    daftarLokasiJemputan = modelDaftarLokasiJemputanFromJson(respone.body);

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
      final hasil = json.decode(respone.body);
      if (hasil['status'] == true) {
        await StorageAPP.updateDataLokasi(hasil['data']);
        orderJemputanC.itemLokasiJemputan.value = List<ItemLokasiChace>.from(
            GetStorage()
                .read(STORAGE_DATA_LOKASI)
                .map((x) => ItemLokasiChace.fromJson(x))).obs;
        loading.value = false;
      } else {
        await StorageAPP.updateDataLokasi(hasil['data']);
        orderJemputanC.itemLokasiJemputan.value = List<ItemLokasiChace>.from(
            GetStorage()
                .read(STORAGE_DATA_LOKASI)
                .map((x) => ItemLokasiChace.fromJson(x))).obs;
        pesan.value = "Lokasi Jemputan Belum Ditambahkan";
        loading.value = false;
      }
    } else if (respone.statusCode == 404) {
      pesan.value = "Lokasi Jemputan Belum Ditambahkan";
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

  Future refreshData() async {
    daftarLokasi().timeout(const Duration(seconds: 30), onTimeout: () {
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
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future removeLokasi(id) async {
    final respone = await http.delete(
        Uri.parse("${ApiUrl.hapusTitikJemputan}/${id}"),
        headers: {'Authorization': Authorization});
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
      final hasil = json.decode(respone.body);
      if (hasil['status'] == true) {
        daftarLokasi().whenComplete(() {
          loading.value = false;
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
              });
        });
      } else {
        pesan.value = "Lokasi Jemputan Belum Ditambahkan";
        loading.value = false;
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
  }

  pilihAction(String choice, id, traking, nametempat) async {
    if (choice == Setting.openMap) {
      openMap(traking);
    } else if (choice == Setting.hapus) {
      whenDelete(id, nametempat);
    }
  }

  Future whenDelete(id, nama) async {
    Get.defaultDialog(
        title: "INFO",
        barrierDismissible: true,
        content: KonfirmasiDelete(
          text: "Hapus $nama Dari Daftar \nLokasi Jemputan?",
        ),
        textConfirm: "Delete",
        textCancel: "Close",
        buttonColor: AppColors.deleteButtonColor,
        onConfirm: () {
          loading.value = true;
          Get.back();
          Get.defaultDialog(
              title: "Loading",
              barrierDismissible: false,
              content: LoadingView(text: "Harap Tunggu..."));
          cekKoneksi(() {
            removeLokasi(id).timeout(const Duration(seconds: 30),
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
        });
  }

  ambilFoto() async {
    Get.defaultDialog(
      title: "Ambil Foto",
      barrierDismissible: true,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () async {
                Get.back();
                foto = await getImagefromCamera([
                  CropAspectRatioPreset.ratio16x9,
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2
                ]).whenComplete(() {
                  changeImg.value++;
                  print(foto);
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
                foto = await getImagefromgalery([
                  CropAspectRatioPreset.ratio16x9,
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2
                ]).whenComplete(() {
                  changeImg.value++;
                  print(foto);
                });
              },
              icon: FaIcon(FontAwesomeIcons.fileImage,
                  size: 35, color: Colors.grey.shade500))
        ],
      ),
      textCancel: "Batal",
      confirmTextColor: AppColors.textColor,
    );
  }

  Future tambahLokasiJemputan(File imageFile) async {
    loading.value = true;
    try {
      print(imageFile.toString());
      var uri = Uri.parse(ApiUrl.tambahTitikJemputan);
      var steam = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var request = http.MultipartRequest("POST", uri);
      var multipartFile = http.MultipartFile("image", steam, length,
          filename: path.basename(imageFile.path));

      request.headers['Authorization'] = Authorization;
      request.fields['namatempat'] = namaTempat.text;
      request.fields['alamat'] = alamat.text;
      request.fields['koordinat'] = koordinat.text;
      request.fields['detailtempat'] = detailTempat.text;
      request.files.add(multipartFile);
      var response = await request.send();
      final respon = await response.stream.bytesToString();
      final hasil = json.decode(respon);
      print(hasil);
      // timeOut();
      bool error = hasil['status'] ?? false;
      String pesan = hasil["message"] ?? "-";
      if (response.statusCode == 401) {
        loading.value = false;
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
        loading.value = false;
        Get.back();
        Get.defaultDialog(
            title: "WARNING",
            barrierDismissible: true,
            content: AlertErrorView(
              text: pesan,
              colors: Colors.yellow,
            ));
      } else {
        daftarLokasi().whenComplete(() {
          loading.value = false;
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

  validasi() {
    final form = keyform.currentState;
    if (form!.validate()) {
      if (foto == null) {
        if (Get.isSnackbarOpen != true) {
          Get.snackbar("Info", 'Wajib Sertakan Foto Lokasi ',
              icon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: FaIcon(
                  FontAwesomeIcons.image,
                  color: AppColors.iconColor1,
                ),
              ),
              backgroundColor: Colors.white);
        }
      } else if (koordinat.text == '') {
        Get.snackbar("Info", 'Tektukan Koordinat tempat jemputan ',
            icon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: FaIcon(
                FontAwesomeIcons.locationPinLock,
                color: AppColors.iconColor1,
              ),
            ),
            backgroundColor: Colors.white);
      } else {
        Get.defaultDialog(
            title: "LOADING",
            barrierDismissible: false,
            content: LoadingView(text: "Harap Tunggu..."));
        tambahLokasiJemputan(foto).timeout(const Duration(seconds: 30),
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
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    Authorization = await GetStorage().read(STORAGE_TOKEN);
    daftarLokasi().timeout(const Duration(seconds: 30), onTimeout: () {
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
