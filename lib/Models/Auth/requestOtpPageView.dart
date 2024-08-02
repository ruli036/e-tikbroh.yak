import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Controllers/Auth/requestOtpController.dart';
import '../../Helpers/widgets.dart';

class RequestOtpPageView extends StatelessWidget {
  const RequestOtpPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final regisC = Get.find<RequestOtpController>();
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        ListView(
          children: [
            Container(
              height:
                  size(context).height / (keyboardIsVisible(context) ? 15 : 20),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: AnimatedContainer(
                height:
                    keyboardIsVisible(context) ? 0 : size(context).width / 2.5,
                duration: const Duration(milliseconds: 500),
                child: Image.asset(
                  objectApp.logoApp,
                  scale: 2,
                ),
              ),
            ),
            const Center(
                child: Text(
              'Registration',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.fontTitleColor,
                  fontFamily: objectApp.fontApp),
            )),
            Container(
                child: Form(
              key: regisC.keyform,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: regisC.namaUser,
                      validator: (e) {
                        if (e!.isEmpty) {
                          return 'Masukkan nama anda';
                        } else if (!validasi20karakter.hasMatch(e)) {
                          return 'Maksimal 20 karakter inputan';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Nama ',
                        filled: true,
                        fillColor: AppColors.filledColor.withOpacity(0.5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none),
                        labelStyle: TextStyle(
                            fontSize: objectApp.labelFont,
                            color: AppColors.hinttext),
                        prefixIcon: const Icon(
                          Icons.account_circle,
                          color: AppColors.iconColor1,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
                    TextFormField(
                      controller: regisC.noHp,
                      validator: (e) {
                        RegExp regex = RegExp(r'^.{1,16}$');
                        if (e!.isEmpty) {
                          return 'Masukkan nomor hp';
                        } else if (!regex.hasMatch(e)) {
                          return 'Maksimal nomor hp 13 angka';
                        }

                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.filledColor.withOpacity(0.5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none),
                        labelText: 'Nomor Hp',
                        labelStyle: TextStyle(
                          fontSize: objectApp.labelFont,
                          color: AppColors.hinttext,
                        ),
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: AppColors.iconColor1,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
                    TextFormField(
                      controller: regisC.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (e) {
                        if (e!.isEmpty) {
                          return 'Masukkan email';
                        } else if (emailValidate(e)) {
                          return 'Email yang anda masukkan tidak valid!';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.filledColor.withOpacity(0.5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                            fontSize: objectApp.labelFont,
                            color: AppColors.hinttext),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: AppColors.iconColor1,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: size(context).width / 2 - (30),
                            child: RadioListTile(
                              title: const Text('Member'),
                              value: 'member',
                              groupValue: regisC.statusUser.value,
                              onChanged: (value) => regisC.onClick(value),
                            ),
                          ),
                          SizedBox(
                            width: size(context).width / 2 - (30),
                            child: RadioListTile(
                              title: const Text('Driver'),
                              value: 'driver',
                              groupValue: regisC.statusUser.value,
                              onChanged: (value) => regisC.onClick(value),
                            ),
                          ),
                        ],
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
                            regisC.validasi();
                          },
                          child: const Text("SUBMIT",
                              style: TextStyle(color: Colors.white)),
                        )),
                    const Padding(padding: EdgeInsets.all(10)),
                  ],
                ),
              ),
            )),
          ],
        ),
        BagroundAuthentication(
          buttonview: keyboardIsVisible(context) ? false : true,
          bottomview: true,
          onTap: () {
            Get.offAllNamed('/login');
          },
          text: "Sudah Punya Akun?",
          title: 'Login',
        )
      ],
    )));
  }
}
