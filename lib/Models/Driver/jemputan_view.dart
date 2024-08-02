import 'package:e_tikbroh_yok/Controllers/DriverController/daftar_jemputan_controller.dart';
import 'package:e_tikbroh_yok/Controllers/DriverController/daftar_riwayat_jemputan_controller.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Models/Driver/daftar_jemputan_driver_view.dart';
import 'package:e_tikbroh_yok/Models/Driver/daftar_riwayat_jemputan_driver_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JemputanDriver extends StatelessWidget {
  const JemputanDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DaftarJemputanDriverController());
    Get.lazyPut(() => DaftarRiwayatJemputanDriverController());
    final driverC = Get.find<DaftarJemputanDriverController>();
    driverC.tab.value = 0;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            child: AppBar(
              backgroundColor: AppColors.themeColor,
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: "Jemputan",
                  ),
                  Tab(
                    text: "Riwayat",
                  )
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            DaftarJemputanDriverView(),
            DaftarRiwayatJemputanDriverView()
          ],
        ),
      ),
    );
  }
}
