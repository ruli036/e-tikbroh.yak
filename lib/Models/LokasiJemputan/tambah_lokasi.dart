import 'package:e_tikbroh_yok/Controllers/MemberController/lokasi_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Models/mapPages/map_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class TambahLokasiJemputan extends StatelessWidget {
  const TambahLokasiJemputan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lokasiC = Get.find<LokasiController>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        title: const Text(
          "Tambah Lokasi Jemputan",
          style: TextStyle(
              color: AppColors.titleText, fontFamily: objectApp.fontApp),
        ),
      ),
      body: Form(
        key: lokasiC.keyform,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  height: size(context).width / 2,
                  child: MapLocation(),
                ),
              ),
              Container(
                height: 80,
                width: size(context).width,
                child: Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: lokasiC.namaTempat,
                          validator: (e) {
                            if (e!.isEmpty) {
                              return 'Masukkan Nama Tempat!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.3),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            labelText: 'Nama Lokasi',
                            labelStyle: TextStyle(
                                fontSize: objectApp.labelFont,
                                color: AppColors.hinttext),
                          ),
                        ),
                      ),
                      Text(
                        changeImg.value.toString(),
                        style: TextStyle(color: Colors.transparent),
                      ),
                      InkWell(
                        onTap: () => lokasiC.ambilFoto(),
                        child: Container(
                          height: size(context).width / 7,
                          width: size(context).width / 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 2, color: Colors.grey.shade300),
                            color: Colors.white,
                            image: lokasiC.foto != null
                                ? DecorationImage(
                                    image: FileImage(lokasiC.foto),
                                    fit: BoxFit.cover)
                                : null,
                          ),
                          child: lokasiC.foto == null
                              ? const Center(
                                  child: FaIcon(FontAwesomeIcons.fileImage,
                                      color: Colors.grey, size: 30),
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextFormField(
                controller: lokasiC.alamat,
                validator: (e) {
                  if (e!.isEmpty) {
                    return 'Masukkan Alamat Lokasi Anda!';
                  }
                  return null;
                },
                maxLines: 2,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  labelText: 'Alamat Lokasi',
                  labelStyle: TextStyle(
                      fontSize: objectApp.labelFont, color: AppColors.hinttext),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: lokasiC.detailTempat,
                  validator: (e) {
                    if (e!.isEmpty) {
                      return 'Masukkan Detail Lokasi Anda!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.3),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    labelText: 'Detail Alamat Anda',
                    labelStyle: TextStyle(
                        fontSize: objectApp.labelFont, color: AppColors.hinttext),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            // height: 50,
            width: size(context).width,
            decoration: const BoxDecoration(
                color: AppColors.themeColor,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: TextButton(
              onPressed: () {
                lokasiC.validasi();
              },
              child: const Text("Tambah Lokasi",
                  style: TextStyle(
                      color: AppColors.white, fontFamily: objectApp.fontApp)),
            )),
      ),
    );
  }
}
