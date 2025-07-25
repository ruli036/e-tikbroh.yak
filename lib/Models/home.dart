import 'package:e_tikbroh_yok/Controllers/home_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Models/Driver/jemputan_view.dart';
import 'package:e_tikbroh_yok/Models/OrderJemputan/jemputan_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homePageC = Get.find<HomeController>();
    return WillPopScope(
      onWillPop: () => homePageC.onWillPop(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Obx(() =>   homePageC.level.value == "member"
                ?widgetOptions
                .elementAt(homePageC.selectedIndex.value):widgetOptionsDriver
                .elementAt(homePageC.selectedIndex.value))),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: Transform.scale(
          scale: 1.1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: FloatingActionButton(
              backgroundColor:AppColors.buttonColor ,
              // heroTag: 'btmHome',
              child: const FaIcon(
                FontAwesomeIcons.truck,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                if(homePageC.level.value == "member"){
                  homePageC.onItemTapped(1);
                }else{
                  homePageC.onItemTapped(1);
                }
              },
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: Obx(
            () => BottomAppBar(
                shape: const CircularNotchedRectangle(),
                notchMargin: 15,
                color: AppColors.white,
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
                          ? AppColors.color4
                          : Colors.grey,
                      tooltip: TitleBottomMenu[index].toString().toTitleCase(),
                      onPressed: () {
                        if(index == 0){
                          homePageC.onItemTapped(index);
                        }else{
                          homePageC.onItemTapped(4);
                        }
                      },
                    );
                  }),
                )),
          ),
        ),
      ),
    );
  }
}
