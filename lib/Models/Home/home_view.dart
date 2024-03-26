import 'package:e_tikbroh_yok/Controllers/home_controller.dart';
import 'package:e_tikbroh_yok/Models/Home/home_page_menu.dart';
import 'package:e_tikbroh_yok/Models/Home/home_page_top.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helpers/helpers.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homePageC = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: AppColors.themeColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: homePageC.refreshData,
          child: ListView(
            children: [HomePageTopView(), HomePageMenuView()],
          ),
        ),
      ),
    );
  }
}
