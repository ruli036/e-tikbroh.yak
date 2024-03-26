import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/point_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/responJsonRiwayatPenukaran.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class RiwayatPenukaranPointView extends StatelessWidget {
  const RiwayatPenukaranPointView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pointC = Get.find<PointController>();
    pointC.isEndPage.value = false;
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: size(context).height,
            child: FutureBuilder<ModelRiwayatPenukaran>(
              future: pointC.riwayat(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      child: const Center(
                    child: CircularProgressIndicator(),
                  ));
                } else if (snapshot.connectionState ==
                    ConnectionState.done) {
                  return RiwayatPenukaranView();
                } else {
                  print("lainnay");
                  return Center(
                    child: Text(pointC.pesan.value),
                  );
                }
              },
            )),
      ),
    );
  }
}

class RiwayatPenukaranView extends StatelessWidget {
  const RiwayatPenukaranView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pointC = Get.find<PointController>();
    final data = pointC.dataRiwayat.value;
    return Obx(() {
      if (pointC.loading.value == true) {
        return const Center(
          child: CircularProgressIndicator(),
        );
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
          controller: pointC.scrollController,
          children: List.generate(data.length + 1, (index) {
            if (index < data.length) {
              return Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ListTile(
                          contentPadding:
                              const EdgeInsets.only(top: 5, left: 15),
                          title: Text(
                            '${data[index].namaProduk}',
                            style: const TextStyle(
                              color: AppColors.fontTitleColor,
                              fontFamily: objectApp.fontApp,
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  '${data[index].deskripsi}',
                                  style: const TextStyle(
                                    color: AppColors.fontColor,
                                    fontFamily: objectApp.fontApp,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: AppColors.themeColor),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${data[index].poin} Poin',
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontFamily: objectApp.fontApp,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          trailing: ClipRRect(
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
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10, bottom: 10, left: 15, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Tanggal Penukaran : ${data[index].tanggal}',
                                style: const TextStyle(
                                  color: AppColors.fontColor,
                                  fontFamily: objectApp.fontApp,
                                  fontSize: 12,
                                ),
                              ),
                              Container(
                                  height: 25,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                      color: AppColors.warningButtonColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black45,
                                            blurRadius: 2,
                                            spreadRadius: 0.1,
                                            offset: Offset(0, 1))
                                      ]),
                                  child: Center(
                                    child: Text(
                                      "${data[index].stts}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontFamily: objectApp.fontApp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 11),
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    )),
              );
            } else {
              if (pointC.isEndPage.value == true) {
                if (pointC.modelRiwayatPenukaran!.totalpage ==
                    pointC.modelRiwayatPenukaran!.nextpage) {
                  return Container();
                } else {
                  return Container(
                      child: const Center(
                          child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )));
                }
              } else {
                return Container();
              }
            }
          }),
        );
      }
    });
  }
}
