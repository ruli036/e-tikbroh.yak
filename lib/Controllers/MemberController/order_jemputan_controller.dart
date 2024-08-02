import 'dart:convert';
import 'dart:io';

import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/MemberJson/responJsonDaftarLokasi.dart';
import 'package:e_tikbroh_yok/Json/MemberJson/responJsonDaftarOrderJemputan.dart';
import 'package:e_tikbroh_yok/Json/MemberJson/responJsonDetailJemputan.dart';
import 'package:e_tikbroh_yok/Json/MemberJson/responJsonKategoriSampah.dart';
import 'package:e_tikbroh_yok/Server/api_server.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as path;

class OrderJemputanController extends GetxController {
  TextEditingController keteranganTambahan = TextEditingController();
  RxString namaLokasiJemputan = 'Nama Lokasi'.obs;
  RxString alamatLokasiJemputan = 'Alamat Lokasi'.obs;
  RxMap<dynamic, dynamic> KategoriSampah = {}.obs;
  Rx<List<ItemLokasiChace>> itemLokasiJemputan = Rx<List<ItemLokasiChace>>([]);
  var idTitikJemputan, Authorization, foto;
  RxBool loading = true.obs;
  RxBool loadingkategori = true.obs;
  RxBool isEndPage = false.obs;
  RxString pesan = ''.obs;
  ModelKategoriSampah? modelKategoriSampah;
  ModelDaftarOrderJemputan? modelDaftarOrderJemputan;
  ModelDetailJemputan? modelDetailJemputan;
  RxList switchValues = [].obs;
  Rx<List<ItemOrder>> dataOrder = Rx<List<ItemOrder>>([]);
  ScrollController scrollController = ScrollController();
  RxString totalPage = ''.obs;
  RxString page = ''.obs;

  final keyform = GlobalKey<FormState>();

  pilihAction(String choice) async {
    if (choice == SettingOrderLokasi.pilihLokasi) {
      Get.bottomSheet(
        DaftarLokasiJemputanChace(),
      );
    } else if (choice == SettingOrderLokasi.tambahLokasi) {
      Get.toNamed("tambah-lokasi-baru");
    }
  }

  onChange(index) {
    loadingkategori.value = true;
    switchValues.value[index] = !switchValues.value[index];
    loadingkategori.value = false;
  }

  onTap(index, idkategori) {
    if (switchValues.value[index] == true) {
      KategoriSampah.value.addAll({'datakategori[${index}]': idkategori});
    } else {
      KategoriSampah.value.remove('datakategori[${index}]');
    }
    print(switchValues.value);
    print(KategoriSampah.value);
  }

