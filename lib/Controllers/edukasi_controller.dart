import 'dart:convert';

import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/MemberJson/responJsonKategoriSampah.dart';
import 'package:e_tikbroh_yok/Json/responJsonMitra.dart';
import 'package:e_tikbroh_yok/Server/api_server.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EdukasiController extends GetxController {
  var Authorization;
  RxBool play = false.obs;
  YoutubePlayerController? videoPlayerController;
  RxBool loading = true.obs;
  RxString pesan = ''.obs;
  Rx<List<ProdukItemData>> produkdetail = Rx<List<ProdukItemData>>([]);
  ModelKategoriSampah? modelKategoriSampah;
  Future refreshData() async {
    loading.value = true;
    kategoriSampah();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<ModelKategoriSampah> kategoriSampah() async {
    final respone = await http.get(Uri.parse(ApiUrl.kategoriSampah),
        headers: {'Authorization': Authorization});
    print(
        "------------------------DATA daftar Kategori Sampah--------------------------");
    print(Authorization);
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
      loading.value = false;
      modelKategoriSampah = modelKategoriSampahFromJson(respone.body);
    } else if (respone.statusCode == 404) {
      pesan.value = "Kategori Sampah Belum Ditambahkan";
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
    return modelKategoriSampahFromJson(respone.body);
  }

  Future initializePlayerVideo(String url, title) async {
    print(url);
    String youtubeUrl = url;
    String videoId = extractVideoIdFromUrl(youtubeUrl);
    videoPlayerController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        loop: true,
        hideControls: true,
      ),
    );
    play.value = true;
    print("play.value");
    print(play.value);
    Get.to(PlayVideo());
    // Get.defaultDialog(title: title, content: PlayVideo());
  }

  closeVideo() {
    videoPlayerController!.dispose();
    Get.back();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Authorization = GetStorage().read(STORAGE_TOKEN);
  }

  @override
  void dispose() {
    videoPlayerController!.dispose();
    super.dispose();
  }
}
