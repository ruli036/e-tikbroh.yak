import 'package:e_tikbroh_yok/Controllers/home_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Models/Home/home_slide_iklan.dart';
import 'package:e_tikbroh_yok/Models/Home/home_slide_iklan_mitra.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageMenuView extends StatelessWidget {
  const HomePageMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homePageC = Get.find<HomeController>();
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: size(context).height - (size(context).height / 7),
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
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Obx(
                () => Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 10,
                  spacing: 10,
                  children: List.generate(
                      homePageC.level.value == "member"
                          ? IconMenu.length
                          : IconMenuDriver.length, (index) {
                    return InkWell(
                      onTap: () {
                        homePageC.onTapSettingMenu(index, context);
                      },
                      child: Container(
                        width: size(context).width / 3.4,
                        height: size(context).height / 7,
                        decoration: BoxDecoration(
                          color: AppColors.colorMenu.withOpacity(0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: size(context).width / 12,
                                height: 35,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(
                                            0, 3), // Offset of the shadow
                                      ),
                                    ],
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.gradientcolor1,
                                        AppColors.gradientcolor3,
                                        AppColors.gradientcolor2
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Center(
                                    child: homePageC.level.value == "member"
                                        ? IconMenu[index]
                                        : IconMenuDriver[index]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  homePageC.level.value == "member"
                                      ? TitleMenu[index]
                                          .toString()
                                          .toTitleCase()
                                      : TitleMenuDriver[index]
                                          .toString()
                                          .toTitleCase(),
                                  style: const TextStyle(
                                    color: AppColors.fontTitleColor,
                                    fontFamily: objectApp.fontApp,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                  'Katalog Sampah',
                  style: TextStyle(
                      color: AppColors.themeColor,
                      fontFamily: objectApp.fontApp,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ItemPageSlideIklan(),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                // child: Align(
                //   alignment: Alignment.centerRight,
                //   child: Text(
                //     'Semua',
                //     style: TextStyle(
                //         color: AppColors.themeColor,
                //         fontFamily: objectApp.fontApp,
                //         fontSize: 18,
                //         fontWeight: FontWeight.bold),
                //   ),
                // ),
              ),
              ItemPageSlideIklanMitra(),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
            ],
          ),
        ),
      ),
    );
  }
}
