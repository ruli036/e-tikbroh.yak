import 'package:e_tikbroh_yok/Controllers/profile_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProfilePageItem extends StatelessWidget {
  const ProfilePageItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileC = Get.find<ProfileController>();
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2), // Offset of the shadow
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "CATATAN KEUANGAN ",
                  style: TextStyle(
                      fontFamily: objectApp.fontApp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.fontColor,
                      fontSize: 14),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/mutasi-poin');
                  },
                  child: const Text(
                    "Lihat Detail ",
                    style: TextStyle(
                        fontFamily: objectApp.fontApp,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 0)),
            Container(
              height: 110,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 1,
                      offset: const Offset(0, 3), // Offset of the shadow
                    ),
                  ],
                  color: AppColors.themeColor,
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: 5, bottom: 5),
                                      child: FaIcon(
                                        FontAwesomeIcons.arrowDown,
                                        textDirection: TextDirection.rtl,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Pemasukan',
                                      style: TextStyle(
                                        color: AppColors.textColor,
                                        fontFamily: objectApp.fontApp,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Rp ${Helpers().formater.format(int.parse(profileC.homeC.modelPointDashboart!.masuk.rupiah.toString()))}",
                                  style: const TextStyle(
                                      color: AppColors.textColor,
                                      fontFamily: objectApp.fontApp,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${profileC.homeC.modelPointDashboart!.masuk.poin} poin",
                                  style: const TextStyle(
                                    color: AppColors.textColor,
                                    fontFamily: objectApp.fontApp,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Container(
                            width: 2,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: 5, bottom: 5),
                                      child: FaIcon(
                                        FontAwesomeIcons.arrowUp,
                                        size: 15,
                                        textDirection: TextDirection.rtl,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Pengeluaran',
                                      style: TextStyle(
                                        color: AppColors.textColor,
                                        fontFamily: objectApp.fontApp,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Rp ${Helpers().formater.format(int.parse(profileC.homeC.modelPointDashboart!.keluar.rupiah.toString()))}",
                                  style: const TextStyle(
                                      color: AppColors.textColor,
                                      fontFamily: objectApp.fontApp,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${profileC.homeC.modelPointDashboart!.keluar.poin} poin",
                                  style: const TextStyle(
                                    color: AppColors.textColor,
                                    fontFamily: objectApp.fontApp,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            fontSize: 16.0, color: Colors.black),
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Selisih ',
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontFamily: objectApp.fontApp,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text:
                                "Rp ${Helpers().formater.format(int.parse(profileC.homeC.modelPointDashboart!.selisih.rupiah.toString()))} (${profileC.homeC.modelPointDashboart!.selisih.poin} poin)",
                            style: const TextStyle(
                                color: AppColors.textColor,
                                fontFamily: objectApp.fontApp,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            const Text("PENGATURAN ",
                style: TextStyle(
                    fontFamily: objectApp.fontApp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.fontColor,
                    fontSize: 14),
                maxLines: 2),
            const Divider(
              thickness: 2,
            ),
            Obx(
              () => Expanded(
                  flex: 2,
                  child: ListView(
                      // physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                    profileC.homeC.level.value == 'member'
                        ? MenuProfile.length + 1
                        : MenuProfileDriver.length + 1,
                    (index) {
                      int jumlah = 0;
                      if (profileC.homeC.level.value == 'member') {
                        jumlah = MenuProfile.length;
                      } else {
                        jumlah = MenuProfileDriver.length;
                      }
                      if (index < jumlah) {
                        return InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${profileC.homeC.level.value == 'member' ? MenuProfile[index].toString().toTitleCase() : MenuProfileDriver[index].toString().toTitleCase()}",
                                      style: const TextStyle(
                                          fontFamily: objectApp.fontApp,
                                          color: AppColors.fontColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                      maxLines: 2),
                                  profileC.homeC.level.value == 'member'
                                      ? FaIcon(
                                          index == 0
                                              ? FontAwesomeIcons.truck
                                              : index == 1
                                                  ? FontAwesomeIcons.box
                                                  : index == 2
                                                      ? FontAwesomeIcons.store
                                                      : index == 3
                                                          ? FontAwesomeIcons
                                                              .book
                                                          : index == 4
                                                              ? FontAwesomeIcons
                                                                  .locationPinLock
                                                              : index == 5
                                                                  ? FontAwesomeIcons
                                                                      .solidImages
                                                                  : FontAwesomeIcons
                                                                      .lockOpen,
                                          size: 20,
                                          color: AppColors.iconColor1,
                                        )
                                      : FaIcon(
                                          index == 0
                                              ? FontAwesomeIcons.truck
                                              : index == 1
                                                  ? FontAwesomeIcons.box
                                                  : index == 2
                                                      ? FontAwesomeIcons.book
                                                      : index == 3
                                                          ? FontAwesomeIcons
                                                              .store
                                                          : index == 4
                                                              ? FontAwesomeIcons
                                                                  .solidImages
                                                              : FontAwesomeIcons
                                                                  .lockOpen,
                                          size: 20,
                                          color: AppColors.iconColor1,
                                        ),
                                ],
                              ),
                            ),
                            onTap: () {
                              profileC.onTapSettingMenu(index);
                            });
                      } else {
                        return Column(
                          children: [
                            InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text("Hubungi Kami",
                                          style: TextStyle(
                                              fontFamily: objectApp.fontApp,
                                              color: AppColors.fontColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                          maxLines: 2),
                                      FaIcon(
                                        FontAwesomeIcons.question,
                                        size: 20,
                                        color: AppColors.iconColor1,
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () => bukaWeb(
                                    'https://heylink.me/e-tikbroh.yak/')),
                            ElevatedButton(
                              onPressed: () => LogOut(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text("Keluar",
                                      style: TextStyle(
                                          fontFamily: objectApp.fontApp,
                                          color: AppColors.whiteButton,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                      maxLines: 2),
                                  Padding(padding: EdgeInsets.all(5)),
                                  Icon(
                                    Icons.logout,
                                    size: 25,
                                    color: AppColors.whiteButton,
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ))),
            ),
          ],
        ),
      ),
    );
  }
}
