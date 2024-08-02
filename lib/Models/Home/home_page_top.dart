import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/home_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helpers/widgets.dart';

class HomePageTopView extends StatelessWidget {
  const HomePageTopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homePageC = Get.find<HomeController>();
    return Container(
      height: 200,
      color: AppColors.themeColor,
      child: Obx(
        () => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${homePageC.nama.value.toString().toTitleCase()} \n',
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.white,
                                    fontFamily: objectApp.fontApp,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.green,
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${homePageC.level.value.toCapitalized()}',
                                      style: const TextStyle(
                                        color: AppColors.textColor,
                                        fontFamily: objectApp.fontApp,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 5)),
                          Text(
                            homePageC.email.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: objectApp.fontApp,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 5)),
                          Text(
                            homePageC.nohp.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: objectApp.fontApp,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 10),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: InkWell(
                      onTap: () {
                        Get.to(DetailImage(
                          img: homePageC.foto.value,
                          id: homePageC.foto.value,
                        ));
                      },
                      child: Hero(
                        tag: 'detailImg${homePageC.foto.value}',
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              border:
                                  Border.all(color: Colors.white, width: 3)),
                          height: 60,
                          width: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: CachedNetworkImage(
                              alignment: Alignment.center,
                              imageUrl: homePageC.foto.value,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: ImagesLoading(
                                  height: 54,
                                  width: 60,
                                ),
                              ),
                              fit: BoxFit.cover,
                              width: size(context).width,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17, left: 10, right: 10),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: const Offset(0, 3), // Offset of the shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Obx(() {
                  if (homePageC.loading.value == false) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed('mutasi-poin');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                    children: <TextSpan>[
                                      const TextSpan(
                                        text: "Nominal \n",
                                        style: TextStyle(
                                          color: AppColors.themeColor,
                                          fontFamily: objectApp.fontApp,
                                          fontSize: 14,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            'Rp ${homePageC.loading.value == false ? Helpers().formater.format(int.parse(homePageC.modelPointDashboart!.selisih.rupiah.toString())) : 0}',
                                        style: const TextStyle(
                                            color: AppColors.themeColor,
                                            fontFamily: objectApp.fontApp,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Container(
                              width: 2,
                              height: size(context).height / 7.5,
                              color: AppColors.themeColor,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                    children: <TextSpan>[
                                      const TextSpan(
                                        text: 'Poin \n',
                                        style: TextStyle(
                                          color: AppColors.themeColor,
                                          fontFamily: objectApp.fontApp,
                                          fontSize: 14,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${homePageC.loading.value == false ? homePageC.modelPointDashboart!.selisih.poin : 0}',
                                        style: const TextStyle(
                                            color: AppColors.themeColor,
                                            fontFamily: objectApp.fontApp,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: ImagesLoadingIklan(
                          scaleHeigth: 6,
                        ));
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
