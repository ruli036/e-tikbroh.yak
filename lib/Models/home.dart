import 'package:e_tikbroh_yok/Controllers/home_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homePageC = Get.find<HomeController>();
    return WillPopScope(
      onWillPop: () => homePageC.onWillPop(context),
      child: Scaffold(
        backgroundColor: Colors.green,
        body: SafeArea(
            child: Obx(() => homePageC.level.value == "member"
                ? widgetOptions.elementAt(homePageC.selectedIndex.value)
                : widgetOptionsDriver
                    .elementAt(homePageC.selectedIndex.value))),
        bottomNavigationBar: Obx(
          () => BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 10,
              color: AppColors.themeColor,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                    homePageC.level.value == "member"
                        ? IconBottomMenu.length
                        : IconBottomMenuDriver.length, (index) {
                  return IconButton(
                    icon: homePageC.level.value == "member"
                        ? IconBottomMenu[index]
                        : IconBottomMenuDriver[index],
                    color: homePageC.selectedIndex.toInt() == index
                        ? AppColors.colorMenu2.withOpacity(0.3)
                        : Colors.white,
                    tooltip: TitleBottomMenu[index].toString().toTitleCase(),
                    onPressed: () {
                      homePageC.onItemTapped(index);
                    },
                  );
                }),
              )),
        ),
      ),
    );
  }
}
