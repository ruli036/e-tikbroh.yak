import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/edukasi_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/MemberJson/responJsonKategoriSampah.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class EdukasiView extends StatelessWidget {
  const EdukasiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EdukasiController());
    final edukasiC = Get.find<EdukasiController>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Katalog Sampah'),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.themeColor,
      ),
      body: RefreshIndicator(
        onRefresh: edukasiC.refreshData,
        child: Container(
            height: size(context).height,
            child: Stack(
              children: [
                CustomPaint(
                  painter: WavePainter(),
                  size: MediaQuery.of(context).size,
                ),
                FutureBuilder<ModelKategoriSampah>(
                  future: edukasiC.kategoriSampah(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(edukasiC.pesan.value),
                      );
                    } else if (!snapshot.hasData) {
                      return Container(
                        height: size(context).height,
                        width: size(context).width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const FaIcon(FontAwesomeIcons.truckPickup,
                                color: Colors.grey),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                edukasiC.pesan.value,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return ItemEdukasi();
                    }
                  },
                )
              ],
            )),
      ),
    );
  }
}

class ItemEdukasi extends StatelessWidget {
  const ItemEdukasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final edukasiC = Get.find<EdukasiController>();
    return Obx(
      () {
        final data = edukasiC.modelKategoriSampah!.kategori;
        if (edukasiC.loading.value == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView(
            children: List.generate(data.length, (index) {
              if (data.isEmpty) {
                return SizedBox(
                  height: size(context).height / 2,
                  width: size(context).width,
                  child: Text(
                    edukasiC.pesan.value,
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 2), // Offset of the shadow
                          ),
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Stack(
                      children: [
                        ListTile(
                          onTap: () {
                            final List<String> images = [];
                            data[index].katalogsampah.forEach((element) {
                              images.addAll({element.image});
                            });
                            if (data[index].katalogsampah.isNotEmpty) {
                              // edukasiC.play.value = false;
                              // edukasiC.initializePlayerVideo(
                              //     data[index].videoLink, data[index].nama);
                              Get.to(ListImagePreviewPage(
                                id: data[index].id,
                                imageUrls: images,
                              ));
                            }
                          },
                          isThreeLine: true,
                          title: Text(
                            data[index].nama,
                            style: const TextStyle(
                                color: AppColors.fontTitleColor,
                                fontFamily: objectApp.fontApp,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: SizedBox(
                            width: 70,
                            height: 70,
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              child: CachedNetworkImage(
                                alignment: Alignment.center,
                                imageUrl: data[index].image,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: ImagesLoadingIklan(
                                    scaleHeigth: 6,
                                  ),
                                ),
                                fit: BoxFit.cover,
                                width: size(context).width,
                              ),
                            ),
                          ),
                          subtitle: Text(
                            "${data[index].deskripsi.toCapitalized()}, satuan hitungan (${data[index].satuan.toCapitalized()})",
                            style: const TextStyle(
                              color: AppColors.fontColor,
                              fontFamily: objectApp.fontApp,
                              fontSize: 12,
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
          );
        }
      },
    );
  }
}
