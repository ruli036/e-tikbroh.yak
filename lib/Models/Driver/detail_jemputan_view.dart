import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/DriverController/daftar_jemputan_controller.dart';
import 'package:e_tikbroh_yok/Controllers/DriverController/detail_jemputan_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/DriverJson/responJsonDetailJemputanDriver.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DetailJemputanDriverView extends StatelessWidget {
  const DetailJemputanDriverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DetailJemputanController());
    final jemputan = Get.find<DaftarJemputanDriverController>();
    final driverC = Get.find<DetailJemputanController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(driverC.riwayat.value
            ? "Detail Riwayat Jemputan"
            : "Detail Jemputan",
            style: TextStyle(
            color: AppColors.titleText, fontFamily: objectApp.fontApp),),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
      ),
      body: SafeArea(
        child:
            Container(color: Colors.grey.shade300, child: ItemJemputanDriver()),
      ),
      bottomNavigationBar: driverC.riwayat.value
          ? Container(
              height: 0,
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      openMap(driverC.modelDetailJemputanDriver!.data
                          .lokasijemput.titikGps);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: AppColors.themeColor),
                      width: size(context).width / 2 - (15),
                      height: 35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          FaIcon(
                            FontAwesomeIcons.mapLocationDot,
                            color: AppColors.colorMenu2,
                          ),
                          Padding(padding: EdgeInsets.all(5)),
                          Text(
                            'Open Map',
                            style: TextStyle(
                                fontFamily: objectApp.fontApp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      jemputan.keteraganTambahan.text = "";
                      jemputan.beratItem = [];
                      jemputan.catatBerat.clear();
                      Get.bottomSheet(ProsesJemputan(
                        item: driverC.modelDetailJemputanDriver!.data.detail,
                        id: driverC.modelDetailJemputanDriver!.data.id,
                      ));
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: AppColors.themeColor),
                      width: size(context).width / 2 - (15),
                      height: 35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          FaIcon(
                            FontAwesomeIcons.pencil,
                            color: AppColors.colorMenu2,
                          ),
                          Padding(padding: EdgeInsets.all(5)),
                          Text(
                            'Proses',
                            style: TextStyle(
                                fontFamily: objectApp.fontApp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class ItemJemputanDriver extends StatelessWidget {
  const ItemJemputanDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final driverC = Get.find<DetailJemputanController>();
    return Obx(
      () {
        if (driverC.loading.value == true) {
          return SizedBox(
            height: size(context).height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (driverC.modelDetailJemputanDriver!.status == false) {
          return SizedBox(
            height: size(context).height,
            child: Center(
              child: Text(driverC.pesan.value),
            ),
          );
        } else {
          return ListView(
            children: const [
              ItemTopDetailOrderanDriver(),
              Padding(padding: EdgeInsets.only(top: 10)),
              ItemDetailJemputanDriver(),
              Padding(padding: EdgeInsets.only(top: 10)),
              ItemInfoPenjemputanDriver()
            ],
          );
        }
      },
    );
  }
}

class ItemTopDetailOrderanDriver extends StatelessWidget {
  const ItemTopDetailOrderanDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final driverC = Get.find<DetailJemputanController>();
    return Container(
      color: Colors.white,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                driverC.modelDetailJemputanDriver!.data.status,
                style: const TextStyle(
                    fontFamily: objectApp.fontApp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                    fontSize: 16),
              ),
            ),
            Divider(
              color: AppColors.blackColor.withOpacity(0.5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  driverC.modelDetailJemputanDriver!.data.member.toTitleCase(),
                  style: const TextStyle(
                      fontFamily: objectApp.fontApp,
                      color: AppColors.blackColor,
                      fontSize: 12),
                ),
                SizedBox(
                  height: 30,
                  child: TextButton(
                      onPressed: () {
                        Get.to(DetailImage(
                          img: driverC.modelDetailJemputanDriver!.data.foto,
                          id: driverC.modelDetailJemputanDriver!.data.foto,
                        ));
                      },
                      child: Hero(
                          tag:
                              "detailImg${driverC.modelDetailJemputanDriver!.data.foto}",
                          child: const Text(
                            'Foto Sampah',
                            style: TextStyle(fontSize: 13),
                          ))),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Tanggal Penjemputan",
                  style: TextStyle(
                      fontFamily: objectApp.fontApp,
                      color: AppColors.blackColor,
                      fontSize: 12),
                ),
                Text(
                  driverC.modelDetailJemputanDriver!.data.tgljemput,
                  style: const TextStyle(
                      // fontFamily: objectApp.fontApp,
                      color: AppColors.blackColor,
                      fontSize: 12),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Kontak Member",
                  style: TextStyle(
                      fontFamily: objectApp.fontApp,
                      color: AppColors.blackColor,
                      fontSize: 12),
                ),
                InkWell(
                  onTap: () => buatPanggilan(
                      driverC.modelDetailJemputanDriver!.data.kontakmember),
                  child: Text(
                    driverC.modelDetailJemputanDriver!.data.kontakmember,
                    style: const TextStyle(
                        fontFamily: objectApp.fontApp,
                        color: AppColors.buttonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                )
              ],
            ),
            const Divider(),
            const Text(
              "Keterangan Jemputan :",
              style: TextStyle(
                  fontFamily: objectApp.fontApp,
                  color: AppColors.blackColor,
                  fontSize: 12),
            ),
            Text(
              driverC.modelDetailJemputanDriver!.data.keterangan
                  .toCapitalized(),
              style: const TextStyle(
                  // fontFamily: objectApp.fontApp,
                  color: AppColors.blackColor,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemDetailJemputanDriver extends StatelessWidget {
  const ItemDetailJemputanDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final driverC = Get.find<DetailJemputanController>();
    return Container(
      color: Colors.white,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Detail Kategori",
              style: TextStyle(
                  fontFamily: objectApp.fontApp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor,
                  fontSize: 16),
            ),
            const Divider(),
            Column(
                children: List.generate(
                    driverC.modelDetailJemputanDriver!.data.detail.length,
                    (index) {
              final item = driverC.modelDetailJemputanDriver!.data.detail;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.themeColor.withOpacity(0.1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, top: 8, bottom: 8, right: 15),
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    child: CachedNetworkImage(
                                      alignment: Alignment.center,
                                      imageUrl: item[index].foto,
                                      errorWidget: (context, url, error) =>
                                          Image.asset("assets/logo2.png"),
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: ImagesLoadingIklan(
                                          scaleHeigth: 6,
                                        ),
                                      ),
                                      fit: BoxFit.cover,
                                      width: size(context).width,
                                    ),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${item[index].nama.toTitleCase()}',
                                    style: const TextStyle(
                                        color: AppColors.blackColor,
                                        fontFamily: objectApp.fontApp,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 5)),
                                  Text(
                                    '${item[index].berat} x Rp ${Helpers().formater.format(int.parse(item[index].hargaJual))} \n',
                                    style: const TextStyle(
                                      color: AppColors.fontColor,
                                      fontFamily: objectApp.fontApp,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Divider(
                              color: AppColors.blackColor.withOpacity(0.5)),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 8, bottom: 8, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        color: AppColors.blackColor),
                                    children: <TextSpan>[
                                      const TextSpan(
                                        text: 'Total Harga \n',
                                        style: TextStyle(
                                          color: AppColors.fontTitleColor,
                                          fontFamily: objectApp.fontApp,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            'Rp ${Helpers().formater.format(int.parse(item[index].total))}',
                                        style: const TextStyle(
                                          color: AppColors.blackColor,
                                          fontFamily: objectApp.fontApp,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                item[index].poin == '0'
                                    ? Container()
                                    : Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                        ),
                                        width: 30,
                                        height: 30,
                                        child: Center(
                                          child: Text(
                                            '${item[index].poin}',
                                            style: const TextStyle(
                                              color: AppColors.textColor,
                                              fontFamily: objectApp.fontApp,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              );
            })),
          ],
        ),
      ),
    );
  }
}

class ItemInfoPenjemputanDriver extends StatelessWidget {
  const ItemInfoPenjemputanDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final driverC = Get.find<DetailJemputanController>();
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Info Penjemputan",
                  style: TextStyle(
                      fontFamily: objectApp.fontApp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 30,
                  child: TextButton(
                      onPressed: () {
                        Get.to(DetailImage(
                          img: driverC.modelDetailJemputanDriver!.data
                              .lokasijemput.foto,
                          id: driverC.modelDetailJemputanDriver!.data
                              .lokasijemput.foto,
                        ));
                      },
                      child: Hero(
                          tag:
                              "detailImg${driverC.modelDetailJemputanDriver!.data.lokasijemput.foto}",
                          child: const Text(
                            'Foto Rumah',
                            style: TextStyle(fontSize: 13),
                          ))),
                )
              ],
            ),
            const Divider(),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
              },
              children: [
                TableRow(children: [
                  const Text(
                    "Driver",
                    style: TextStyle(
                        fontFamily: objectApp.fontApp,
                        color: AppColors.blackColor,
                        fontSize: 12),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Text(
                      "${driverC.modelDetailJemputanDriver!.data.driver.toTitleCase()}",
                      style: const TextStyle(
                          // fontFamily: objectApp.fontApp,
                          color: AppColors.blackColor,
                          fontSize: 12),
                    ),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      "Nama Tempat",
                      style: TextStyle(
                          fontFamily: objectApp.fontApp,
                          color: AppColors.blackColor,
                          fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7, top: 8),
                    child: Text(
                      "${driverC.modelDetailJemputanDriver!.data.lokasijemput.namaTempat.toTitleCase()}",
                      style: const TextStyle(
                          // fontFamily: objectApp.fontApp,
                          color: AppColors.blackColor,
                          fontSize: 12),
                    ),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      "Alamat",
                      style: TextStyle(
                          fontFamily: objectApp.fontApp,
                          color: AppColors.blackColor,
                          fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 7),
                    child: Text(
                      "${driverC.modelDetailJemputanDriver!.data.lokasijemput.alamat.toTitleCase()} (${driverC.modelDetailJemputanDriver!.data.lokasijemput.detailTempat.toTitleCase()})",
                      style: const TextStyle(
                          // fontFamily: objectApp.fontApp,
                          color: AppColors.blackColor,
                          fontSize: 12),
                    ),
                  ),
                ]),
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      "Lokasi",
                      style: TextStyle(
                          fontFamily: objectApp.fontApp,
                          color: AppColors.blackColor,
                          fontSize: 12),
                    ),
                  ),
                  Container(
                    height: 30,
                    child: TextButton(
                        onPressed: () {
                          openMap(driverC.modelDetailJemputanDriver!.data
                              .lokasijemput.titikGps);
                        },
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Akses Google Maps',
                            style: TextStyle(fontSize: 12),
                          ),
                        )),
                  ),
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProsesJemputan extends StatelessWidget {
  List<DetailJemputanDriver> item;
  String id;
  ProsesJemputan({Key? key, required this.id, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final driverC = Get.find<DaftarJemputanDriverController>();
    return Container(
      height: size(context).height / 1.5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: driverC.keyFormJemputan,
          child: Column(
            children: [
              TextFormField(
                controller: driverC.keteraganTambahan,
                validator: (e) {
                  if (e!.isEmpty) {
                    return 'Masukkan Keterangan';
                  }
                  return null;
                },
                maxLines: 3,
                decoration: InputDecoration(
                  fillColor: AppColors.filledColor.withOpacity(0.5),
                  filled: true,
                  hintText: 'Keterangan Tambahan',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  labelStyle: TextStyle(fontSize: objectApp.labelFont),
                  prefixIcon: const Icon(
                    Icons.description,
                    color: AppColors.iconColor1,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: List.generate(item.length, (index) {
                    driverC.beratItem.add(TextEditingController());
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item[index].nama.toTitleCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: AppColors.fontColor,
                                fontFamily: objectApp.fontApp,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: driverC.beratItem[index],
                            validator: (e) {
                              if (e!.isEmpty) {
                                return 'Masukkan Jumlah Berat';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              driverC.catatBerat.addAll({
                                'databerat[${index}][id]': item[index].id,
                                'databerat[${index}][berat]': value
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              fillColor: AppColors.filledColor.withOpacity(0.5),
                              filled: true,
                              hintText: 'Berat',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              labelStyle:
                                  TextStyle(fontSize: objectApp.labelFont),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: FaIcon(
                                  FontAwesomeIcons.weightScale,
                                  color: AppColors.iconColor1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              InkWell(
                onTap: () {
                  driverC.validasiSimpanBerat(id);
                },
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AppColors.buttonColor),
                  // width: size(context).width / 2,
                  height: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      FaIcon(
                        FontAwesomeIcons.cloudArrowUp,
                        color: AppColors.colorMenu2,
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Text(
                        'Simpan',
                        style: TextStyle(
                            fontFamily: objectApp.fontApp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
