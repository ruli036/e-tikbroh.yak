import 'package:e_tikbroh_yok/Controllers/home_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Models/Home/home_slide_iklan.dart';
import 'package:e_tikbroh_yok/Models/Home/home_slide_iklan_mitra.dart';
import 'package:e_tikbroh_yok/Models/Home_v2/katalog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageMenuView extends StatelessWidget {
  const PageMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homePageC = Get.find<HomeController>();
    return Container(
      color: AppColors.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 10, top: 0, bottom: 20),
            child: Row(
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        if (homePageC.level.value == 'member') {
                          Get.toNamed('order-jemputan');
                        } else {
                          homePageC.onItemTapped(1);
                        }
                      },
                      child: Container(
                        width: size(context).width / 2.2,
                        height: size(context).width / 1.5,
                        decoration: const BoxDecoration(
                          color: AppColors.themeColorV2light,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.5),
                          //     spreadRadius: 2,
                          //     blurRadius: 1,
                          //     offset: const Offset(2, 0), // Offset of the shadow
                          //   ),
                          // ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Stack(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: Image.asset(
                                    "assets/icon/jemput.png",
                                    height: 140,
                                  )),
                              const Positioned(
                                left: 15,
                                top: 10,
                                child: Text(
                                  "Jemput\nSampah",
                                  style: TextStyle(
                                    color: AppColors.titleText,
                                    fontFamily: objectApp.fontApp,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 15,
                                top: 90,
                                child: Text(
                                  "Sampahmu mau dijemput? ",
                                  style: TextStyle(
                                    color: AppColors.titleText.withOpacity(0.6),
                                    // fontFamily: objectApp.fontApp,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(homePageC.snackBar);
                      },
                      child: Container(
                        width: size(context).width / 2.2,
                        height: size(context).width / 4.5,
                        decoration: const BoxDecoration(
                          color: AppColors.themeColorV2light,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.5),
                          //     spreadRadius: 2,
                          //     blurRadius: 1,
                          //     offset: const Offset(2, 0), // Offset of the shadow
                          //   ),
                          // ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Stack(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Positioned(
                                  top: 20,
                                  right: 10,
                                  child: Image.asset(
                                    "assets/icon/market.png",
                                    height: 55,
                                  )),
                              const Positioned(
                                left: 10,
                                top: 8,
                                child: Text(
                                  "Market Place",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.titleText,
                                    fontFamily: objectApp.fontApp,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 10,
                                top: 35,
                                child: Text(
                                  "Temukan barang\nsesuai kebutuhan",
                                  style: TextStyle(
                                    color: AppColors.titleText.withOpacity(0.6),
                                    // fontFamily: objectApp.fontApp,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // const Padding(padding: EdgeInsets.all(8)),
                Column(
                    children: List.generate(3, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: 0, top: index == 0 ? 0 : 10, left: 10),
                    child: InkWell(
                      onTap: () {
                        homePageC.onTapSettingMenuV2(index, context);
                      },
                      child: Container(
                        width: size(context).width / 2.2,
                        height: index == 0
                            ? size(context).width / 2.4
                            : size(context).width / 4.5,
                        decoration: const BoxDecoration(
                          color: AppColors.themeColorV2light,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.5),
                          //     spreadRadius: 2,
                          //     blurRadius: 1,
                          //     offset: const Offset(2, 0), // Offset of the shadow
                          //   ),
                          // ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Stack(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Positioned(
                                  bottom: 10,
                                  right: 5,
                                  child: Image.asset(
                                    IconTitleMenuV2[index],
                                    height: index == 0 ? 90 : 60,
                                  )),
                              Positioned(
                                left: 20,
                                top: index == 0 ? 20 : 8,
                                child: Text(
                                  TitleMenuV2[index].toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: AppColors.titleText,
                                    fontFamily: objectApp.fontApp,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                top: index == 0 ? 45 : 35,
                                child: Text(
                                  descTitleMenuV2[index],
                                  style: TextStyle(
                                    color: AppColors.titleText.withOpacity(0.6),
                                    // fontFamily: objectApp.fontApp,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
