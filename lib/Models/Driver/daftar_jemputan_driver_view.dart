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
            child: Stack(
              children: [
                CustomPaint(
                  painter: WavePainter(),
                  size: MediaQuery.of(context).size,
                ),
                FutureBuilder<ModelDaftarJemputanDriver>(
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
                )
              ],
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
                padding: const EdgeInsets.all(10),
                child: Container(
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
                            const Padding(padding: EdgeInsets.only(right: 5)),
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
                          arguments: [false, data[index].id]);
                      // driverC.viewDetail(data[index].id);
                    },
                    trailing: SizedBox(
                      width: 30,
                      child: IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                              title: "Batalkan Jemputan",
                              content: KonfirmasiBatalJemputSampah(
                                text:
                                    "Anda yakin untuk membatalkan jemputan ini?",
                              ),
                              confirmTextColor: Colors.white,
                              textConfirm: "Batalkan",
                              textCancel: "Tutup",
                              onConfirm: () {
                                driverC.validasi(data[index].id);
                              });
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.solidTrashCan,
                          size: 20,
                          color: AppColors.deleteButtonColor,
                        ),
                      ),
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
