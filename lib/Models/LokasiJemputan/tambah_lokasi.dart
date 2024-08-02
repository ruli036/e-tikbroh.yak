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
        backgroundColor: AppColors.themeColor,
        title: Text("Tambah Lokasi Jemputan"),
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
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                height: size(context).height / 4,
                child: MapLocation(),
              ),
              const Padding(padding: EdgeInsets.all(5)),
              Expanded(
                  child: ListView(
                children: [
                  Obx(
                    () => Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: size(context).width - 130,
                          child: TextFormField(
                            controller: lokasiC.namaTempat,
                            validator: (e) {
                              if (e!.isEmpty) {
                                return 'Masukkan nama tempat';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Nama Tempat (rumah, kantor, dll)',
                              filled: true,
                              fillColor: AppColors.filledColor.withOpacity(0.5),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              labelStyle: TextStyle(
                                  fontSize: objectApp.labelFont,
                                  color: AppColors.hinttext),
                              prefixIcon: const Icon(
                                Icons.house,
                                color: AppColors.iconColor1,
                              ),
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
                            height: size(context).width / 6,
                            width: size(context).width / 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 2, color: Colors.grey.shade300),
                              color: Colors.white,
                              image: lokasiC.foto != null
                                  ? DecorationImage(
                                      image: FileImage(lokasiC.foto),
                                      fit: BoxFit.contain)
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
                  const Padding(padding: EdgeInsets.all(5)),
                  TextFormField(
                    controller: lokasiC.alamat,
                    validator: (e) {
                      if (e!.isEmpty) {
                        return 'Masukkan alamat tempat';
                      }
                      return null;
                    },
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Alamat',
                      filled: true,
                      fillColor: AppColors.filledColor.withOpacity(0.5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      labelStyle: TextStyle(
                          fontSize: objectApp.labelFont,
                          color: AppColors.hinttext),
                      prefixIcon: const Icon(
                        Icons.directions,
                        color: AppColors.iconColor1,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  TextFormField(
                    controller: lokasiC.detailTempat,
                    validator: (e) {
                      if (e!.isEmpty) {
                        return 'Masukkan detail tempat';
                      }
                      return null;
                    },
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: 'Detail Tempat',
                      filled: true,
                      fillColor: AppColors.filledColor.withOpacity(0.5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      labelStyle: TextStyle(
                          fontSize: objectApp.labelFont,
                          color: AppColors.hinttext),
                      prefixIcon: const Icon(
                        Icons.description,
                        color: AppColors.iconColor1,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                ],
              )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 50,
            width: size(context).width,
            decoration: const BoxDecoration(
                color: AppColors.buttonColor,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: TextButton(
              onPressed: () {
                lokasiC.validasi();
              },
              child: const Text("Tambah Lokasi",
                  style: TextStyle(color: Colors.white)),
            )),
      ),
    );
  }
}
