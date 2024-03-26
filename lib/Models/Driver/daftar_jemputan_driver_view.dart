import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/DriverController/daftar_jemputan_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/DriverJson/responJsonJemputanDriver.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DaftarJemputanDriverView extends StatelessWidget {
  const DaftarJemputanDriverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final driverC = Get.find<DaftarJemputanDriverController>();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: driverC.refreshData,
        child: Container(
            height: size(context).height,
            child: FutureBuilder<ModelDaftarJemputanDriver>(
              future: driverC.daftarOrderJemputanDriver(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(driverC.pesan.value),
                  );
                } else if (snapshot.data!.data.isEmpty) {
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
                            driverC.pesan.value,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return ItemJemputanDriver();
                }
              },
            )),
      ),
    );
  }
}

class ItemJemputanDriver extends StatelessWidget {
  const ItemJemputanDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final driverC = Get.find<DaftarJemputanDriverController>();
    return Obx(
      () {
        final responData = driverC.modelDaftarJemputanDriver!.data;
        if (driverC.loading.value == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView(
            children: List.generate(responData.length, (index) {
              final data = driverC.modelDaftarJemputanDriver!.data;
              return Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 10,
                  right: 10,
                ),
                child: InkWell(
                  onTap: () {
                    Get.toNamed('/detail-jemputan-driver',
                        arguments: [false, data[index].id]);
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
                                      "Order Pickup\n(${data[index].lokasijemput.namaTempat.toTitleCase()})",
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
                                              fontSize: 16.0,
                                              color: Colors.black),
                                          children: <TextSpan>[
                                            const TextSpan(
                                              text: 'Lokasi : ',
                                              style: TextStyle(
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
                            data[index].status !=
                                    'Penjemputan belum dijadwalkan'
                                ? Container()
                                : SizedBox(
                                    width: 30,
                                    child: IconButton(
                                      onPressed: () {
                                        Get.defaultDialog(
                                            title: "Batalkan Orderan",
                                            content:
                                                KonfirmasiBatalJemputSampah(
                                              text:
                                                  "Anda yakin untuk membatalkan orderan ini?",
                                            ),
                                            confirmTextColor: Colors.white,
                                            textConfirm: "Batalkan",
                                            textCancel: "Tutup",
                                            onConfirm: () {
                                              Get.defaultDialog(
                                                  title: "Batalkan Jemputan",
                                                  content:
                                                      KonfirmasiBatalJemputSampah(
                                                    text:
                                                        "Anda yakin untuk membatalkan jemputan ini?",
                                                  ),
                                                  confirmTextColor:
                                                      Colors.white,
                                                  textConfirm: "Batalkan",
                                                  textCancel: "Tutup",
                                                  onConfirm: () {
                                                    driverC.validasi(
                                                        data[index].id);
                                                  });
                                            });
                                      },
                                      icon: const FaIcon(
                                        FontAwesomeIcons.solidTrashCan,
                                        size: 20,
                                        color: AppColors.deleteButtonColor,
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
            }),
          );
        }
      },
    );
  }
}
