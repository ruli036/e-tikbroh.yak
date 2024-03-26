import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/Auth/lupaPassController.dart';
import '../../../Helpers/helpers.dart';
import '../../../Helpers/widgets.dart';

class LupaPasswordPageView extends StatelessWidget {
  const LupaPasswordPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lupaPassC = Get.find<LupaPasswordController>();
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
                  height: size(context).height / 6,
                ),
                AnimatedContainer(
                  height: keyboardIsVisible(context)
                      ? size(context).width / 4
                      : size(context).width / 2.5,
                  duration: const Duration(milliseconds: 500),
                  child: Image.asset(
                    objectApp.logoAlert,
                    scale: 2,
                  ),
                ),
                const Center(
                    child: Text(
                  'Reset Password!',
                  style: TextStyle(
                      color: AppColors.fontTitleColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: objectApp.fontApp,
                      fontSize: 24),
                )),
                Form(
                  key: lupaPassC.keyform,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: lupaPassC.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (e) {
                            if (e!.isEmpty) {
                              return 'Masukkan Email Anda';
                            } else if (emailValidate(e)) {
                              return 'Email Anda Tidak Valid';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.filledColor.withOpacity(0.5),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                            labelText: 'Masukkan Email',
                            labelStyle: TextStyle(
                                fontSize: objectApp.labelFont,
                                color: AppColors.fontColor),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: AppColors.iconColor1,
                            ),
                            // border:const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20),)
                            // ),
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
                            child: TextButton(
                              onPressed: () {
                                lupaPassC.validasi();
                              },
                              child: const Text("SUBMIT",
                                  style: TextStyle(color: Colors.white)),
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        BagroundAuthentication(
            onTap: () {
              Get.offAllNamed('/login');
            },
            text: "Sudah Punya Akun?",
            title: 'Login',
            bottomview: true,
            buttonview: keyboardIsVisible(context) ? false : true)
      ],
    )));
  }
}
