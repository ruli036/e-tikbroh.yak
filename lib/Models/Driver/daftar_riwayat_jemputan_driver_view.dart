import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/DriverController/daftar_riwayat_jemputan_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DaftarRiwayatJemputanDriverView extends StatelessWidget {
  const DaftarRiwayatJemputanDriverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final driverC = Get.find<DaftarRiwayatJemputanDriverController>();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: driverC.refreshData,
        child: Container(
            height: size(context).height,
            child: FutureBuilder(
              future: driverC.daftarRiwayatOrderJemputanDriver(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(driverC.pesan.value),
                  );
                } else {
                  return ItemRiwayatJemputanDriver();
                }
              },
            )),
      ),
    );
  }
}

class ItemRiwayatJemputanDriver extends StatelessWidget {
  const ItemRiwayatJemputanDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final driverC = Get.find<DaftarRiwayatJemputanDriverController>();
    return Obx(
      () {
        if (driverC.loading.value == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (driverC.dataRiwayat.value.isEmpty) {
          return Container(
            height: size(context).height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const FaIcon(FontAwesomeIcons.truckPickup, color: Colors.grey),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    driverC.pesan.value,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        } else {
          return ListView(
            controller: driverC.scrollController,
            children: List.generate(
                driverC.dataRiwayat.value.isEmpty
                    ? 1
                    : driverC.dataRiwayat.value.length + 1, (index) {
              final data = driverC.dataRiwayat.value;
              if (index < driverC.dataRiwayat.value.length) {
                return  Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                    right: 10,
                  ),
                  child: InkWell(
                    onTap: (){
                      Get.toNamed('/detail-jemputan-driver',
                          arguments: [true, data[index].id]);
                    },
                    child: Container(
                      width: size(context).width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${data[index].tglorder}',
                            style: const TextStyle(
                              color: AppColors.datecolor,
                              fontFamily: objectApp.OpenSansreguler,
                              // fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                child: ClipRRect(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                                  child: CachedNetworkImage(
                                    alignment: Alignment.center,
                                    imageUrl: data[index].lokasijemput.foto,
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                        Center(
                                          child: ImagesLoading(
                                            height: 50 - (3),
                                            width: 50,
                                          ),
                                        ),
                                    fit: BoxFit.cover,
                                    width: size(context).width,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data[index].member.toTitleCase()} (${data[index].lokasijemput.namaTempat.toTitleCase()})",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: AppColors.titleText,
                                            fontFamily: objectApp.fontApp,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                                fontSize: 16.0, color: Colors.black),
                                            children: <TextSpan>[
                                              const TextSpan(
                                                text: 'Lokasi : ',
                                                style:  TextStyle(
                                                  color: AppColors.titleText,
                                                  fontFamily: objectApp.fontApp,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                '${data[index].lokasijemput.alamat.toString().toTitleCase()} (${data[index].lokasijemput.detailTempat.toString().toCapitalized()})',
                                                style: const TextStyle(
                                                  // color: AppColors.fontColor,
                                                  // fontFamily: objectApp.fontApp,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 20, right: 5),
                                        child: Row(
                                          children: [
                                            FaIcon(
                                              data[index].status ==
                                                  "Penjemputan belum dijadwalkan"
                                                  ? FontAwesomeIcons.circleInfo
                                                  : data[index].status ==
                                                  "Tidak bisa dijemput"
                                                  ? FontAwesomeIcons
                                                  .solidCircleXmark
                                                  : data[index].status ==
                                                  "Jemput telah dijadwalkan"
                                                  ? FontAwesomeIcons
                                                  .solidClock
                                                  : FontAwesomeIcons
                                                  .solidCircleCheck,
                                              color: AppColors.themeColor,
                                              size: 12,
                                            ),
                                            const Padding(padding: EdgeInsets.all(3)),
                                            Text(
                                              "${data[index].status}",
                                              style: const TextStyle(
                                                color: AppColors.titleText,
                                                fontFamily: objectApp.fontApp,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 2,
                          )
                        ],
                      ),
                    ),
                  ),
                );
                return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      // height: size(context).height / 1.5,
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 2,
                                spreadRadius: 1.1,
                                offset: Offset(0, 1))
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            "${data[index].member.toTitleCase()} (${data[index].lokasijemput.namaTempat.toTitleCase()})",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: AppColors.fontTitleColor1,
                                fontFamily: objectApp.fontApp,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        subtitle: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '${data[index].tglorder} \n',
                                    style: const TextStyle(
                                      color: AppColors.fontColor,
                                      fontFamily: objectApp.fontApp,
                                      fontSize: 11,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'Lokasi penjemputan ${data[index].lokasijemput.alamat.toString().toTitleCase()} (${data[index].lokasijemput.detailTempat.toString().toCapitalized()})',
                                    style: const TextStyle(
                                      // color: AppColors.fontColor,
                                      fontFamily: objectApp.fontApp,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 5)),
                            Row(
                              children: [
                                ClipOval(
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    color: AppColors.warnaTitik,
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(right: 5)),
                                Text(
                                  "${data[index].status.toTitleCase()}",
                                  style: const TextStyle(
                                    color: AppColors.fontTitleColor1,
                                    fontFamily: objectApp.fontApp,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(top: 5)),
                          ],
                        ),
                        leading: Container(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            child: CachedNetworkImage(
                              alignment: Alignment.center,
                              imageUrl: data[index].lokasijemput.foto,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: ImagesLoading(
                                  height: 50 - (3),
                                  width: 50,
                                ),
                              ),
                              fit: BoxFit.cover,
                              width: size(context).width,
                            ),
                          ),
                        ),
                        onTap: () {
                          Get.toNamed('/detail-jemputan-driver',
                              arguments: [true, data[index].id]);
                          // driverC.viewDetail(data[index].id);
                        },
                      ),
                    ));
              } else {
                if (driverC.isEndPage.value == true) {
                  if (driverC.modelRiwayatJemputanDriver!.totalpage ==
                      driverC.modelRiwayatJemputanDriver!.nextpage) {
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
      },
    );
  }
}
