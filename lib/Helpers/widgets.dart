import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/MemberController/riwayat_jemputan_controller.dart';
import 'package:e_tikbroh_yok/Controllers/edukasi_controller.dart';
import 'package:e_tikbroh_yok/Controllers/profile_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Models/Home/home_slide_iklan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../Controllers/Auth/verifikasiOtpController.dart';

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const OtpInput(this.controller, this.autoFocus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final otpC = Get.find<VerifikasiOtpController>();
    return SizedBox(
      height: 50,
      width: 50,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(color: Colors.white, width: 0.0),
            ),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else {
            FocusScope.of(context).previousFocus();
          }
          otpC.otp.value =
              '${otpC.fieldOne.text}${otpC.fieldTwo.text}${otpC.fieldThree.text}${otpC.fieldFour.text}${otpC.fieldFive.text}';
          if (otpC.otp.value.length == 5) {
            otpC.validasi();
          }
        },
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  String text;
  LoadingView({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Column(
        children: [
          Image.asset(
            objectApp.logoAlert,
            scale: 8,
          ),
          Text(text,
              style: const TextStyle(fontFamily: objectApp.fontApp),
              textAlign: TextAlign.center),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}

class AlertUpdateApp extends StatelessWidget {
  String text;
  AlertUpdateApp({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Column(
        children: [
          Image.asset(
            objectApp.logoAlert,
            scale: 8,
          ),
          Text(text.toTitleCase(),
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: objectApp.fontApp),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class ImagesLoading extends StatelessWidget {
  double height;
  double width;
  ImagesLoading({Key? key, required this.width, required this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey.shade300,
      child: Column(
        children: [
          Container(
            height: height,
            width: width,
            // margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImagesLoadingProfile extends StatelessWidget {
  double height;
  double width;
  ImagesLoadingProfile({Key? key, required this.width, required this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey.shade300,
      child: Column(
        children: [
          Container(
            height: height,
            width: width,
            // margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(22))),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(22)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImagesLoadingSambunganBaru extends StatelessWidget {
  double height;
  double width;
  ImagesLoadingSambunganBaru(
      {Key? key, required this.width, required this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey.shade300,
      child: Column(
        children: [
          Container(
            height: height,
            width: width,
            // margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImagesLoadingIklan extends StatelessWidget {
  int scaleHeigth;
  ImagesLoadingIklan({Key? key, required this.scaleHeigth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Shimmer.fromColors(
        highlightColor: Colors.white,
        baseColor: Colors.grey.shade300,
        child: Container(
          width: size(context).width,
          height: size(context).height / scaleHeigth,
          // margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          decoration: const BoxDecoration(
            color: Colors.grey,
            // borderRadius: BorderRadius.all(Radius.circular(50))
          ),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingCard extends StatelessWidget {
  double height;
  double width;
  LoadingCard({Key? key, required this.width, required this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey.shade300,
      child: Column(
        children: [
          Container(
            height: height,
            width: width,
            // margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class KonfirmasiLogOut extends StatelessWidget {
  String text;
  KonfirmasiLogOut({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          objectApp.logoAlert,
          scale: 8,
        ),
        Text(text,
            style: const TextStyle(fontFamily: objectApp.fontApp),
            textAlign: TextAlign.center),
      ],
    );
  }
}

class KonfirmasiDelete extends StatelessWidget {
  String text;
  KonfirmasiDelete({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: FaIcon(
            FontAwesomeIcons.circleExclamation,
            color: Colors.yellow,
            size: 50,
          ),
        ),
        Text(text,
            style: const TextStyle(fontFamily: objectApp.fontApp),
            textAlign: TextAlign.center),
      ],
    );
  }
}

class KonfirmasiBatalJemputSampah extends StatelessWidget {
  String text;
  KonfirmasiBatalJemputSampah({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text,
            style: const TextStyle(fontFamily: objectApp.fontApp),
            textAlign: TextAlign.center),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Form(
            key: keyForm,
            child: TextFormField(
              controller: keteraganBataljemput,
              validator: (e) {
                if (e!.isEmpty) {
                  return 'Masukkan Keterangan';
                }
                return null;
              },
              maxLines: 3,
              decoration: InputDecoration(
                fillColor: AppColors.filledColor.withOpacity(0.5),
                filled: true,
                labelText: 'Keterangan',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
                labelStyle: TextStyle(fontSize: objectApp.labelFont),
                prefixIcon: const Icon(
                  Icons.description,
                  color: AppColors.iconColor1,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class AlertErrorView extends StatelessWidget {
  String text;
  final MaterialColor colors;
  AlertErrorView({Key? key, required this.text, required this.colors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FaIcon(
            FontAwesomeIcons.circleExclamation,
            color: colors,
            size: 50,
          ),
        ),
        Text(text,
            style: const TextStyle(fontFamily: objectApp.fontApp),
            textAlign: TextAlign.center),
      ],
    );
  }
}

class AlertErrorCodeView extends StatelessWidget {
  String text;
  AlertErrorCodeView({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: FaIcon(
            FontAwesomeIcons.circleExclamation,
            color: AppColors.deleteButtonColor,
            size: 50,
          ),
        ),
        Text(text.toTitleCase(),
            style: const TextStyle(fontFamily: objectApp.fontApp),
            textAlign: TextAlign.center),
      ],
    );
  }
}

class DaftarLokasiJemputanChace extends StatelessWidget {
  DaftarLokasiJemputanChace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderJemputanC = Get.find<OrderJemputanController>();
    return Obx(
      () {
        if (orderJemputanC.itemLokasiJemputan.value.isEmpty) {
          return Container(
            height: size(context).height,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                FaIcon(FontAwesomeIcons.mapLocationDot, color: Colors.grey),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Lokasi belum ditambahkan",
                    style: const TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          );
        } else {
          return Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: List.generate(
                    orderJemputanC.itemLokasiJemputan.value.length, (index) {
                  if (orderJemputanC.itemLokasiJemputan.value.isEmpty) {
                    return SizedBox(
                      height: size(context).height / 2,
                      width: size(context).width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          FaIcon(FontAwesomeIcons.mapLocationDot,
                              color: Colors.grey),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Lokasi Belum Ditambahkan!",
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 1,
                                  spreadRadius: 0.1,
                                  offset: Offset(0, 1))
                            ]),
                        child: ListTile(
                          leading: const FaIcon(
                            FontAwesomeIcons.locationPinLock,
                            color: AppColors.iconColor1,
                          ),
                          title: Text(
                            "${orderJemputanC.itemLokasiJemputan.value[index].namaTempat.toString().toTitleCase()}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontFamily: objectApp.fontApp,
                                color: AppColors.fontColor,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "${orderJemputanC.itemLokasiJemputan.value[index].alamat.toString().toCapitalized()}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              color: AppColors.fontColor,
                              fontFamily: objectApp.fontApp,
                              fontSize: 14,
                            ),
                          ),
                          onTap: () {
                            orderJemputanC.namaLokasiJemputan.value =
                                orderJemputanC
                                    .itemLokasiJemputan.value[index].namaTempat
                                    .toString()
                                    .toTitleCase();
                            orderJemputanC.alamatLokasiJemputan.value =
                                orderJemputanC
                                    .itemLokasiJemputan.value[index].alamat
                                    .toString()
                                    .toTitleCase();
                            orderJemputanC.idTitikJemputan = orderJemputanC
                                .itemLokasiJemputan.value[index].id;
                            Get.back();
                          },
                        ),
                      ),
                    );
                  }
                }),
              ),
            ),
          );
        }
      },
    );
  }
}

class AlertSuccesView extends StatelessWidget {
  String text;
  final MaterialColor colors;
  final IconData? icon;
  AlertSuccesView({
    Key? key,
    required this.text,
    required this.colors,
    this.icon = FontAwesomeIcons.circleCheck,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FaIcon(
              icon,
              color: colors,
              size: 50,
            ),
          ),
          Text(text,
              style: const TextStyle(fontFamily: objectApp.fontApp),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class PlayVideo extends StatelessWidget {
  const PlayVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final edukasiC = Get.find<EdukasiController>();
    return SafeArea(
      child: Stack(
        children: [
          Container(
            color: Colors.black.withOpacity(0.8),
            child: Center(
              child: YoutubePlayer(
                controller: edukasiC.videoPlayerController!,
                showVideoProgressIndicator: true,
                controlsTimeOut: const Duration(seconds: 30),
                progressIndicatorColor: Colors.blueAccent,
                progressColors: const ProgressBarColors(
                  playedColor: Colors.blueAccent,
                  handleColor: Colors.blueAccent,
                ),
              ),
            ),
          ),
          Positioned(
              top: 20,
              right: 0,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.transparent),
                ),
                child: const Icon(
                  Icons.clear,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  edukasiC.closeVideo();
                },
              )),
        ],
      ),
    );
  }
}

class GradientIcon extends StatelessWidget {
  const GradientIcon(this.icon, this.size, this.gradient, {super.key});

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: FaIcon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}

class ItemBagroundHome extends StatelessWidget {
  const ItemBagroundHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
          opacity: 0.05,
          child: Image.asset(
            objectApp.logoAlert,
            scale: 1.4,
          )),
    );
  }
}

class FormEditUser extends StatelessWidget {
  const FormEditUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingC = Get.find<ProfileController>();
    return SizedBox(
        width: size(context).width,
        child: Form(
          key: settingC.keyform,
          child: Column(
            children: [
              TextFormField(
                controller: settingC.email,
                keyboardType: TextInputType.emailAddress,
                validator: (e) {
                  if (e!.isEmpty) {
                    return 'Masukkan Email Anda';
                  } else if (emailValidate(e)) {
                    return 'Email Anda Tidak Valid';
                  }
                  return null;
                },
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(fontSize: objectApp.labelFont),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: AppColors.iconColor1,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: settingC.namaUser,
                  validator: (e) {
                    if (e!.isEmpty) {
                      return 'Masukkan Nama Anda';
                    } else if (!validasi20karakter.hasMatch(e)) {
                      return 'Maksimal 20 karakter inputan';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Nama ',
                    contentPadding: const EdgeInsets.all(10),
                    labelStyle: TextStyle(fontSize: objectApp.labelFont),
                    prefixIcon: const Icon(
                      Icons.account_circle,
                      color: AppColors.iconColor1,
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.all(5)),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: settingC.noHp,
                  validator: (e) {
                    if (e!.isEmpty) {
                      return 'Masukkan Nomor Hp Anda';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    labelText: 'Nomor Hp',
                    labelStyle: TextStyle(fontSize: objectApp.labelFont),
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: AppColors.iconColor1,
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class DetailImage extends StatelessWidget {
  final img;
  final id;
  const DetailImage({Key? key, required this.id, required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'detailImg${id}',
      child: CachedNetworkImage(
        imageUrl: img,
        errorWidget: (context, url, error) => const Icon(Icons.error),
        progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
          height: size(context).height,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        width: size(context).width,
      ),
    );
  }
}

class ListImagePreviewPage extends StatelessWidget {
  final List<String> imageUrls;
  final id;
  final desc;
  ListImagePreviewPage({
    required this.imageUrls,
    required this.id,
    this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'detailImg${id}',
      child: Container(
        color: AppColors.themeColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ItemImageSlide(
              dataImage: imageUrls,
              fitImage: true,
              autoSlide: false,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                desc,
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  color: AppColors.white,
                  fontFamily: objectApp.fontApp,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BagroundAuthentication extends StatelessWidget {
  String title;
  String text;
  bool buttonview;
  bool bottomview;
  Function onTap;
  BagroundAuthentication(
      {Key? key,
      required this.text,
      required this.title,
      required this.onTap,
      required this.buttonview,
      required this.bottomview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -50,
          left: -50,
          child: ClipOval(
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  color: AppColors.themeColor.withOpacity(0.5)),
            ),
          ),
        ),
        Positioned(
          top: 150,
          right: -50,
          child: ClipOval(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: AppColors.themeColor.withOpacity(0.5)),
            ),
          ),
        ),
        Positioned(
          bottom: 80,
          left: -30,
          child: ClipOval(
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  color: AppColors.themeColor.withOpacity(0.5)),
            ),
          ),
        ),
        buttonview == false
            ? Container()
            : Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  // width: size(context).width / 1.2,
                  decoration: BoxDecoration(
                      color:
                      AppColors.themeColor.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(100),
                          topLeft: Radius.circular(100))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.themeColor,
                            fontFamily: objectApp.fontApp),
                      ),
                      bottomview == false
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(left: 8.0,top: 10,bottom: 10),
                              child: Container(
                                // height: 30,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(77, 129, 129, 141),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Center(
                                  child: TextButton(
                                      onPressed: () => onTap(),
                                      child: Text(
                                        title,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontFamily: objectApp.fontApp),
                                      )),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              )
      ],
    );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.color3
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.4,
          size.width * 0.5, size.height * 0.5)
      ..quadraticBezierTo(
          size.width * 0.75, size.height * 0.6, size.width, size.height * 0.5)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
