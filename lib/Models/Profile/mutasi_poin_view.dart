import 'package:e_tikbroh_yok/Controllers/mutasi_poin_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/responJsonMutasiPoin.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MutasiPoinView extends StatelessWidget {
  const MutasiPoinView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mutasiC = Get.find<MutasiPointController>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Aktivitas'),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.themeColor,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: mutasiC.refreshData,
          child: Container(
              height: size(context).height,
              child: Stack(
                children: [
                  CustomPaint(
                    painter: WavePainter(),
                    size: MediaQuery.of(context).size,
                  ),
                  FutureBuilder<ModelMutasiPoin>(
                    future: mutasiC.getMutasi(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                            child: const Center(
                          child: CircularProgressIndicator(),
                        ));
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        print("data ada");
                        return ItemMutasi();
                      } else {
                        print("lainnay");
                        return Center(
                          child: Text(mutasiC.pesan.value),
                        );
                      }
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class ItemMutasi extends StatelessWidget {
  const ItemMutasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mutasiC = Get.find<MutasiPointController>();
    final data = mutasiC.dataMutasi.value;
    return Obx(() {
      if (mutasiC.loading.value == true) {
        return Container(
            child: const Center(
          child: CircularProgressIndicator(),
        ));
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
                  mutasiC.pesan.value,
                  style: const TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        );
      } else {
        return ListView(
          controller: mutasiC.scrollController,
          children: List.generate(data.length + 1, (index) {
            if (index < data.length) {
              return Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                child: Container(
                    // height: 200,
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.only(top: 5, left: 15),
                        title: Text(
                          "${formatDate(DateTime.tryParse(data[index].tanggal.toString()), 'EEEE')} , ${formatDate(DateTime.tryParse(data[index].tanggal.toString()), 'dd MMMM yyyy')}",
                          style: const TextStyle(
                            color: AppColors.themeColor,
                            fontFamily: objectApp.fontApp,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                data[index].post == 'K'
                                    ? 'Poin Keluar'
                                    : 'Poin Masuk',
                                style: const TextStyle(
                                  color: AppColors.fontColor,
                                  fontFamily: objectApp.fontApp,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Text(
                              '${data[index].keterangan}',
                              style: const TextStyle(
                                color: AppColors.fontColor,
                                fontFamily: objectApp.fontApp,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        leading: CircleAvatar(
                          backgroundColor:
                              AppColors.themeColor.withOpacity(0.5),
                          foregroundColor: Colors.white,
                          child: FaIcon(
                            data[index].post == 'M'
                                ? FontAwesomeIcons.coins
                                : FontAwesomeIcons.circleDollarToSlot,
                            // color: Colors.white,
                          ),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Rp ${Helpers().formater.format(int.parse(data[index].saldo))}',
                            style: const TextStyle(
                              color: AppColors.fontColor,
                              fontFamily: objectApp.fontApp,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    )),
              );
            } else {
              if (mutasiC.isEndPage.value == true) {
                if (mutasiC.modelMutasiPoin!.totalpage ==
                    mutasiC.modelMutasiPoin!.nextpage) {
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
