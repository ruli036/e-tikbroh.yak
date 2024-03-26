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
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.only(top: 10, right: 10, left: 20),
              child: Align(
                alignment: Alignment.topCenter,
                child: InkWell(
                  onTap: () {
                    profileC.editImage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 50,
                    width: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        alignment: Alignment.center,
                        imageUrl: profileC.homeC.foto.value,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: ImagesLoading(
                            height: 44,
                            width: 50,
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
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${profileC.homeC.nama.value.toString().toTitleCase()}',
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: AppColors.titleText,
                              fontFamily: objectApp.fontApp,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 5)),
                    Text(
                      '${profileC.homeC.email.toString()}\n${profileC.homeC.nohp.toString()}',
                      style: const TextStyle(
                          color: AppColors.titleText,
                          // fontFamily: objectApp.fontApp,
                          fontSize: 14,
                          // fontWeight: FontWeight.bold
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 5)),
                    Container(
                        decoration: const BoxDecoration(
                            color: AppColors.themeColor,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          '${profileC.homeC.level.value.toCapitalized()}',
                          style: const TextStyle(
                            color: AppColors.white,
                            fontFamily: objectApp.fontApp,
                            fontSize: 11,
                          ),
                        ),
                      ),
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
                  color: AppColors.titleText,
                  size: 20,
                )),
          ),
        ],
      ),
    );
  }
}
