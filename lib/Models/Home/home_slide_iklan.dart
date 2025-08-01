import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_tikbroh_yok/Controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helpers/helpers.dart';
import '../../Helpers/widgets.dart';

class ItemPageSlideIklan extends StatelessWidget {
  const ItemPageSlideIklan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeC = Get.find<HomeController>();
    print(homeC.imageSlider.value);
    return Obx(() {
      if (homeC.loading.value == true) {
        return ImagesLoadingIklan(
          scaleHeigth: 6,
        );
      } else if (homeC.imageSlider.value.length == 0) {
        return SizedBox(
          height: size(context).height / 6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text("Daftar katalog sampah kosong"),
              Icon(Icons.image_not_supported)
            ],
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.only(top: 12,left: 20,right: 20,bottom: 20),
          child: Container(
              height: size(context).height / 6,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // Offset of the shadow
                    ),
                  ],
                  color: AppColors.colorMenu.withOpacity(0.7),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: ItemImageSlide(
                dataImage: homeC.imageSlider.value,
                fitImage: true,
                autoSlide: true,
              )),
        );
      }
    });
  }
}

class ItemImageSlide extends StatelessWidget {
  List dataImage;
  bool fitImage;
  bool autoSlide;
  ItemImageSlide(
      {Key? key,
      required this.fitImage,
      required this.autoSlide,
      required this.dataImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> imageSlider;
    imageSlider = dataImage
        .map((e) => Column(
          children: [
            ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: e.toString(),
                    errorWidget: (context, url, error) => CircleAvatar(
                      child:
                          Image.asset("assets/logo-hijau.png", fit: BoxFit.cover),
                    ),
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        ImagesLoadingIklan(
                      scaleHeigth: 6,
                    ),
                    fit: fitImage ? BoxFit.cover : BoxFit.contain,
                    width: size(context).width,
                  ),
                ),
          ],
        ))
        .toList();
    return CarouselSlider(
      options: CarouselOptions(
        autoPlayInterval: const Duration(seconds: 5),
        autoPlay: autoSlide,
        aspectRatio: 1 / 1,
        height: size(context).width,
        viewportFraction: 1,
        enlargeCenterPage: true,
        autoPlayCurve: Curves.easeInCubic,
      ),
      items: imageSlider,
    );
  }
}
