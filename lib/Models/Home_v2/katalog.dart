import 'package:e_tikbroh_yok/Controllers/home_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helpers/helpers.dart';

class KatalogView extends StatelessWidget {
  const KatalogView({super.key});

  @override
  Widget build(BuildContext context) {
    final homePageC = Get.find<HomeController>();
    return Container(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 25, top: 15, bottom: 5, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Katalog',
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: AppColors.titleText,
                      fontFamily: objectApp.fontApp,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
                TextButton(
                  onPressed: () {
                    homePageC.onItemTapped(2);
                  },
                  child: const Text(
                    'Lihat Semua',
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.themeColor,
                        fontFamily: objectApp.fontApp,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                )
              ],
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(4, (index) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: 10,
                      top: 10,
                      left: index == 0 ? 20 : 0,
                      right: index == 3 ? 20 : 0),
                  child: Column(
                    children: [
                      InkWell(
                        child: Container(
                          width: size(context).width / 5,
                          height: size(context).width / 5,
                          decoration: const BoxDecoration(
                            color: AppColors.bg,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.withOpacity(0.5),
                            //     spreadRadius: 2,
                            //     blurRadius: 1,
                            //     offset: const Offset(2, 0),
                            //   ),
                            // ],
                          ),
                          child: Image.asset(
                            IconTitleKatalog[index],
                            height: 150,
                            // fit: BoxFit.cover,
                          ),
                        ),
                        onTap: () {
                          homePageC.onItemTapped(2);
                        },
                      ),
                      Text(
                        TitleKatalog[index].toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.titleText,
                          fontFamily: objectApp.fontApp,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                );
              })),
        ],
      ),
    );
  }
}
