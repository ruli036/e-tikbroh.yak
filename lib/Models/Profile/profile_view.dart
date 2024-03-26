import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Models/Profile/profile_page_item.dart';
import 'package:e_tikbroh_yok/Models/Profile/profile_page_top.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.white, // Set your desired color here
      statusBarIconBrightness: Brightness.dark, // or Brightness.dark
    ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          "Profilku",
          style: TextStyle(
              color: AppColors.titleText, fontFamily: objectApp.fontApp),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: const [
            ProfilePageTop(),
            Expanded(child: ProfilePageItem())
          ],
        ),
      ),
    );
  }
}
