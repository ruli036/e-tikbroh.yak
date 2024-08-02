import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/point_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/responJsonProdukPenukaran.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DaftarPenukaranPointView extends StatelessWidget {
  const DaftarPenukaranPointView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PointController());
    final pointC = Get.find<PointController>();
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: pointC.refreshData,
          child: Container(
              height: size(context).height,
              child: Stack(
                children: [
                  CustomPaint(
                    painter: WavePainter(),
                    size: MediaQuery.of(context).size,
                  ),
                  FutureBuilder<List<ModelProdukPenukaran>>(
                    future: pointC.daftarproduk(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                                const FaIcon(FontAwesomeIcons.box,
                                    color: Colors.grey),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    pointC.pesan.value,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          return ListPointView(data: data);
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
        ),
      ),
    );
  }
}

class ListPointView extends StatelessWidget {
  List<ModelProdukPenukaran> data;
  ListPointView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pointC = Get.find<PointController>();
    return Obx(() {
      if (pointC.loading.value == true) {
        return Container(
            child: const Center(
          child: CircularProgressIndicator(),
        ));
      } else if (data.isEmpty) {
        return Container(
          height: size(context).height,
          width: size(context).width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const FaIcon(FontAwesomeIcons.box, color: Colors.grey),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  pointC.pesan.value,
                  style: const TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        );
      } else {
        return ListView(
          children: List.generate(data.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
              child: InkWell(
                onTap: () {
                  pointC.poin = data[index].poin;
                  pointC.mitra = data[index].namaMitra;
                  pointC.namaproduk = data[index].namaProduk;
                  pointC.desc = data[index].deskripsi;
                  pointC.gambar = data[index].image;
                  pointC.idProduk = data[index].id;
                  Get.toNamed('konfirmasi-penukara-poin');
                },
                child: Container(
                    height: 80,
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Stack(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ListTile(
                          contentPadding:
                              const EdgeInsets.only(top: 5, left: 15),
                          title: Text(
                            '${data[index].namaProduk}',
                            style: const TextStyle(
                              color: AppColors.fontTitleColor,
                              fontFamily: objectApp.fontApp,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '${data[index].namaMitra}',
                                      style: const TextStyle(
                                        color: AppColors.fontColor,
                                        fontFamily: objectApp.fontApp,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  data[index].deskripsi,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppColors.fontColor,
                                    fontFamily: objectApp.fontApp,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          leading: Container(
                            width: 50,
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
                                width: size(context).width / 4,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.green.shade300),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${data[index].poin} Poin',
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
        );
      }
    });
  }
}
