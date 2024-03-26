import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/MemberController/daftar_jemputan_controller.dart';
import 'package:e_tikbroh_yok/Controllers/MemberController/riwayat_jemputan_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DaftarJemputanView extends StatelessWidget {
  const DaftarJemputanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderC = Get.find<DaftarJemputanController>();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.white, // Set your desired color here
      statusBarIconBrightness: Brightness.dark, // or Brightness.dark
    ));
    return Scaffold(
      floatingActionButton: Container(
        width: 50,
        child: FloatingActionButton(
          onPressed: () => Get.toNamed('order-jemputan'),
          child: FaIcon(FontAwesomeIcons.plus),
          backgroundColor: AppColors.color4,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: orderC.refreshData,
        child: Container(
            height: size(context).height,
            child: FutureBuilder(
              future: orderC.JemputanProses(),
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
            )),
      ),
    );
  }
}

class ItemJemputan extends StatelessWidget {
  const ItemJemputan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderC = Get.find<DaftarJemputanController>();
    return Obx(
      () {
        if (orderC.loading.value == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (orderC.proses.value.isEmpty) {
          return Container(
            height: size(context).height,
            width: size(context).width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/empty.png",scale: 3,),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                        children: [
                          TextSpan(
                              text: 'Jadwalkan penjemputan, yuk!\n',
                              style: TextStyle(
                                // fontFamily: objectApp.fontApp,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.titleText
                              )
                          ),
                          TextSpan(
                              text: 'Kami dengan senang hati\nmembantu anda',
                              style: TextStyle(
                                // fontFamily: objectApp.fontApp,
                                  fontSize: 15,
                                  color: AppColors.titleText
                              )
                          )
                        ]
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return ListView(
            children: List.generate(
                orderC.proses.value.isEmpty
                    ? 1
                    : orderC.proses.value.length, (index) {
              final data = orderC.proses.value;
              return Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                    right: 10,
                  ),
                  child: InkWell(
                    onTap: (){
                      Get.toNamed('/detail-jemputan');
                      orderC.viewDetail(data[index].id);
                    },
                    child: Container(
                      width: size(context).width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              '${data[index].tglorder}',
                              style: const TextStyle(
                                color: AppColors.datecolor,
                                fontFamily: objectApp.OpenSansreguler,
                                // fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  padding: const EdgeInsets.only(left: 10),
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
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10, right: 5),
                                        child: Row(
                                          children: [
                                            FaIcon(
                                              data[index].statuscode ==
                                                  "A"
                                                  ? FontAwesomeIcons.circleInfo
                                                  : data[index].statuscode ==
                                                  "B"
                                                  ? FontAwesomeIcons
                                                  .solidClock
                                                  :data[index].statuscode ==
                                                  "C"
                                                  ?FontAwesomeIcons
                                                  .truck : FontAwesomeIcons
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
                                      Wrap(
                                        crossAxisAlignment: WrapCrossAlignment.start,
                                        alignment: WrapAlignment.start,
                                        spacing: 5,
                                        runSpacing: 5,
                                        children: List.generate(
                                          data[index].detail.isNotEmpty
                                              ? data[index].detail.length
                                              : 1,
                                              (i) {
                                                var pesanan = "";
                                                final item = data[index].detail;
                                                item.forEach((element) {
                                                    pesanan += element.nama+", ";
                                                });
                                                pesanan = pesanan.substring(0, pesanan.length - 2);
                                            if((item.length-1) == i){
                                              return Text(
                                                "${pesanan}",
                                                maxLines: 1, // Set maxLines to 2
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: AppColors.fontTitleColor1,
                                                  fontSize: 12,
                                                ),
                                              );
                                            }else{
                                              return SizedBox();
                                            }

                                          },
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
                                                orderC.validasiHapus(
                                                    data[index].id);
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
