import 'dart:convert';

import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/MemberJson/model_market_place.dart';
import 'package:e_tikbroh_yok/Json/model_order_product.dart';
import 'package:e_tikbroh_yok/Server/api_server.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class MarketPlaceController extends GetxController {
  RxBool loading = true.obs;
  RxString pesan = ''.obs;
  String authorization = '';
  Rx<ModelListDataMarketPlace?> dataMarketPlace = Rx<ModelListDataMarketPlace?>(null);
  RxList<ItemData> listData= <ItemData>[].obs;
  RxString searchQuery = ''.obs;
  ScrollController scrollController = ScrollController();
  RxString selectedImage = ''.obs;
  Rx<ItemData> item = ItemData().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    authorization = GetStorage().read(STORAGE_TOKEN);
    debounce(searchQuery, (String value) {
      getDataMarketPlace(search: value);
    }, time: Duration(milliseconds: 500));
    getDataMarketPlace();
    scrollController.addListener((){
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent && dataMarketPlace.value!.totalpage != dataMarketPlace.value!.nextpage ){
        getDataMarketPlace(page: dataMarketPlace.value!.nextpage.toString());
      }
    });
  }

  Future<void> getDataMarketPlace({String search = "",String page=""}) async {
    loading.value = page ==""?true:false;
    final response = await http.post(Uri.parse("${ApiUrl.marketProducts}/$page"),
        headers: {'Authorization': authorization}, body: {'search': search});

    if (response.statusCode == 401) {
      Get.defaultDialog(
        title: "INFO",
        barrierDismissible: true,
        content: AlertUpdateApp(text: "Sesi Login Berakhir"),
        confirmTextColor: AppColors.textColor,
        textConfirm: "Ok",
        onConfirm: () {
          GetStorage().erase();
          Get.offAllNamed("/login");
        },
      );
      pesan.value = "Token sudah kadaluarsa, harap login kembali";
    } else if (response.statusCode == 200) {
      dataMarketPlace.value = modelListDataMarketPlace(response.body);
      listData.addAll(dataMarketPlace.value?.data??[]);
    } else if (response.statusCode == 404) {
      pesan.value = "Data Belum Ditambahkan";
      dataMarketPlace.value = null;
    } else {
      Get.defaultDialog(
        title: "ERROR",
        barrierDismissible: true,
        content: AlertErrorCodeView(
          text: "Server Sedang Dalam Perbaikan, Harap Coba Lagi Nanti",
        ),
      );
      pesan.value = "Server Dalam Perbaikan";
      dataMarketPlace.value = null;
    }

    loading.value = false;
  }

  Future<void> orderProduct({String idProduk = ""}) async {
    Get.defaultDialog(
      title: "Loading",
      barrierDismissible: true,
      content: LoadingView(text: "Pesanan sedang di muat"),
      confirmTextColor: AppColors.textColor,
    );
    try{
      final response = await http.post(Uri.parse(ApiUrl.orderProducts),
          headers: {'Authorization': authorization}, body: {'idproduk': idProduk});

      if (response.statusCode == 401) {
        Get.back();
        Get.defaultDialog(
          title: "INFO",
          barrierDismissible: true,
          content: AlertUpdateApp(text: "Sesi Login Berakhir"),
          confirmTextColor: AppColors.textColor,
          textConfirm: "Ok",
          onConfirm: () {
            GetStorage().erase();
            Get.offAllNamed("/login");
          },
        );
      } else if (response.statusCode == 200) {
        Get.back();
        ModelOrderProduct modelOrderProduct = ModelOrderProduct.fromJson(jsonDecode(response.body));
        kirimPesanWhatsApp(
          nomorAdmin: modelOrderProduct.data?.waAdmin??"",
          kodePesanan: modelOrderProduct.data?.kode??"",
          namaPemesan: modelOrderProduct.data?.namaPemesan??"",
          produk: modelOrderProduct.data?.produk??"",
        );
      } else {
        Get.back();
        Get.defaultDialog(
          title: "ERROR",
          barrierDismissible: true,
          content: AlertErrorCodeView(
            text: "Server Sedang Dalam Perbaikan, Harap Coba Lagi Nanti",
          ),
        );
      }
    }catch(e){
      Get.back();
      Get.defaultDialog(
        title: "ERROR",
        barrierDismissible: true,
        content: AlertErrorCodeView(
          text: e.toString(),
        ),
      );
    }

  }

}
