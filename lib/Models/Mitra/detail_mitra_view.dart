import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/mitra_controller.dart';
import 'package:e_tikbroh_yok/Controllers/point_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DetailMitraView extends StatelessWidget {
  const DetailMitraView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mitraC = Get.find<MitraController>();
    return Scaffold(
      backgroundColor: AppColors.themeColor,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 142,
                child: ListView(
                  children: [
                    Text(
                      '${mitraC.nama.value}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: objectApp.fontApp,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        mitraC.deskripsi.value,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: AppColors.textColor,
                          fontFamily: objectApp.fontApp,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Align(
                alignment: Alignment.bottomCenter, child: KatalogMitra())
          ],
        ),
      ),
    );
  }
}

class KatalogMitra extends StatelessWidget {
  const KatalogMitra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mitraC = Get.find<MitraController>();
    final pointC = Get.find<PointController>();
    return Container(
      height: size(context).height - 200,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 10),
            child: Text(
              'Katalog ${mitraC.nama.value}',
              style: const TextStyle(
                color: AppColors.fontTitleColor,
                fontFamily: objectApp.fontApp,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Divider(
              color: Colors.grey.withOpacity(0.5),
              thickness: 1,
            ),
          ),
          Expanded(
              child: mitraC.produkdetail.value.isEmpty
                  ? Container(
                      width: size(context).width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          FaIcon(FontAwesomeIcons.box, color: Colors.grey),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Daftar Produk Kosong',
                              style: const TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    )
                  : GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(mitraC.produkdetail.value.length,
                          (index) {
                        final data = mitraC.produkdetail.value;
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 15),
                          child: InkWell(
                            onTap: () {
                              pointC.poin = data[index].poin;
                              pointC.mitra = mitraC.nama.value;
                              pointC.namaproduk = data[index].namaProduk;
                              pointC.desc = data[index].deskripsi;
                              pointC.gambar = data[index].image;
                              pointC.idProduk = data[index].id;
                              Get.toNamed('konfirmasi-penukara-poin');
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(
                                            0, 2), // Offset of the shadow
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(22),
                                            child: CachedNetworkImage(
                                              alignment: Alignment.center,
                                              imageUrl: mitraC.produkdetail
                                                  .value[index].image,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      Center(
                                                child: ImagesLoading(
                                                  height: 54,
                                                  width: 60,
                                                ),
                                              ),
                                              fit: BoxFit.contain,
                                              width: size(context).width / 3.5,
                                            ),
                                          ),
                                          Text(
                                            "${mitraC.produkdetail.value[index].namaProduk}",
                                            style: const TextStyle(
                                              color: AppColors.fontTitleColor,
                                              fontFamily: objectApp.fontApp,
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            mitraC.produkdetail.value[index]
                                                .deskripsi,
                                            textAlign: TextAlign.center,
                                            maxLines: 5,
                                            style: const TextStyle(
                                              color: AppColors.fontColor,
                                              fontFamily: objectApp.fontApp,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                            color: Colors.green.shade300),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${mitraC.produkdetail.value[index].poin}',
                                            style: const TextStyle(
                                              color: AppColors.textColor,
                                              fontFamily: objectApp.fontApp,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      }),
                    ))
        ],
      ),
    );
  }
}
