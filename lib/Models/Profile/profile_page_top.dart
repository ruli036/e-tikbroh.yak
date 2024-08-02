import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/profile_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Helpers/widgets.dart';

class ProfilePageTop extends StatelessWidget {
  const ProfilePageTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileC = Get.find<ProfileController>();
    return Container(
      height: 100,
      color: AppColors.bagroudHome,
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${profileC.homeC.nama.value.toString().toTitleCase()} \n',
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: AppColors.fontTitleColor,
                                fontFamily: objectApp.fontApp,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.green,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${profileC.homeC.level.value.toCapitalized()}',
                                  style: const TextStyle(
                                    color: AppColors.textColor,
                                    fontFamily: objectApp.fontApp,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 5)),
                      Text(
                        '${profileC.homeC.email.toString()}',
                        style: const TextStyle(
                            color: AppColors.fontColor,
                            fontFamily: objectApp.fontApp,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 5)),
                      Text(
                        profileC.homeC.nohp.toString(),
                        style: const TextStyle(
                            color: AppColors.fontColor,
                            fontFamily: objectApp.fontApp,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: IconButton(
                  onPressed: () {
                    profileC.email.text = GetStorage().read(STORAGE_EMAIL);
                    profileC.namaUser.text = GetStorage().read(STORAGE_NAMA);
                    profileC.noHp.text = GetStorage().read(STORAGE_NO_HP);
                    Get.defaultDialog(
                        title: "Ubah Profil!",
                        content: const FormEditUser(),
                        confirmTextColor: Colors.white,
                        textCancel: "Close",
                        textConfirm: "Submit",
                        onConfirm: () {
                          profileC.validasiEditUser();
                        });
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.pencil,
                    color: AppColors.buttonColor,
                    size: 20,
                  )),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.only(top: 10, right: 10),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: InkWell(
                    onTap: () {
                      profileC.editImage();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: Colors.white, width: 3)),
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: CachedNetworkImage(
                          alignment: Alignment.center,
                          imageUrl: profileC.homeC.foto.value,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: ImagesLoading(
                              height: 54,
                              width: 60,
                            ),
                          ),
                          fit: BoxFit.cover,
                          width: size(context).width,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
