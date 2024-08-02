import 'dart:convert';

import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/responJsonMitra.dart';
import 'package:e_tikbroh_yok/Server/api_server.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class MitraController extends GetxController {
  RxList showList = [].obs;
  var Authorization;
  RxString nama = ''.obs;
  RxString kategori = ''.obs;
  RxString alamat = ''.obs;
  RxString kontak = ''.obs;
  RxString image = ''.obs;
  RxString deskripsi = ''.obs;
  RxString pesan = ''.obs;
  // RxList produk = [].obs;
  Rx<List<ProdukItemData>> produkdetail = Rx<List<ProdukItemData>>([]);
  Future<List<ModelDaftarMitra>> refreshData() async {
    return daftarmitra();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<List<ModelDaftarMitra>> daftarmitra() async {
    final respone = await http.get(Uri.parse(ApiUrl.daftarMitra),
        headers: {'Authorization': Authorization});
    print(
        "------------------------DATA daftar mitra--------------------------");
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
      print('berhasil');
    } else if (respone.statusCode == 404) {
      print('kosong');
      pesan.value = "Data Belum di tambahkan";
    } else {
      pesan.value = "Server sedang dalam perbaikan";
    }
    return modelDaftarMitraFromJson(respone.body);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Authorization = GetStorage().read(STORAGE_TOKEN);
  }
}
