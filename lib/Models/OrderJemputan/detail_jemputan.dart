import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/MemberController/daftar_jemputan_controller.dart';
import 'package:e_tikbroh_yok/Controllers/MemberController/riwayat_jemputan_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DetailJemputanSampah extends StatelessWidget {
  const DetailJemputanSampah({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Jemputan", style: TextStyle(
            color: AppColors.titleText, fontFamily: objectApp.fontApp)),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: Container(color: Colors.grey.shade300, child: ItemJemputan()),
      ),
    );
  }
}

class ItemJemputan extends StatelessWidget {
  const ItemJemputan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderC = Get.find<DaftarJemputanController>();
    print(orderC.loading.value);
    return Obx(
      () {
        if (orderC.loading.value == true) {
          return SizedBox(
            height: size(context).height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (orderC.modelDetailJemputan!.status == false) {
          return SizedBox(
            height: size(context).height,
            child: Center(
              child: Text(orderC.pesan.value),
            ),
          );
        } else {
          return ListView(
            children: const [
              ItemTopDetailOrderan(),
              Padding(padding: EdgeInsets.only(top: 10)),
              DetailJemputan(),
              Padding(padding: EdgeInsets.only(top: 10)),
              ItemInfoPenjemputan(),
              Padding(padding: EdgeInsets.only(top: 10)),
              TrakingOrderan()
            ],
          );
        }
      },
    );
  }
}

class ItemTopDetailOrderan extends StatelessWidget {
  const ItemTopDetailOrderan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderC = Get.find<DaftarJemputanController>();
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
                orderC.modelDetailJemputan!.data.status,
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
                  orderC.modelDetailJemputan!.data.noinv,
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
                          img: orderC.modelDetailJemputan!.data.foto,
                          id: orderC.modelDetailJemputan!.data.foto,
                        ));
                      },
                      child: Hero(
                          tag:
                              "detailImg${orderC.modelDetailJemputan!.data.foto}",
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
                  "Tanggal Order",
                  style: TextStyle(
                      fontFamily: objectApp.fontApp,
                      color: AppColors.blackColor,
                      fontSize: 12),
                ),
                Text(
                  orderC.modelDetailJemputan!.data.tglorder,
                  style: const TextStyle(
                      // fontFamily: objectApp.fontApp,
                      color: AppColors.datecolor,
                      fontSize: 12),
                ),
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
              orderC.modelDetailJemputan!.data.keterangan.toCapitalized(),
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

class DetailJemputan extends StatelessWidget {
  const DetailJemputan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderC = Get.find<DaftarJemputanController>();
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
                    orderC.modelDetailJemputan!.data.detail.length, (index) {
              final item = orderC.modelDetailJemputan!.data.detail;
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
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                              ),
                            )
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
                                          shape: BoxShape.circle,
                                          color: Colors.green,
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
                            ))
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

class ItemInfoPenjemputan extends StatelessWidget {
  const ItemInfoPenjemputan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderC = Get.find<DaftarJemputanController>();
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
                TextButton(
                    onPressed: () {
                      Get.to(DetailImage(
                        img: orderC.modelDetailJemputan!.data.lokasijemput.foto,
                        id: orderC.modelDetailJemputan!.data.lokasijemput.foto,
                      ));
                    },
                    child: Hero(
                        tag:
                            "detailImg${orderC.modelDetailJemputan!.data.lokasijemput.foto}",
                        child: const Text(
                          'Foto Rumah',
                          style: TextStyle(fontSize: 13),
                        )))
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
                    "Kurir",
                    style: TextStyle(
                        fontFamily: objectApp.fontApp,
                        color: AppColors.blackColor,
                        fontSize: 12),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Text(
                      orderC.modelDetailJemputan!.data.driver.toTitleCase(),
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
                      "${orderC.modelDetailJemputan!.data.lokasijemput.alamat.toTitleCase()} (${orderC.modelDetailJemputan!.data.lokasijemput.detailTempat.toTitleCase()})",
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
                          openMap(orderC
                              .modelDetailJemputan!.data.lokasijemput.titikGps);
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

class TrakingOrderan extends StatelessWidget {
  const TrakingOrderan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderC = Get.find<DaftarJemputanController>();
    return Container(
        color: Colors.white,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tracking Penjemputan",
                style: TextStyle(
                    fontFamily: objectApp.fontApp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 17),
              ),
              const Divider(thickness: 2,),
              const Padding(padding: EdgeInsets.all(5)),
              Column(
                children: List.generate(
                    orderC.modelDetailJemputan!.data.tracking.isEmpty
                        ? 1
                        : orderC.modelDetailJemputan!.data.tracking.length,
                    (index) {
                  final traking = orderC.modelDetailJemputan!.data.tracking;
                  if (traking.isEmpty) {
                    return Container(
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: FaIcon(
                              FontAwesomeIcons.circleExclamation,
                              color: AppColors.warningIconColor,
                            ),
                          ),
                          Text(
                            "Order Jemputan Sedang Diproses",
                            style: TextStyle(color: AppColors.fontColor),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Table(
                          columnWidths: const {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(3),
                          },
                          children: [
                            TableRow(children: [
                              Column(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.circleExclamation,
                                    size: 25,
                                    color: Colors.grey.shade300,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 5, bottom: 5),
                                    child: Container(
                                        height: 25,
                                        decoration: const BoxDecoration(
                                            color: AppColors.warningButtonColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black45,
                                                  blurRadius: 2,
                                                  spreadRadius: 0.1,
                                                  offset: Offset(0, 1))
                                            ]),
                                        child: Center(
                                          child: Text(
                                            orderC.modelDetailJemputan!.data
                                                .tracking[index].status
                                                .toCapitalized(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontFamily: objectApp.fontApp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 8),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      orderC.modelDetailJemputan!.data
                                          .tracking[index].waktu
                                          .toString(),
                                      style: const TextStyle(
                                          fontFamily: objectApp.fontApp,
                                          color: AppColors.fontColor,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      orderC.modelDetailJemputan!.data
                                          .tracking[index].driver
                                          .toString(),
                                      style: const TextStyle(
                                          fontFamily: objectApp.fontApp,
                                          color: AppColors.fontColor,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      orderC.modelDetailJemputan!.data
                                          .tracking[index].catatan
                                          .toString(),
                                      style: const TextStyle(
                                          fontFamily: objectApp.fontApp,
                                          color: AppColors.fontColor,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ]),
                          ],
                        ),
                        const Divider(thickness: 1,),
                      ],
                    );
                  }
                }),
              )
            ],
          ),
        ));
  }
}
