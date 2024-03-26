import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Controllers/Auth/verifikasiOtpController.dart';
import '../../Helpers/widgets.dart';

class VerifikasiOTPPageView extends StatelessWidget {
  const VerifikasiOTPPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final otpC = Get.find<VerifikasiOtpController>();
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
                    height: 70,
                    width: size(context).width,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black45,
                              blurRadius: 4,
                              spreadRadius: 0.1,
                              offset: Offset(0, 1))
                        ]),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: FaIcon(
                            FontAwesomeIcons.circleExclamation,
                            color: AppColors.warningButtonColor,
                            size: 40,
                          ),
                        ),
                        Expanded(
                            child: Text(
                                "Kode verifikasi telah di kirim ke email anda",
                                style: TextStyle(
                                    fontFamily: objectApp.fontApp,
                                    color: Colors.black,
                                    fontSize: 14))),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(20)),
                  AnimatedContainer(
                    height: keyboardIsVisible(context)
                        ? 50
                        : size(context).width / 3,
                    duration: const Duration(milliseconds: 500),
                    child: Image.asset(
                      objectApp.logoAlert,
                      scale: 2,
                    ),
                  ),
                  const Center(
                      child: Text(
                    'Verifikasi Kode OTP!!! ',
                    style: TextStyle(
                        color: AppColors.fontTitleColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: objectApp.fontApp,
                        fontSize: 24),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                        child: Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OtpInput(otpC.fieldOne, true), // auto focus
                              OtpInput(otpC.fieldTwo, false),
                              OtpInput(otpC.fieldThree, false),
                              OtpInput(otpC.fieldFour, false),
                              OtpInput(otpC.fieldFive, false)
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 10)),
                          Obx(
                            () => Container(
                                height: 50,
                                width: size(context).width,
                                decoration: BoxDecoration(
                                    color: otpC.otp.value.length == 5
                                        ? AppColors.buttonColor
                                        : AppColors.disableButtonColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30))),
                                child: TextButton(
                                  onPressed: () {
                                    otpC.validasi();
                                  },
                                  child: const Text("SUBMIT",
                                      style: TextStyle(color: Colors.white)),
                                )),
                          ),
                        ],
                      ),
                    )),
                  )
                ],
              ),
            ),
          ),
          Obx(
            () => BagroundAuthentication(
                buttonview: keyboardIsVisible(context) ? false : true,
                bottomview: true,
                text: "Request code OTP",
                title: 'Kirim Kode ${otpC.time.value}',
                onTap: () {
                  if (otpC.time.value == 0) {
                    otpC.requestOptAgain();
                  }
                }),
          )
        ],
      ),
    ));
  }
}
