import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/market_place_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/MemberJson/model_market_place.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

class DetailItemMarketPlacePage extends StatelessWidget {
  const DetailItemMarketPlacePage({super.key});

  @override
  Widget build(BuildContext context) {
    final marketPlaceController = Get.find<MarketPlaceController>();
    marketPlaceController.selectedImage.value = marketPlaceController.item.value.photo?.first.image ??
        'https://www.bigfootdigital.co.uk/wp-content/uploads/2020/07/image-optimisation-scaled.jpg';
    return Scaffold(
      backgroundColor: Color(0xFFE0E0E0),
      appBar: AppBar(
        title: Text(marketPlaceController.item.value.namaProduk ?? ''),
      ),
      body: Obx(()=>
        ListView(
          children: [
            SizedBox(
              height: size(context).width / 1.5,
              child: CachedNetworkImage(
                alignment: Alignment.center,
                imageUrl: marketPlaceController.selectedImage.value,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: ImagesLoading(
                    height: 100,
                    width: double.infinity,
                  ),
                ),
                fit: BoxFit.cover,
                width: size(context).width,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16),
                    color: Colors.white,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gallery",
                          style: TextStyle(
                              color: AppColors.fontTitleColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8,),
                        SizedBox(
                          height: size(context).width / 5,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: (marketPlaceController.item.value.photo ?? []).map((image) {
                              return InkWell(
                                onTap: (){
                                  marketPlaceController.selectedImage.value = image.image.toString();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 6),
                                  width: size(context).width / 5,
                                  height: size(context).width / 5,
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            alignment: Alignment.center,
                                            imageUrl: image.image ??
                                                'https://www.bigfootdigital.co.uk/wp-content/uploads/2020/07/image-optimisation-scaled.jpg',
                                            errorWidget: (context, url, error) =>
                                                const Icon(Icons.error),
                                            progressIndicatorBuilder: (context, url,
                                                    downloadProgress) =>
                                                Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                            fit: BoxFit.cover,
                                            width: size(context).width,
                                          ),
                                        ),
                                      ),
                                      marketPlaceController.selectedImage.value == image.image
                                          ? Container(
                                              decoration:BoxDecoration(
                                                color: Colors.black
                                                    .withValues(alpha: 0.2),
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.image,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : SizedBox()
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 8,),
                        Divider(
                          color: AppColors.titleText,
                          thickness: 2,
                        ),
                        Text(
                          marketPlaceController.item.value.namaProduk ?? '-',
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColors.titleText,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          marketPlaceController.item.value.deskripsi ?? '-',
                          style: TextStyle(
                            color: AppColors.fontTitleColor1,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 12,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16),
                    color: Colors.white,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mitra : ${marketPlaceController.item.value.mitra}",
                          style: TextStyle(
                              color: AppColors.fontTitleColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Harga : ${Helpers().formater.format(marketPlaceController.item.value.harga)}",
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColors.titleText,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Produk terjual : ${marketPlaceController.item.value.terjual}",
                          style: TextStyle(
                            color: AppColors.fontTitleColor1,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  margin: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                  child: Center(child: Text("Pesan Sekarang",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),) ,),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16),
                    color: Colors.white,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Produk lainnya",
                          style: TextStyle(
                              color: AppColors.fontTitleColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 150,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: marketPlaceController.listData.map((next) {
                              if (next.id == marketPlaceController.item.value.id) {
                                return SizedBox();
                              }
                              return InkWell(
                                onTap: () {
                                  marketPlaceController.selectedImage.value = next.photo!.first.image.toString();
                                  marketPlaceController.item.value = next;
                                },
                                child: Container(
                                  width: 120,
                                  margin: EdgeInsets.only(right: 12, top: 8),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: badges.Badge(
                                          position: badges.BadgePosition.topEnd(
                                              top: 0, end: 0),
                                          showBadge: true,
                                          ignorePointer: false,
                                          onTap: () {},
                                          badgeContent: Text(
                                              "Terjual ${next.terjual}",
                                              style: TextStyle(
                                                  color: AppColors.textColor,
                                                  fontFamily: objectApp.fontApp,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold)),
                                          badgeStyle: const badges.BadgeStyle(
                                            shape: badges.BadgeShape.square,
                                            badgeColor: AppColors.themeColor,
                                            padding: EdgeInsets.all(5),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10)),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                topLeft: Radius.circular(15)),
                                            child: CachedNetworkImage(
                                              alignment: Alignment.center,
                                              imageUrl: next.photo?.first.image ??
                                                  'https://www.bigfootdigital.co.uk/wp-content/uploads/2020/07/image-optimisation-scaled.jpg',
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                              progressIndicatorBuilder: (context,
                                                      url, downloadProgress) =>
                                                  Center(
                                                child: ImagesLoading(
                                                  height: 100,
                                                  width: 100,
                                                ),
                                              ),
                                              fit: BoxFit.cover,
                                              width: size(context).width,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        next.namaProduk ?? '',
                                        maxLines: 1,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
