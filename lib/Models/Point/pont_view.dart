import 'package:e_tikbroh_yok/Controllers/point_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Models/Point/penukaran_poin_view.dart';
import 'package:e_tikbroh_yok/Models/Point/riwayat_penukaran_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PointView extends StatelessWidget {
  const PointView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PointController());
    final pointC = Get.find<PointController>();
    pointC.tab.value = 0;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.white, // Set your desired color here
      statusBarIconBrightness: Brightness.dark, // or Brightness.dark
    ));
    return  DefaultTabController(
        length: 2,
        initialIndex: pointC.initialTabIndex.value,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.white,
              title:const Text(
                "Tukar Poin",
                style: TextStyle(
                  color: AppColors.titleText,
                  fontFamily: objectApp.fontApp,
                ),
              ),
            bottom:const PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Align(
                alignment: Alignment.centerLeft, // Align tabs to the left
                child:  TabBar(
                  tabs: [
                    Tab(
                      child: Text(
                        'Produk',
                        style: TextStyle(
                          color: AppColors.titleText,
                          fontFamily: objectApp.fontApp,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Riwayat',
                        style: TextStyle(
                          color: AppColors.titleText,
                          fontFamily: objectApp.fontApp,
                          fontSize: 16,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              DaftarPenukaranPointView(),
              RiwayatPenukaranPointView(),
            ],
          ),
        ),
      );
  }
}
