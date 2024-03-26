import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/MemberController/lokasi_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Helpers/widgets.dart';

class DaftarLokasiJemputan extends StatelessWidget {
  const DaftarLokasiJemputan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lokasiJemputanC = Get.find<LokasiController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: const Text("Lokasi Jemputan",style: TextStyle(
            color: AppColors.titleText, fontFamily: objectApp.fontApp),),

      ),
      floatingActionButton: Container(
        width: 50,
        child: FloatingActionButton(
          onPressed: () => Get.toNamed('tambah-lokasi-baru'),
          child: FaIcon(FontAwesomeIcons.plus),
          backgroundColor: AppColors.color4,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: RefreshIndicator(
              onRefresh: lokasiJemputanC.refreshData,
              child: ItemLokasiJemputan()),
        ),
      ),
    );
  }
}

class ItemLokasiJemputan extends StatelessWidget {
  const ItemLokasiJemputan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lokasiJemputanC = Get.find<LokasiController>();
    return Obx(
      () {
        if (lokasiJemputanC.loading.value == true) {
          return SizedBox(
            height: size(context).height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: lokasiJemputanC.daftarLokasiJemputan!.data.isEmpty
                ? 1
                : lokasiJemputanC.daftarLokasiJemputan!.data.length,
            itemBuilder: (BuildContext context, int index) {
              if (lokasiJemputanC.daftarLokasiJemputan!.data.isEmpty) {
                return SizedBox(
                  height: size(context).height - 250,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const FaIcon(FontAwesomeIcons.mapLocationDot,
                            color: AppColors.iconColor1),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            lokasiJemputanC.pesan.value,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else if (lokasiJemputanC.daftarLokasiJemputan!.status ==
                  false) {
                return SizedBox(
                  height: size(context).height - 250,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        iconNotFound,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            lokasiJemputanC.pesan.value,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                final data = lokasiJemputanC.daftarLokasiJemputan!.data;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 2,
                              spreadRadius: 1.1,
                              offset: Offset(0, 1))
                        ]),
                    child: ListTile(
                      onTap: () {},
                      leading: InkWell(
                        onTap: () {
                          Get.to(DetailImage(
                            img: data[index].image,
                            id: data[index].image,
                          ));
                        },
                        child: Hero(
                          tag: 'detailImg${data[index].image}',
                          child: Container(
                            width: size(context).width / 6,
                            height: size(context).width / 6,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: CachedNetworkImage(
                                alignment: Alignment.center,
                                imageUrl: data[index].image,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: ImagesLoading(
                                    height: size(context).width / 6 - (3),
                                    width: size(context).width / 6,
                                  ),
                                ),
                                fit: BoxFit.cover,
                                width: size(context).width,
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(data[index].namaTempat.toUpperCase(),
                          style: const TextStyle(
                              fontFamily: objectApp.fontApp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.titleText)),
                      isThreeLine: true,
                      subtitle: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 16.0, color: Colors.black),
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Alamat  \n',
                              style: TextStyle(
                                  color: AppColors.titleText,
                                  fontFamily: objectApp.OpenSansreguler,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text:
                                  '${data[index].alamat.toString().toCapitalized()} \n',
                              style: const TextStyle(
                                // color: AppColors.fontColor,
                                // fontFamily: objectApp.fontApp,
                                fontSize: 12,
                              ),
                            ),
                            const TextSpan(
                              text: 'Detail Lokasi  \n',
                              style: TextStyle(
                                  color: AppColors.titleText,
                                  fontFamily: objectApp.OpenSansreguler,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text:
                                  '${data[index].detailTempat.toString().toCapitalized()}',
                              style: const TextStyle(
                                // color: AppColors.fontColor,
                                // fontFamily: objectApp.fontApp,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: PopupMenuButton(
                        onSelected: (value) => lokasiJemputanC.pilihAction(
                            value,
                            data[index].id,
                            data[index].titikGps,
                            data[index].namaTempat),
                        itemBuilder: (BuildContext context) {
                          return Setting.Pilih.map((String pilih) {
                            return PopupMenuItem<String>(
                              value: pilih,
                              child: Text(pilih),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}
