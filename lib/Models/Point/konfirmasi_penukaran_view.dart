import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/point_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class KonfirmasiPenukaranPoin extends StatelessWidget {
  const KonfirmasiPenukaranPoin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pointC = Get.find<PointController>();
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        title: const Text('Konfirmasi Penukaran Poin',style: TextStyle(
            color: AppColors.titleText, fontFamily: objectApp.fontApp),),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              int.parse(pointC.poinUser.toString()) <
                      int.parse(pointC.poin.toString())
                  ? Container(
                      height: 70,
                      width: size(context).width,
                      decoration:const BoxDecoration(
                          color: AppColors.color2,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow:  [
                            BoxShadow(
                                color: Colors.black45,
                                blurRadius: 4,
                                spreadRadius: 0.1,
                                offset: Offset(0, 1))
                          ]),
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: FaIcon(
                              FontAwesomeIcons.circleExclamation,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          Expanded(
                              child: Text(
                                  "Poin anda tidak mecukupi untuk ditukar dengan produk ini!",
                                  style: TextStyle(
                                      fontFamily: objectApp.fontApp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14))),
                        ],
                      ),
                    )
                  : Container(),
              Padding(
                  padding: EdgeInsets.all(
                      int.parse(pointC.poinUser.toString()) <
                              int.parse(pointC.poin.toString())
                          ? 8
                          : 0)),
              Container(
                width: size(context).width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration:const BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              color: AppColors.themeColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${pointC.poinUser} Poin',
                              style: const TextStyle(
                                color: AppColors.white,
                                fontFamily: objectApp.fontApp,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(
                              "Data Diri",
                              style: TextStyle(
                                  fontFamily: objectApp.fontApp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.blackColor,
                                  fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    '${pointC.username.toString().toCapitalized()}',
                                    style: const TextStyle(
                                        // fontFamily: objectApp.fontApp,
                                        // fontWeight: FontWeight.bold,
                                        // color: AppColors.fontColor,
                                        fontSize: 14),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    pointC.noHp,
                                    style: const TextStyle(
                                        // fontFamily: objectApp.fontApp,
                                        // fontWeight: FontWeight.bold,
                                        // color: AppColors.fontColor,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        top: 25,
                        child: Container(
                          decoration:const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: AppColors.themeColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${pointC.poin} Poin',
                              style: const TextStyle(
                                color: AppColors.white,
                                fontFamily: objectApp.fontApp,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(
                              "Tukarkan poin anda dengan produk ini? ",
                              style: TextStyle(
                                  fontFamily: objectApp.fontApp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.blackColor,
                                  fontSize: 15),
                            ),
                          ),
                          // Divider(
                          //   color: AppColors.blackColor.withOpacity(0.5),
                          // ),
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: CachedNetworkImage(
                                alignment: Alignment.center,
                                imageUrl: pointC.gambar,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: ImagesLoading(
                                    height: 54,
                                    width: 60,
                                  ),
                                ),
                                width: size(context).width / 2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    '${pointC.namaproduk} (${pointC.mitra})',
                                    style: const TextStyle(
                                        fontFamily: objectApp.fontApp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.titleText,
                                        fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    pointC.desc,
                                    style: const TextStyle(
                                        // fontFamily: objectApp.fontApp,
                                        // fontWeight: FontWeight.bold,
                                        color: AppColors.titleText,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
      int.parse(pointC.poinUser.toString()) <
              int.parse(pointC.poin.toString())
          ? null
          :
      Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        width: size(context).width / 2 - 20,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              color: AppColors.themeColor, width: 3),
                        ),
                        child: const Center(
                          child: Text(
                            'Batal',
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: objectApp.fontApp,
                            ),
                          ),
                        ),
                      )),
                  InkWell(
                      onTap: () {
                        Get.defaultDialog(
                            title: "INFO",
                            barrierDismissible: true,
                            content: AlertErrorView(
                              text:
                                  "Anda akan menukarkan poin anda dengan produk ini?",
                              colors: Colors.yellow,
                            ),
                            textConfirm: "Tukar",
                            confirmTextColor: Colors.white,
                            onConfirm: () {
                              pointC.validasi();
                            });
                      },
                      child: Container(
                        width: size(context).width / 2 - 20,
                        height: 40,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: AppColors.themeColor),
                        child: const Center(
                          child: Text(
                            'Tukarkan Poin',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: objectApp.fontApp,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
    );
  }
}
