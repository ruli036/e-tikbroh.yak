import 'package:e_tikbroh_yok/Controllers/home_controller.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Models/Home/home_slide_iklan.dart';
import 'package:e_tikbroh_yok/Models/Home/home_slide_iklan_mitra.dart';
import 'package:e_tikbroh_yok/Models/Home_v2/katalog.dart';
import 'package:e_tikbroh_yok/Models/Home_v2/page_menu.dart';
import 'package:e_tikbroh_yok/Models/Home_v2/page_top.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';



class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homePageC = Get.find<HomeController>();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.themeColor, // Set your desired color here
      statusBarIconBrightness: Brightness.light, // or Brightness.dark
    ));
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: homePageC.refreshData,
          child:  ListView(
            children:const [
              TopView(),
              PageMenuView(),
              KatalogView(),
              SizedBox(height: 50,)
            ],
          )
        ),
      ),
    );
  }
  }

