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
    return Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Akun",
              style: TextStyle(
                  fontFamily: objectApp.fontApp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.titleText,
                  fontSize: 16),
            ),
            const Divider(height: 5,thickness: 2,),
            Expanded(
                child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 8),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed('/mutasi-poin');
                    },
                    child: Row(
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 10, right: 10, bottom: 10),
                          child: FaIcon(
                            FontAwesomeIcons.coins,
                            size: 25,
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            "Poin",
                            style: TextStyle(
                                fontFamily: objectApp.fontApp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.titleText,
                                fontSize: 14),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              color: AppColors.themeColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 5, bottom: 5),
                            child: Text(
                              "${profileC.homeC.modelPointDashboart!.selisih.poin} Poin",
                              style: const TextStyle(
                                  color: AppColors.white, fontSize: 11),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: FaIcon(
                            FontAwesomeIcons.angleRight,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 0,thickness: 1,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () {
                      profileC.homeC.onItemTapped(1);
                    },
                    child: Row(
                      children: const [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10, right: 10, bottom: 10),
                          child: FaIcon(
                            FontAwesomeIcons.truck,
                            size: 22,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Riwayat Jemput Sampah",
                            style: TextStyle(
                                fontFamily: objectApp.fontApp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.titleText,
                                fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: FaIcon(
                            FontAwesomeIcons.angleRight,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 0,thickness: 1,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed('mitra-view');
                    },
                    child: Row(
                      children: const [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10, right: 10, bottom: 10),
                          child: FaIcon(
                            FontAwesomeIcons.solidHandshake,
                            size: 22,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Mitra",
                            style: TextStyle(
                                fontFamily: objectApp.fontApp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.titleText,
                                fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: FaIcon(
                            FontAwesomeIcons.angleRight,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 0,thickness: 1,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () {
                      profileC.homeC.onItemTapped(2);
                    },
                    child: Row(
                      children: const [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10, right: 10, bottom: 10),
                          child: FaIcon(
                            FontAwesomeIcons.book,
                            size: 22,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Katalog",
                            style: TextStyle(
                                fontFamily: objectApp.fontApp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.titleText,
                                fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: FaIcon(
                            FontAwesomeIcons.angleRight,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 0,thickness: 1,),
                profileC.homeC.level.value != "member"
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: InkWell(
                          onTap: () {
                            cekKoneksi(() => Get.toNamed('/lokasi-jemputan'));
                          },
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10, right: 10, bottom: 10),
                                child: FaIcon(
                                  FontAwesomeIcons.mapLocationDot,
                                  size: 22,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Lokasi Jemputan",
                                  style: TextStyle(
                                      fontFamily: objectApp.fontApp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.titleText,
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: FaIcon(
                                  FontAwesomeIcons.angleRight,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                profileC.homeC.level.value != "member"
                    ? const SizedBox()
                    : const Divider(height: 0,thickness: 1,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () {
                      profileC.editImage();
                    },
                    child: Row(
                      children: const [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10, right: 10, bottom: 10),
                          child: FaIcon(
                            FontAwesomeIcons.images,
                            size: 22,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Ganti Foto Profile",
                            style: TextStyle(
                                fontFamily: objectApp.fontApp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.titleText,
                                fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: FaIcon(
                            FontAwesomeIcons.angleRight,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 0,thickness: 1,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed('/ganti-pass-page', arguments: true);
                    },
                    child: Row(
                      children: const [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10, right: 10, bottom: 10),
                          child: FaIcon(
                            FontAwesomeIcons.lockOpen,
                            size: 22,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Ganti Password",
                            style: TextStyle(
                                fontFamily: objectApp.fontApp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.titleText,
                                fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: FaIcon(
                            FontAwesomeIcons.angleRight,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 0,thickness: 1,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () {
                      bukaWeb('https://heylink.me/e-tikbroh.yak/');
                    },
                    child: Row(
                      children: const [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10, right: 10, bottom: 10),
                          child: FaIcon(
                            FontAwesomeIcons.userTie,
                            size: 22,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Hubungi Kami",
                            style: TextStyle(
                                fontFamily: objectApp.fontApp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.titleText,
                                fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: FaIcon(
                            FontAwesomeIcons.angleRight,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 0,thickness: 1,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10,top: 15),
                  child: InkWell(
                    onTap: () => LogOut(),
                    child: Container(
                      height: 40,
                      decoration: const BoxDecoration(
                          color: AppColors.themeColor,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "LOGOUT",
                            style: TextStyle(
                              fontFamily: objectApp.fontApp,
                              color: AppColors.whiteButton,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            maxLines: 2,
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.logout,
                            size: 20,
                            color: AppColors.whiteButton,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),

          ],
        ));
  }
}
