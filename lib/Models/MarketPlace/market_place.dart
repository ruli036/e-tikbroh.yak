import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/market_place_controller.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:e_tikbroh_yok/Json/MemberJson/model_market_place.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Helpers/constans.dart';

class MarketPlacePage extends StatelessWidget {
  const MarketPlacePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final marketPlaceController = Get.find<MarketPlaceController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Place',
            style: TextStyle(
                color: AppColors.titleText, fontFamily: objectApp.fontApp)),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          child: Column(
            children: [
              SizedBox(
                height: 45,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    hintText: 'Pencarian...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        searchController.clear();
                        marketPlaceController.getDataMarketPlace();
                      },
                    ),
                  ),
                  onChanged: (value) =>marketPlaceController.searchQuery.value = value,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(
                child: Obx(() {
                  if (marketPlaceController.loading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                
                  final data = marketPlaceController.listData;
                
                  if (data.isEmpty) {
                    return SizedBox(
                      height: size(context).height,
                      width: size(context).width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const FaIcon(FontAwesomeIcons.truckPickup,
                              color: Colors.grey),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              marketPlaceController.pesan.value,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                
                  return ItemDataMarketPlace(data: data);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemDataMarketPlace extends StatelessWidget {
  final RxList<ItemData> data;

  const ItemDataMarketPlace({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final marketPlaceController = Get.find<MarketPlaceController>();
    return GridView.count(
      controller: marketPlaceController.scrollController,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.5 / 2,
      children: data.map((item) {
        return InkWell(
          onTap: (){
            marketPlaceController.item.value = item;
            Get.toNamed('detail-market-place');
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(1, 1))
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: badges.Badge(
                    position: badges.BadgePosition.topEnd(top: 0, end: 0),
                    showBadge: true,
                    ignorePointer: false,
                    onTap: () {},
                    badgeContent: Text("Terjual ${item.terjual}",
                        style: const TextStyle(
                            color: AppColors.textColor,
                            fontFamily: objectApp.fontApp,
                            fontSize: 15,
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
                        imageUrl: item.photo?.first.image ??
                            'https://www.bigfootdigital.co.uk/wp-content/uploads/2020/07/image-optimisation-scaled.jpg',
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: ImagesLoading(
                            height: 100,
                            width: double.infinity,
                          ),
                        ),
                        fit: BoxFit.cover,
                        width: size(context).width,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.namaProduk ?? '',
                        maxLines: 1,
                        style: const TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Rp ${Helpers().formater.format(item.harga)}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "${item.mitra ?? ''}\nDilihat : ${item.dilihat}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
