import 'package:e_tikbroh_yok/Controllers/profile_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GantiPasswordView extends StatelessWidget {
  const GantiPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ItemGantiPasswordPage());
  }
}

class ItemGantiPasswordPage extends StatelessWidget {
  const ItemGantiPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(keyboardIsVisible(context));
    final settingC = Get.find<ProfileController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ganti Password"),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.themeColor,
      ),
      body: Stack(
        children: [
          const ItemBagroundHome(),
          SizedBox(
            height: size(context).height,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                AnimatedContainer(
                  height: keyboardIsVisible(context)
                      ? 50
                      : size(context).width / 2.5,
                  duration: const Duration(milliseconds: 500),
                  child: Image.asset(
                    objectApp.logoApp,
                    scale: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2,
                                spreadRadius: 1.1,
                                offset: Offset(0, 1))
                          ]),
                      child: Obx(
                        () => Form(
                          key: settingC.keyform,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 20),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: settingC.passwordlama,
                                  validator: (e) {
                                    RegExp regex = RegExp(r'^.{6,12}$');
                                    if (e!.isEmpty) {
                                      return 'Masukkan password lama anda';
                                    } else if (!regex.hasMatch(e)) {
                                      return 'password minimal 6 - 12 karakter';
                                    }
                                    return null;
                                  },
                                  obscureText: settingC.lihatpass.value,
                                  decoration: InputDecoration(
                                    labelText: 'Password Lama ',
                                    labelStyle: TextStyle(
                                        fontSize: objectApp.labelFont),
                                    prefixIcon: Icon(
                                        settingC.lihatpass.value == false
                                            ? Icons.lock_clock_sharp
                                            : Icons.lock,
                                        color: AppColors.iconColor1),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                          settingC.lihatpass.value == false
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: AppColors.iconColor1),
                                      onPressed: () => settingC.lihatpassword(),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: settingC.password,
                                  validator: (e) {
                                    RegExp regex = RegExp(r'^.{6,12}$');
                                    if (e!.isEmpty) {
                                      return 'Masukkan password baru Anda';
                                    } else if (!regex.hasMatch(e)) {
                                      return 'password minimal 6 - 12 karakter';
                                    }
                                    return null;
                                  },
                                  obscureText: settingC.lihatpass.value,
                                  decoration: InputDecoration(
                                    labelText: 'Password ',
                                    labelStyle: TextStyle(
                                        fontSize: objectApp.labelFont),
                                    prefixIcon: Icon(
                                        settingC.lihatpass.value == false
                                            ? Icons.lock_open
                                            : Icons.lock,
                                        color: AppColors.iconColor1),
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 10)),
                                TextFormField(
                                  controller: settingC.confirmPassword,
                                  validator: (e) {
                                    RegExp regex = RegExp(r'^.{6,12}$');
                                    if (e!.isEmpty) {
                                      return 'Masukkan konfirmasi password ';
                                    } else if (!regex.hasMatch(e)) {
                                      return 'password minimal 6 - 12 karakter';
                                    }
                                    return null;
                                  },
                                  obscureText: settingC.lihatpass.value,
                                  decoration: InputDecoration(
                                    labelText: 'Konfirmasi Password ',
                                    labelStyle: TextStyle(
                                        fontSize: objectApp.labelFont),
                                    prefixIcon: Icon(
                                        settingC.lihatpass.value == false
                                            ? Icons.lock_open
                                            : Icons.lock,
                                        color: AppColors.iconColor1),
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 10)),
                                Container(
                                    height: 50,
                                    width: size(context).width,
                                    decoration: const BoxDecoration(
                                        color: AppColors.buttonColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    // ignore: deprecated_member_use
                                    child: TextButton(
                                      onPressed: () {
                                        settingC.validasi();
                                      },
                                      child: const Text("Ganti Password",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    )),
                                const Padding(padding: EdgeInsets.all(10)),
                              ],
                            ),
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
