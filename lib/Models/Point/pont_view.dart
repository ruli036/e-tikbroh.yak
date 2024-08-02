import 'package:e_tikbroh_yok/Controllers/point_controller.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Models/Point/penukaran_poin_view.dart';
import 'package:e_tikbroh_yok/Models/Point/riwayat_penukaran_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PointView extends StatelessWidget {
  const PointView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PointController());
    final pointC = Get.find<PointController>();
    pointC.tab.value = 0;
    return Obx(
      () => DefaultTabController(
        length: 2,
        initialIndex: pointC.initialTabIndex.value,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              child: AppBar(
                backgroundColor: AppColors.themeColor,
                bottom: const TabBar(
                  tabs: [
                    Tab(
                      text: 'Daftar Produk',
                    ),
                    Tab(
                      text: 'Riwayat',
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: const TabBarView(
            children: [DaftarPenukaranPointView(), RiwayatPenukaranPointView()],
          ),
        ),
      ),
    );
  }
}
