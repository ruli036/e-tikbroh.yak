import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/mitra_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/responJsonMitra.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DaftarMitraView extends StatelessWidget {
  const DaftarMitraView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mitraC = Get.find<MitraController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: const Text("Daftar Mitra "),
      ),
      body: RefreshIndicator(
          onRefresh: mitraC.refreshData,
          child: SafeArea(
            child: Container(
                height: size(context).height,
                child: Stack(
                  children: [
                    CustomPaint(
                      painter: WavePainter(),
                      size: MediaQuery.of(context).size,
                    ),
                    FutureBuilder<List<ModelDaftarMitra>>(
                      future: mitraC.daftarmitra(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                              child: const Center(
                            child: CircularProgressIndicator(),
                          ));
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          final data = snapshot.data;
                          if (data == null) {
                            return Container(
                              height: size(context).height,
                              width: size(context).width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const FaIcon(FontAwesomeIcons.store,
                                      color: Colors.grey),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      mitraC.pesan.value,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                            );
                          } else {
                            return ListMitraView(data: data);
                          }
                        } else {
                          return Center(
                            child: Text('Error occurred: ${snapshot.error}'),
                          );
                        }
                      },
                    ),
                  ],
                )),
          )),
    );
  }
}

class ListMitraView extends StatelessWidget {
  List<ModelDaftarMitra> data;
  ListMitraView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mitraC = Get.find<MitraController>();
    return ListView(
      children: List.generate(data.length, (index) {
        return Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          child: InkWell(
            onTap: () {
              mitraC.nama.value = data[index].nama;
              mitraC.alamat.value = data[index].alamat;
              mitraC.kontak.value = data[index].kontak;
              mitraC.deskripsi.value = data[index].deskripsi;
              mitraC.image.value = data[index].image;
              mitraC.kategori.value = data[index].kategori;
              mitraC.produkdetail.value = List<ProdukItemData>.from(data[index]
                  .produk
                  .map((x) => ProdukItemData.fromJson(
                      jsonDecode(jsonEncode(x.toJson()))))).obs;
              Get.toNamed('detail-mitra-view');
            },
            child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 2), // Offset of the shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 15, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${data[index].nama}',
                                  style: const TextStyle(
                                    color: AppColors.fontTitleColor,
                                    fontFamily: objectApp.fontApp,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  '${data[index].kategori.toUpperCase()}',
                                  style: const TextStyle(
                                    color: AppColors.fontColor,
                                    fontFamily: objectApp.fontApp,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),

                            // Divider(),
                            Text(
                              'Kontak ${data[index].kontak}',
                              style: const TextStyle(
                                color: AppColors.fontColor,
                                fontFamily: objectApp.fontApp,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Alamat ${data[index].alamat}',
                              style: const TextStyle(
                                color: AppColors.fontColor,
                                fontFamily: objectApp.fontApp,
                                fontSize: 12,
                              ),
                            ),
                            Divider(),
                            Text(
                              data[index].deskripsi,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                color: AppColors.fontColor,
                                fontFamily: objectApp.fontApp,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: CachedNetworkImage(
                          alignment: Alignment.center,
                          imageUrl: data[index].image,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: ImagesLoading(
                              height: 54,
                              width: 60,
                            ),
                          ),
                          fit: BoxFit.contain,
                          width: size(context).width / 5,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        );
      }),
    );
  }
}
