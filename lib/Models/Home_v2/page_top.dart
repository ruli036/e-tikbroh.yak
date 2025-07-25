import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/home_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Models/Home/home_slide_iklan.dart';
import 'package:e_tikbroh_yok/Models/Home/home_slide_iklan_mitra.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Helpers/widgets.dart';

class TopView extends StatelessWidget {
  const TopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homePageC = Get.find<HomeController>();
    return Container(
      color: AppColors.bg,
      child: Stack(
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: AppColors.themeColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
          ),
          Container(
            // color: Colors.black,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 20, left: 25, right: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                    children: <TextSpan>[
                                      const TextSpan(
                                        text: 'Selamat Datang \n',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontFamily: 'OpenSansReguler',
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${homePageC.nama.value.toString().toTitleCase()}',
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: AppColors.white,
                                          fontFamily: objectApp.fontApp,
                                          fontSize: 26,
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Obx(
                                () => RichText(
                                  textAlign: TextAlign.right,
                                  text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                    children: <TextSpan>[
                                      const TextSpan(
                                        text: 'Poin Anda \n',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontFamily: 'OpenSansReguler',
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${homePageC.loading.value == false ? Helpers().formater.format(int.parse(homePageC.modelPointDashboart!.selisih.poin.toString())) : 0}',
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: AppColors.white,
                                            fontFamily: objectApp.fontApp,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5, left: 25, right: 25, bottom: 10),
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      validator: (e) {
                        if (e!.isEmpty) {
                          return 'Pencarian!';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        prefixIcon: Icon(Icons.search),
                        labelText: 'Pencarian ',
                        labelStyle: TextStyle(
                            fontSize: objectApp.labelFont,
                            color: AppColors.hinttext),
                      ),
                    ),
                  ),
                ),
                ItemPageSlideIklanMitra(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class VerticalDottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white // Set the color of the vertical dotted line
      ..strokeWidth = 2.0 // Set the width of the vertical dotted line
      ..strokeCap = StrokeCap.round;

    const double dashHeight = 5.0; // Adjust the length of each dash
    const double dashSpace = 5.0; // Adjust the space between dashes

    double startY = 0.0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(0.0, startY),
        Offset(0.0, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
