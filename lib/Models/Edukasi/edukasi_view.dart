import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/edukasi_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/MemberJson/responJsonKategoriSampah.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
class EdukasiView extends StatelessWidget {
  const EdukasiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EdukasiController());
    final edukasiC = Get.find<EdukasiController>();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.white, // Set your desired color here
      statusBarIconBrightness: Brightness.dark, // or Brightness.dark
    ));
    return Scaffold(
      appBar: AppBar(
        title:const Text('Katalog Sampah',
            style: TextStyle(
                color: AppColors.titleText, fontFamily: objectApp.fontApp)),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
      ),
      body: RefreshIndicator(
        onRefresh: edukasiC.refreshData,
        child: Container(
            height: size(context).height,
            child: FutureBuilder<ModelKategoriSampah>(
              future: edukasiC.kategoriSampah(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(edukasiC.pesan.value),
                  );
                } else if (!snapshot.hasData) {
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
                            edukasiC.pesan.value,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return ItemEdukasi();
                }
              },
            )),
      ),
    );
  }
}

class ItemEdukasi extends StatelessWidget {
  const ItemEdukasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final edukasiC = Get.find<EdukasiController>();
    return Obx(
      () {
        final data = edukasiC.modelKategoriSampah!.kategori;
        if (edukasiC.loading.value == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if(data.isEmpty){
          return Center(
            child: Text(
              edukasiC.pesan.value,
              style: const TextStyle(color: Colors.black),
            ),
          );
        } else {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:20,left: 10,right: 10,bottom: 20),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  spacing: 15,
                  runSpacing: 15,
                  children: data
                      .where((item) => item.katalogsampah.isNotEmpty)
                      .map((filteredItem) => badges.Badge(
                    position: badges.BadgePosition.topEnd(top: 0, end: 0),
                    showBadge: true,
                    ignorePointer: false,
                    onTap: () {},
                    badgeContent:
                    Text(
                        filteredItem.estimasiPoin,
                        style: const TextStyle(
                            color: AppColors.textColor,
                            fontFamily: objectApp.fontApp,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)
                    ),
                    badgeStyle:const  badges.BadgeStyle(
                      shape: badges.BadgeShape.square,
                      badgeColor: AppColors.themeColor,
                      padding: EdgeInsets.all(5),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomLeft: Radius.circular(10)),

                    ),
                    child: GestureDetector(
                      onTap: (){
                        final List<String> images = [];
                        filteredItem.katalogsampah.forEach((element) {
                          images.addAll({element.image});
                        });
                        if (filteredItem.katalogsampah.isNotEmpty) {
                          Get.to(ListImagePreviewPage(
                            id: filteredItem.id,
                            imageUrls: images,
                            desc: filteredItem.deskripsi,
                          ));
                        }
                      },
                      child: Container(
                        width: size(context).width / 2.3,
                        height: size(context).width / 2.3,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 2), // Offset of the shadow
                              ),
                            ],
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                              child: CachedNetworkImage(
                                alignment: Alignment.center,
                                imageUrl: filteredItem.image=='https://etikbrohyak.com/adminsite/assets/img/logoweb/+Teks_1png.png'?filteredItem.katalogsampah[0].image:filteredItem.image,
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: ImagesLoadingIklan(
                                    scaleHeigth: 6,
                                  ),
                                ),
                                fit: BoxFit.cover,
                                width: size(context).width,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: Container(
                                width: size(context).width / 2.3,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius:const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Center(
                                    child: Text(filteredItem.nama,
                                      style: const TextStyle(
                                          color: AppColors.textColor,
                                          fontFamily: objectApp.fontApp,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),

                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )).toList()
                  // List.generate(data.length, (index) {
                  //     return badges.Badge(
                  //       position: badges.BadgePosition.topEnd(top: 0, end: 0),
                  //       showBadge: true,
                  //       ignorePointer: false,
                  //       onTap: () {},
                  //       badgeContent:
                  //       Text(
                  //           data[index].estimasiPoin,
                  //           style: const TextStyle(
                  //               color: AppColors.textColor,
                  //               fontFamily: objectApp.fontApp,
                  //               fontSize: 15,
                  //               fontWeight: FontWeight.bold)
                  //       ),
                  //       badgeStyle:const  badges.BadgeStyle(
                  //         shape: badges.BadgeShape.square,
                  //         badgeColor: AppColors.themeColor,
                  //         padding: EdgeInsets.all(5),
                  //         borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                  //
                  //       ),
                  //       child: GestureDetector(
                  //         onTap: (){
                  //           final List<String> images = [];
                  //           data[index].katalogsampah.forEach((element) {
                  //             images.addAll({element.image});
                  //           });
                  //           if (data[index].katalogsampah.isNotEmpty) {
                  //             Get.to(ListImagePreviewPage(
                  //               id: data[index].id,
                  //               imageUrls: images,
                  //               desc: data[index].deskripsi,
                  //             ));
                  //           }
                  //         },
                  //         child: Container(
                  //           width: size(context).width / 2.3,
                  //           height: size(context).width / 2.3,
                  //           decoration: BoxDecoration(
                  //               color: Colors.white,
                  //               boxShadow: [
                  //                 BoxShadow(
                  //                   color: Colors.grey.withOpacity(0.5),
                  //                   spreadRadius: 2,
                  //                   blurRadius: 5,
                  //                   offset: const Offset(0, 2), // Offset of the shadow
                  //                 ),
                  //               ],
                  //               borderRadius:
                  //               const BorderRadius.all(Radius.circular(10))),
                  //           child: Stack(
                  //             children: [
                  //               ClipRRect(
                  //                 borderRadius:
                  //                 const BorderRadius.all(Radius.circular(5)),
                  //                 child: CachedNetworkImage(
                  //                   alignment: Alignment.center,
                  //                   imageUrl: data[index].image,
                  //                   errorWidget: (context, url, error) =>
                  //                   const Icon(Icons.error),
                  //                   progressIndicatorBuilder:
                  //                       (context, url, downloadProgress) => Center(
                  //                     child: ImagesLoadingIklan(
                  //                       scaleHeigth: 6,
                  //                     ),
                  //                   ),
                  //                   fit: BoxFit.cover,
                  //                   width: size(context).width,
                  //                 ),
                  //               ),
                  //               Positioned(
                  //                 bottom: 0,
                  //                 left: 0,
                  //                 child: Container(
                  //                   width: size(context).width / 2.3,
                  //                   decoration: BoxDecoration(
                  //                       color: Colors.black.withOpacity(0.3),
                  //                       borderRadius:const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                  //                   ),
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.all(5),
                  //                     child: Center(
                  //                       child: Text(data[index].nama,
                  //                         style: const TextStyle(
                  //                             color: AppColors.textColor,
                  //                             fontFamily: objectApp.fontApp,
                  //                             fontSize: 15,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   ),
                  //
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  // },
        //          ),
                ),
              )
            ],
          );
        }
      },
    );
  }
}
