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
        height: size(context).height - 50,
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
                        width: size(context).width / 3.5,
                        height: size(context).width / 3.5,
                        decoration:const BoxDecoration(
                          color: AppColors.themeColor,
                          borderRadius:
                               BorderRadius.all(Radius.circular(20)),
                        gradient:   LinearGradient(
                          colors: [
                            AppColors.gradientcolor3,
                            AppColors.gradientcolor1,
                            AppColors.gradientcolor2,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          // child: Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   // mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Padding(
                          //       padding: const EdgeInsets.only(bottom: 10,top: 10),
                          //       child: Text(
                          //         homePageC.level.value == "member"
                          //             ? TitleMenu[index]
                          //             .toString()
                          //             .toTitleCase()
                          //             : TitleMenuDriver[index]
                          //             .toString()
                          //             .toTitleCase(),
                          //         style: const TextStyle(
                          //           color: AppColors.textColor,
                          //           fontFamily: objectApp.fontApp,
                          //           fontWeight: FontWeight.bold,
                          //           fontSize: 14,
                          //         ),
                          //       ),
                          //     ),
                          //     Container(
                          //       width: size(context).width / 8,
                          //       height: size(context).width / 8,
                          //       decoration: BoxDecoration(
                          //         shape: BoxShape.circle,
                          //         color: Colors.amber,
                          //           boxShadow: [
                          //             BoxShadow(
                          //               color: Colors.black.withOpacity(0.2),
                          //               spreadRadius: 2,
                          //               blurRadius: 5,
                          //               offset: const Offset(
                          //                   -1, -1), // Offset of the shadow
                          //             ),
                          //           ],
                          //            ),
                          //       child: Center(
                          //           child: homePageC.level.value == "member"
                          //               ? IconMenu[index]
                          //               : IconMenuDriver[index]),
                          //     ),
                          //
                          //   ],
                          // ),
                          child: Stack(
                            children: [
                             ClipPath(
                                  clipper: TriangleClipper(),
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      color: AppColors.gradientcolor2.withOpacity(0.5), // Sesuaikan dengan warna segitiga yang diinginkan
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0)),
                                    ),
                                    width: size(context).width / 6,
                                    height: size(context).width / 6 // Sesuaikan dengan tinggi segitiga yang diinginkan
                                  ),
                                ),
                              Positioned(
                                left: 15,
                                top: 15,
                                child: Text(
                                  homePageC.level.value == "member"
                                      ? TitleMenu[index]
                                      .toString()
                                      .toTitleCase()
                                      : TitleMenuDriver[index]
                                      .toString()
                                      .toTitleCase(),
                                  style: const TextStyle(
                                    color: AppColors.textColor,
                                    fontFamily: objectApp.fontApp,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 15,
                                bottom: 15,
                                child: Container(
                                  width: size(context).width / 8,
                                  height: size(context).width / 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 4,color: Colors.white),
                                    gradient:const LinearGradient(
                                      colors: [Colors.yellow, Colors.amber],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 3,
                                        offset: const Offset(
                                            0, 0), // Offset of the shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                      child: homePageC.level.value == "member"
                                          ? IconMenu[index]
                                          : IconMenuDriver[index]),
                                ),
                              ),

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
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}