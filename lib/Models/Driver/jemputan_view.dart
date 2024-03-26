import 'package:e_tikbroh_yok/Controllers/DriverController/daftar_jemputan_controller.dart';
import 'package:e_tikbroh_yok/Controllers/DriverController/daftar_riwayat_jemputan_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Models/Driver/daftar_jemputan_driver_view.dart';
import 'package:e_tikbroh_yok/Models/Driver/daftar_riwayat_jemputan_driver_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class JemputanDriver extends StatelessWidget {
  const JemputanDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DaftarJemputanDriverController());
    Get.lazyPut(() => DaftarRiwayatJemputanDriverController());
    final driverC = Get.find<DaftarJemputanDriverController>();
    driverC.tab.value = 0;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.white, // Set your desired color here
      statusBarIconBrightness: Brightness.dark, // or Brightness.dark
    ));
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title:const Text(
            "Jemput Sampah",
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
                      'Riwayat',
                      style: TextStyle(
                        color: AppColors.titleText,
                        fontFamily: objectApp.fontApp,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Jemputan',
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
        body:const  TabBarView(
          children: [
            DaftarRiwayatJemputanDriverView(),
            DaftarJemputanDriverView(),
          ],
        ),
      ),
    );
  }
}
