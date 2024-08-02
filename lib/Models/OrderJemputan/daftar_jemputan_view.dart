import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/MemberController/order_jemputan_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DaftarJemputanView extends StatelessWidget {
  const DaftarJemputanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OrderJemputanController());
    final orderC = Get.find<OrderJemputanController>();
    orderC.isEndPage.value = false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: const Text("Daftar Jemputan "),
      ),
      floatingActionButton: Container(
        width: 80,
        child: FloatingActionButton(
          onPressed: () => Get.toNamed('order-jemputan'),
          child: Text('ORDER'),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: orderC.refreshData,
        child: Container(
            height: size(context).height,
            child: Stack(
              children: [
                CustomPaint(
                  painter: WavePainter(),
                  size: MediaQuery.of(context).size,
                ),
                FutureBuilder(
                  future: orderC.daftarOrderJemputan(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print("loading");
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      print("data ada");
                      return ItemJemputan();
                    }
                  },
                )
              ],
            )),
      ),
    );
  }
}

class ItemJemputan extends StatelessWidget {
  const ItemJemputan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderC = Get.find<OrderJemputanController>();
    return Obx(
      () {
        if (orderC.loading.value == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (orderC.dataOrder.value.isEmpty) {
          return Container(
            height: size(context).height,
            width: size(context).width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const FaIcon(FontAwesomeIcons.truckPickup, color: Colors.grey),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    orderC.pesan.value,
                    style: const TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          );
        } else {
          return ListView(
            controller: orderC.scrollController,
            children: List.generate(orderC.dataOrder.value.length + 1, (index) {
              final data = orderC.dataOrder.value;
              if (index < orderC.dataOrder.value.length) {
                return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      // height: size(context).height,
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
                            "Order Pickup (${data[index].lokasijemput.namaTempat.toTitleCase()})",
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data[index].tglorder}',
                              style: const TextStyle(
                                color: AppColors.fontColor,
                                fontFamily: objectApp.fontApp,
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              'Lokasi penjemputan ${data[index].lokasijemput.alamat.toString().toTitleCase()} (${data[index].lokasijemput.detailTempat.toString().toCapitalized()})',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                // color: AppColors.fontColor,
                                fontFamily: objectApp.fontApp,
                                fontSize: 12,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 5)),
                            Container(
                              width: size(context).width,
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.start,
                                alignment: WrapAlignment.start,
                                spacing: 5,
                                runSpacing: 5,
                                children: List.generate(
                                    data[index].detail.isNotEmpty
                                        ? data[index].detail.length
                                        : 1, (i) {
                                  final item = data[index].detail;
                                  return Container(
                                    width: size(context).width / 4.5,
                                    decoration: const BoxDecoration(
                                        color: AppColors.warnaKategoriSampah,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8, bottom: 5, top: 5),
                                      child: Center(
                                        child: Text(
                                          "${item[i].nama.toTitleCase()}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: AppColors.fontTitleColor1,
                                            fontFamily: objectApp.fontApp,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
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
                        trailing: data[index].status !=
                                'Penjemputan belum dijadwalkan'
                            ? null
                            : SizedBox(
                                width: 30,
                                child: IconButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                        title: "Batalkan Orderan",
                                        content: KonfirmasiBatalJemputSampah(
                                          text:
                                              "Anda yakin untuk membatalkan orderan ini?",
                                        ),
                                        confirmTextColor: Colors.white,
                                        textConfirm: "Batalkan",
                                        textCancel: "Tutup",
                                        onConfirm: () {
                                          orderC.validasiHapus(data[index].id);
                                        });
                                  },
                                  icon: const FaIcon(
                                    FontAwesomeIcons.solidTrashCan,
                                    size: 20,
                                    color: AppColors.deleteButtonColor,
                                  ),
                                ),
                              ),
                        onTap: () {
                          Get.toNamed('/detail-jemputan');
                          orderC.viewDetail(data[index].id);
                        },
                      ),
                    ));
              } else {
                if (orderC.isEndPage.value == true) {
                  if (orderC.modelDaftarOrderJemputan!.totalpage ==
                      orderC.modelDaftarOrderJemputan!.nextpage) {
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
