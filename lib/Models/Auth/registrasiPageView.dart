import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/Auth/registerController.dart';
import '../../Helpers/helpers.dart';

class RegistrasiPageView extends StatelessWidget {
  const RegistrasiPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingPassC = Get.find<RegitrasiController>();
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Container(
            height: size(context).height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Container(
                    height: size(context).height /
                        (keyboardIsVisible(context) ? 6 : 8),
                  ),
                  AnimatedContainer(
                    height: keyboardIsVisible(context)
                        ? 0
                        : size(context).width / 2.5,
                    duration: const Duration(milliseconds: 500),
                    child: Image.asset(
                      objectApp.logoAlert,
                      scale: 2,
                    ),
                  ),
                  const Center(
                      child: Text(
                    'Set your password',
                    style: TextStyle(
                        color: AppColors.fontTitleColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: objectApp.fontApp,
                        fontSize: 24),
                  )),
                  Container(
                      child: Form(
                    key: settingPassC.keyform,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 20),
                      child: Column(
                        children: [
                          Obx(
                            () => TextFormField(
                              controller: settingPassC.password,
                              validator: (e) {
                                RegExp regex = RegExp(r'^.{6,12}$');
                                if (e!.isEmpty) {
                                  return 'Masukkan password';
                                } else if (!regex.hasMatch(e)) {
                                  return 'password minimal 6 - 12 karakter';
                                }
                                return null;
                              },
                              obscureText: settingPassC.lihatpass.value,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    AppColors.filledColor.withOpacity(0.5),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                                labelText: 'Password ',
                                labelStyle: TextStyle(
                                    fontSize: objectApp.labelFont,
                                    color: AppColors.hinttext),
                                prefixIcon: Icon(
                                    settingPassC.lihatpass.value == false
                                        ? Icons.lock_open
                                        : Icons.lock,
                                    color: AppColors.iconColor1),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      settingPassC.lihatpass.value == false
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColors.iconColor1),
                                  onPressed: () => settingPassC.lihatpassword(),
                                ),
                                //     border:const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 20)),
                          Obx(
                            () => TextFormField(
                              controller: settingPassC.confirmPassword,
                              validator: (e) {
                                if (e!.isEmpty) {
                                  return 'Masukkan Confirmasi Password ';
                                }
                                return null;
                              },
                              obscureText: settingPassC.lihatpass.value,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    AppColors.filledColor.withOpacity(0.5),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                                labelText: 'Konfirmasi Password ',
                                labelStyle: TextStyle(
                                    fontSize: objectApp.labelFont,
                                    color: AppColors.hinttext),
                                prefixIcon: Icon(
                                    settingPassC.lihatpass.value == false
                                        ? Icons.lock_open
                                        : Icons.lock,
                                    color: AppColors.iconColor1),
                                // border:const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 10)),
                          Container(
                              height: 50,
                              width: size(context).width,
                              decoration: const BoxDecoration(
                                  color: AppColors.buttonColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              // ignore: deprecated_member_use
                              child: TextButton(
                                onPressed: () {
                                  settingPassC.validasi();
                                },
                                child: const Text("SUBMIT",
                                    style: TextStyle(color: Colors.white)),
                              )),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
          BagroundAuthentication(
            bottomview: true,
            buttonview: keyboardIsVisible(context) ? false : true,
            onTap: () {
              Get.offAllNamed('/login');
            },
            text: "Sudah Punya Akun?",
            title: 'Login',
          )
        ],
      ),
    ));
  }
}
