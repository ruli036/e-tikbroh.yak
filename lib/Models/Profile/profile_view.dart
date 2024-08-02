import 'package:e_tikbroh_yok/Models/Profile/profile_page_item.dart';
import 'package:e_tikbroh_yok/Models/Profile/profile_page_top.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
