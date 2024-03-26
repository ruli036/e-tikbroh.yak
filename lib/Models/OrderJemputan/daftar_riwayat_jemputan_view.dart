import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/MemberController/riwayat_jemputan_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/MemberJson/responJsonDaftarOrderJemputan.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DaftarRiwayatJemputanView extends StatelessWidget {
  const DaftarRiwayatJemputanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)  {
    final orderC = Get.find<OrderJemputanController>();
    orderC.loading.value = true;
    // orderC.daftarOrderJemputan();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: orderC.refreshData,
        child: Container(
            height: size(context).height,
            child: FutureBuilder(
              future: orderC.daftarOrderJemputan(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(orderC.pesan.value),
                  );
                } else {
                  return Column(
                    children: [
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 20,
                            bottom:20,
                            right: 10,
                          ),
                          child: Container(
                            height: 50,
                            decoration:   BoxDecoration(
                              color: AppColors.filledColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color:Colors.grey.shade300,width: 2 )
                            ),
                            width: size(context).width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                icon: const FaIcon(
                                  FontAwesomeIcons.angleRight,
                                  size: 25,
                                  color: AppColors.themeColor,
                                ),
                                value: orderC.filter.value,
                                onChanged: (String? newValue) {
                                  orderC.filter.value = newValue!;
                                  orderC.daftarOrderJemputan();
                                },
                                items: orderC.kategoriFilter.value
                                    .map<DropdownMenuItem<String>>(
                                        (Liststatus status) {
                                  return DropdownMenuItem<String>(
                                    value: status.code,
                                    child: Container(
                                      width: size(context).width - 82,
                                      child: Row(
                                        children: [
                                          FaIcon(
                                            status.code == "E"
                                                    ? FontAwesomeIcons
                                                        .solidCircleXmark
                                                    : status.code == "ALL"
                                                        ? FontAwesomeIcons
                                                            .list
                                                        : FontAwesomeIcons
                                                                .solidCircleCheck,
                                            color: AppColors.themeColor,
                                            size: 20,
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(3)),
                                          Text(
                                            "${status.keterangan.toTitleCase()}",
                                            style: const TextStyle(
                                              color: AppColors.titleText,
                                              // fontFamily: objectApp.fontApp,
                                              // fontSize: 10,
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                          // FaIcon(FontAwesomeIcons.angleRight)
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(child: ItemRiwayatJemputanDriver()),
                    ],
                  );
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
                Image.asset(
                  "assets/empty.png",
                  scale: 3,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(children: [
                      TextSpan(
                          text: 'Jadwalkan penjemputan, yuk!\n',
                          style: TextStyle(
                              // fontFamily: objectApp.fontApp,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.titleText)),
                      TextSpan(
                          text: 'Kami dengan senang hati\nmembantu anda',
                          style: TextStyle(
                              // fontFamily: objectApp.fontApp,
                              fontSize: 15,
                              color: AppColors.titleText))
                    ]),
                  ),
                ),
              ],
            ),
          );
        } else {
          return ListView(
            controller: orderC.scrollController,
            children: List.generate(
                orderC.dataOrder.value.isEmpty
                    ? 1
                    : orderC.dataOrder.value.length + 1, (index) {
              final data = orderC.dataOrder.value;
              if (index < orderC.dataOrder.value.length) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                    right: 10,
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed('/detail-jemputan');
                      orderC.viewDetail(data[index].id);
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data[index].lokasijemput.namaTempat.toTitleCase()}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: AppColors.titleText,
                                            fontFamily: objectApp.fontApp,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Wrap(
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
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 20, right: 5),
                                        child: Row(
                                          children: [
                                            FaIcon(
                                              data[index].statuscode == "A"
                                                  ? FontAwesomeIcons.circleInfo
                                                  : data[index].statuscode ==
                                                          "E"
                                                      ? FontAwesomeIcons
                                                          .solidCircleXmark
                                                      : data[index]
                                                                  .statuscode ==
                                                              "B"
                                                          ? FontAwesomeIcons
                                                              .solidClock
                                                          : data[index]
                                                                      .statuscode ==
                                                                  "C"
                                                              ? FontAwesomeIcons
                                                                  .truck
                                                              : FontAwesomeIcons
                                                                  .solidCircleCheck,
                                              color: AppColors.themeColor,
                                              size: 12,
                                            ),
                                            const Padding(
                                                padding: EdgeInsets.all(3)),
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