  Future kategoriSampah() async {
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

  Future daftarOrderJemputan() async {
    final respone = await http.get(Uri.parse(ApiUrl.daftarOrderJemputan),
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
      modelDaftarOrderJemputan = modelDaftarOrderJemputanFromJson(respone.body);
      page.value = modelDaftarOrderJemputan!.nextpage.toString();
      totalPage.value = modelDaftarOrderJemputan!.totalpage.toString();

      final hasil = json.decode(respone.body);
      dataOrder.value =
          List<ItemOrder>.from(hasil['data'].map((x) => ItemOrder.fromJson(x)))
              .obs;
      loading.value = false;
      print('berhasil');
    } else if (respone.statusCode == 404) {
      modelDaftarOrderJemputan = modelDaftarOrderJemputanFromJson(respone.body);
      pesan.value = modelDaftarOrderJemputan!.message;
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

  Future nextDaftarOrderJemputan(_page) async {
    isInitialized = true;
    final respone = await http.get(
        Uri.parse("${ApiUrl.daftarOrderJemputan}/${_page}"),
        headers: {'Authorization': Authorization});
    print(
        "------------------------DATA daftar Order jemputan Sampah Driver ${_page}--------------------------");
    print(respone.statusCode);
    print(json.decode(respone.body));
    modelDaftarOrderJemputan = modelDaftarOrderJemputanFromJson(respone.body);
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
      page.value = modelDaftarOrderJemputan!.nextpage.toString();
      totalPage.value = modelDaftarOrderJemputan!.totalpage.toString();
      final hasil = json.decode(respone.body);
      dataOrder.value +=
          List<ItemOrder>.from(hasil['data'].map((x) => ItemOrder.fromJson(x)))
              .obs;
      isEndPage.value = false;
    } else if (respone.statusCode == 404) {
      pesan.value = "Belum ada pengajuan penjemputan sampah";
      isEndPage.value = false;
    } else {
      pesan.value = "Server Dalam Perbaikan";
      isEndPage.value = false;
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
          daftarOrderJemputan().whenComplete(() {
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

  Future refreshData() async {
    loading.value = true;
    dataOrder.value.clear();
    daftarOrderJemputan().then((value) {
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

  Future tambahOrderJemputan(File imageFile) async {
    try {
      print(imageFile.toString());
      var uri = Uri.parse(ApiUrl.tambahOrderJemputan);
      var steam = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var request = http.MultipartRequest("POST", uri);
      var multipartFile = http.MultipartFile("image", steam, length,
          filename: path.basename(imageFile.path));

      request.headers['Authorization'] = Authorization;
      request.fields['titikjemput'] = idTitikJemputan;
      request.fields['keterangan'] = keteranganTambahan.text;
      KategoriSampah.value.forEach((key, value) {
        request.fields[key] = value;
      });
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
        daftarOrderJemputan().whenComplete(() {
          Get.back();
          Get.back();
          loading.value = true;
          namaLokasiJemputan.value = 'Nama Lokasi';
          alamatLokasiJemputan.value = 'Alamat Lokasi';
          KategoriSampah.value.clear();
          keteranganTambahan.clear();
          switchValues.value.clear();
          modelKategoriSampah!.kategori.forEach((element) {
            switchValues.value.addAll({false});
          });
          foto == null;
          changeImg.value++;
          loading.value = false;
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
        }).timeout(const Duration(seconds: 30), onTimeout: () {
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
      if (idTitikJemputan == null) {
        if (Get.isSnackbarOpen != true) {
          Get.snackbar("Info", 'Tentukan lokasi penjemputan',
              icon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: FaIcon(
                  FontAwesomeIcons.locationDot,
                  color: AppColors.iconColor1,
                ),
              ),
              backgroundColor: Colors.white);
        }
      } else if (foto == null) {
        if (Get.isSnackbarOpen != true) {
          Get.snackbar("Info", 'Harap Sertakan Foto Barang',
              icon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: FaIcon(
                  FontAwesomeIcons.images,
                  color: AppColors.iconColor1,
                ),
              ),
              backgroundColor: Colors.white);
        }
      } else if (KategoriSampah.value.isEmpty == true) {
        if (Get.isSnackbarOpen != true) {
          Get.snackbar("Info", 'Harap Pilih Jenis Barang',
              icon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: FaIcon(
                  FontAwesomeIcons.sitemap,
                  color: AppColors.iconColor1,
                ),
              ),
              backgroundColor: Colors.white);
        }
      } else {
        Get.defaultDialog(
            title: "LOADING",
            barrierDismissible: false,
            content: LoadingView(text: "Harap Tunggu..."));
        tambahOrderJemputan(foto).timeout(const Duration(seconds: 30),
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

    for (var element in itemLokasiJemputan.value) {
      print(element.namaTempat);
    }
    daftarOrderJemputan().then((value) {
      kategoriSampah();
    }).timeout(const Duration(seconds: 30), onTimeout: () {
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

    itemLokasiJemputan.value = List<ItemLokasiChace>.from(GetStorage()
        .read(STORAGE_DATA_LOKASI)
        .map((x) => ItemLokasiChace.fromJson(x))).obs;
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("bottom Page");
        print(isEndPage.value.toString());

        isEndPage.value = true;
        if (totalPage.value != page.value && isEndPage.value == true) {
          if (isInitialized == false) {
            await nextDaftarOrderJemputan(page)
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
