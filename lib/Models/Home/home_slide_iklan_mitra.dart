import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_tikbroh_yok/Controllers/home_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Json/responJsonIklanMitra.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Helpers/helpers.dart';
import '../../Helpers/widgets.dart';

class ItemPageSlideIklanMitra extends StatelessWidget {
  const ItemPageSlideIklanMitra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeC = Get.find<HomeController>();
    return Obx(() {
      if (homeC.loading.value == true) {
        return ImagesLoadingIklan(
          scaleHeigth: 5,
        );
      } else {
        return FutureBuilder<ModelIklanMitra>(
            future: homeC.daftarIklanmitra(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ImagesLoadingIklan(
                  scaleHeigth: 5,
                );
              } else if (snapshot.data!.data.isEmpty) {
                return SizedBox(
                  height: size(context).height / 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text("Daftar iklan kosong"),
                      Icon(Icons.image_not_supported)
                    ],
                  ),
                );
              } else {
                final data = snapshot.data!.data;
                List<IklanHome> result = [];
                data.forEach((element) {
                  IklanHome iklanHome = IklanHome(
                    id: element.id,
                    gambar: element.gambar,
                    title: element.title,
                    deskripsi: element.deskripsi,
                  );
                  if (result.length < 4) {
                    result.add(iklanHome);
                  }
                });
                List<Widget> imageSlider;
                imageSlider = result
                    .map((e) => InkWell(
                          onTap: () => Get.to(DaftarSemuaIklan()),
                          child: Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, right: 25),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: e.gambar.toString(),
                                    errorWidget: (context, url, error) =>
                                        CircleAvatar(
                                      child: Image.asset(
                                          "assets/logo-hijau.png",
                                          fit: BoxFit.cover),
                                    ),
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, right: 25, top: 0),
                                      child: ImagesLoadingIklan(
                                        scaleHeigth: 5,
                                      ),
                                    ),
                                    fit: BoxFit.cover,
                                    width: size(context).width,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 25,
                                child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          topLeft: Radius.circular(10))),
                                  child: Text(e.title.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                          color: AppColors.blackColor,
                                          fontFamily: objectApp.fontApp,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList();
                return CarouselSlider(
                  options: CarouselOptions(
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlay: true,
                    aspectRatio: 1 / 1,
                    height: 195,
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    autoPlayCurve: Curves.easeInCubic,
                  ),
                  items: imageSlider,
                );
              }
            });
      }
    });
  }
}

class DetailIklanMitra extends StatelessWidget {
  String title;
  String desc;
  String image;

  DetailIklanMitra(
      {Key? key, required this.title, required this.desc, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.titleText,
            fontFamily: objectApp.fontApp,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: size(context).height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    height: size(context).height / 5,
                    width: size(context).width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        errorWidget: (context, url, error) => CircleAvatar(
                          child: Image.asset("assets/logo-hijau.png",
                              fit: BoxFit.cover),
                        ),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                ImagesLoadingIklan(
                          scaleHeigth: 6,
                        ),
                        fit: BoxFit.cover,
                        width: size(context).width,
                      ),
                    ),
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                      color: AppColors.themeColor,
                      fontFamily: objectApp.fontApp,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  desc,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      color: AppColors.fontColor,
                      fontFamily: objectApp.fontApp,
                      fontSize: 12,
                      height: 2,
                      wordSpacing: 3,
                      textBaseline: TextBaseline.ideographic,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(left: 5, right: 5, bottom: 0),
      //   child: ElevatedButton(
      //     child: const Text('Kembali'),
      //     onPressed: () {
      //       Get.back();
      //     },
      //   ),
      // ),
    );
  }
}

class DaftarSemuaIklan extends StatelessWidget {
  const DaftarSemuaIklan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeC = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: const Center(child: Text('Mitra Kami')),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 0),
        child: ElevatedButton(
          child: const Text('Kembali'),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (homeC.loading.value == true) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return FutureBuilder<ModelIklanMitra>(
                future: homeC.daftarIklanmitra(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.data!.data.isEmpty) {
                    return SizedBox(
                      height: size(context).height / 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text("Daftar iklan kosong"),
                          Icon(Icons.image_not_supported)
                        ],
                      ),
                    );
                  } else {
                    final data = snapshot.data!.data;

                    return ListView(
                      children: List.generate(data.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Get.to(DetailIklanMitra(
                                  title: data[index].title,
                                  desc: data[index].deskripsi,
                                  image: data[index].gambar));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: size(context).height / 6,
                                  width: size(context).width - 25,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: data[index].gambar.toString(),
                                      errorWidget: (context, url, error) =>
                                          CircleAvatar(
                                        child: Image.asset(
                                            "assets/logo-hijau.png",
                                            fit: BoxFit.cover),
                                      ),
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              ImagesLoadingIklan(
                                        scaleHeigth: 6,
                                      ),
                                      fit: BoxFit.cover,
                                      width: size(context).width,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0, top: 5),
                                  child: Text(
                                    data[index].title,
                                    style: const TextStyle(
                                        color: AppColors.themeColor,
                                        fontFamily: objectApp.fontApp,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: SizedBox(
                                    width: size(context).width - 100,
                                    child: Text(
                                      data[index].deskripsi,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                          color: AppColors.fontColor,
                                          fontFamily: objectApp.fontApp,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  }
                });
          }
        }),
      ),
    );
  }
}
