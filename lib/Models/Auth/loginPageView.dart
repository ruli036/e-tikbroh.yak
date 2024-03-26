import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Controllers/Auth/loginController.dart';
import '../../Helpers/widgets.dart';

class LoginPageView extends StatelessWidget {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginC = Get.find<LoginController>();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.white, // Set your desired color here
      statusBarIconBrightness: Brightness.dark, // or Brightness.dark
    ));
    return Scaffold(
        body: SafeArea(
            child: Stack(
          children: [
            Container(
              // color: Colors.grey,
              child: ListView(
                children: [
                  Container(
                    height: size(context).height /
                        (keyboardIsVisible(context) ? 20 : 10),
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
                  Form(
                    key: loginC.keyform,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 20),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: loginC.email,
                            validator: (e) {
                              if (e!.isEmpty) {
                                return 'Masukkan email!';
                              } else if (emailValidate(e)) {
                                return 'email yang anda masukkan tidak valid!';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.filledColor,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none),
                              labelText: 'Email ',
                              labelStyle: TextStyle(
                                  fontSize: objectApp.labelFont,
                                  color: AppColors.hinttext),
                              prefixIcon: const Icon(Icons.email,
                                  color: AppColors.iconColor1),

                              //     border:const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 20)),
                          Obx(
                            () => TextFormField(
                              controller: loginC.password,
                              validator: (e) {
                                if (e!.isEmpty) {
                                  return 'Masukkan password!';
                                }
                                return null;
                              },
                              obscureText: loginC.lihatpass.value,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    AppColors.filledColor,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                                labelText: 'Password ',
                                labelStyle: TextStyle(
                                    fontSize: objectApp.labelFont,
                                    color: AppColors.hinttext),
                                prefixIcon: Icon(
                                    loginC.lihatpass.value == false
                                        ? Icons.lock_open
                                        : Icons.lock,
                                    color: AppColors.iconColor1),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      loginC.lihatpass.value == false
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColors.iconColor1),
                                  onPressed: () => loginC.lihatpassword(),
                                ),
                                //     border:const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 20)),
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
                                  loginC.validasi();
                                },
                                child: const Text("Login",
                                    style: TextStyle(color: Colors.white)),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Belum Punya Akun?",
                            style: TextStyle(
                                fontSize: 15,
                                color: AppColors.themeColor,
                                fontFamily: objectApp.fontApp),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: TextButton(
                                onPressed: () {
                                  Get.toNamed('/request-otp');
                                },
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.color3,
                                      fontFamily: objectApp.fontApp),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
            BagroundAuthentication(
              bottomview: true,
              buttonview: keyboardIsVisible(context) ? false : true,
              onTap: () {
                Get.offAllNamed('/forgot-pass');
              },
              text: "Anda Lupa Password?",
              title: 'Reset',
            )
          ],
        )));
  }
}
