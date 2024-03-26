import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tikbroh_yok/Controllers/MemberController/riwayat_jemputan_controller.dart';
import 'package:e_tikbroh_yok/Helpers/constans.dart';
import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class OrderJemputanView extends StatelessWidget {
  const OrderJemputanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OrderJemputanController());
    final orderC = Get.find<OrderJemputanController>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: const Text("Order Jemputan",style: TextStyle(
            color: AppColors.titleText, fontFamily: objectApp.fontApp),),
      ),
      body: ListView(
        children: const [
          ItemFormLokasi(),
          Padding(padding: EdgeInsets.all(5)),
          ItemFormKategoriSampah()
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            // height: 50,
            width: size(context).width,
            decoration:const BoxDecoration(
                color: AppColors.themeColor,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: TextButton(
              onPressed: () {
                orderC.validasi();
              },
              child: const Text("Order Jemputan",
                  style: TextStyle(color: AppColors.white,fontFamily: objectApp.fontApp)),
            )),
      ),
    );
  }
}

class ItemFormLokasi extends StatelessWidget {
  const ItemFormLokasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderC = Get.find<OrderJemputanController>();
    return Obx(
      () =>  Column(
          children: [
            ListTile(
              title: Text(
                orderC.namaLokasiJemputan.value,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                    color: AppColors.titleText,
                    fontFamily: objectApp.fontApp,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                orderC.alamatLokasiJemputan.value,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  color: AppColors.titleText,
                  // fontFamily: objectApp.fontApp,
                  fontSize: 12,
                ),
              ),
              onTap: () {
                Get.bottomSheet(
                  DaftarLokasiJemputanChace(),
                );
              },
              leading: const SizedBox(
                  width: 25,
                  child: Center(
                      child: FaIcon(
                    FontAwesomeIcons.mapLocationDot,
                    size: 30,
                    color: AppColors.iconColor1,
                  ))),
              trailing: PopupMenuButton(
                onSelected: (value) => orderC.pilihAction(value),
                itemBuilder: (BuildContext context) {
                  return SettingOrderLokasi.Pilih.map((String pilih) {
                    return PopupMenuItem<String>(
                      value: pilih,
                      child: Text(pilih),
                    );
                  }).toList();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Form(
                key: orderC.keyform,
                child: TextFormField(
                  controller: orderC.keteranganTambahan,
                  validator: (e) {
                    if (e!.isEmpty) {
                      return 'Masukkan keterangan!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.3),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    labelText: 'Keterangan Tambahan ',
                    labelStyle: TextStyle(
                        fontSize: objectApp.labelFont,
                        color: AppColors.hinttext),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}

class ItemFormKategoriSampah extends StatelessWidget {
  const ItemFormKategoriSampah({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderC = Get.find<OrderJemputanController>();
    orderC.kategoriSampah();
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2), // Offset of the shadow
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 5, top: 0, bottom: 10),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Kategori Sampah',
                          style: TextStyle(
                              color: AppColors.titleText,
                              fontFamily: objectApp.fontApp,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          changeImg.value.toString(),
                          style: TextStyle(color: Colors.transparent),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Foto Barang",
                              style: TextStyle(
                                color: AppColors.titleText,
                                fontSize: 11,
                              ),
                            ),
                            InkWell(
                              onTap: () => orderC.ambilFoto(),
                              child: Container(
                                height: size(context).width / 7,
                                width: size(context).width / 5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 2, color: Colors.grey.shade300),
                                  color: Colors.white,
                                  image: orderC.foto != null
                                      ? DecorationImage(
                                          image: FileImage(orderC.foto),
                                          fit: BoxFit.contain)
                                      : null,
                                ),
                                child: orderC.foto == null
                                    ? const Center(
                                        child: FaIcon(
                                            FontAwesomeIcons.fileImage,
                                            color: Colors.grey,
                                            size: 30),
                                      )
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              Obx(
                () {
                  if (orderC.loadingkategori.value == true) {
                    return   SizedBox(
                      height: size(context).height / 2,
                      width: size(context).width,
                      child:const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (orderC.modelKategoriSampah!.kategori.isEmpty) {
                    return SizedBox(
                      height: size(context).height / 2,
                      width: size(context).width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const FaIcon(FontAwesomeIcons.circleXmark,
                              color: Colors.grey),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              orderC.pesan.value,
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      // physics: NeverScrollableScrollPhysics(),
                      children: List.generate(
                          orderC.modelKategoriSampah!.kategori.length,
                          (index) {
                        final data = orderC.modelKategoriSampah!.kategori;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color:
                                    AppColors.themeColor.withOpacity(0.1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 10),
                                  child: Text(
                                    data[index].nama,
                                    style: const TextStyle(
                                        color: AppColors.titleText,
                                        fontFamily: objectApp.fontApp,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 8, top: 8),
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: ClipRRect(
                                          borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(5)),
                                          child: CachedNetworkImage(
                                            alignment: Alignment.center,
                                            imageUrl: data[index].image,
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            progressIndicatorBuilder:
                                                (context, url,
                                                        downloadProgress) =>
                                                    Center(
                                              child: ImagesLoadingIklan(
                                                scaleHeigth: 6,
                                              ),
                                            ),
                                            fit: BoxFit.cover,
                                            width: size(context).width,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "${data[index].deskripsi.toCapitalized()}, satuan hitungan (${data[index].satuan.toCapitalized()})",
                                        style: const TextStyle(
                                          color: AppColors.titleText,
                                          // fontFamily: objectApp.fontApp,
                                          fontSize: 12,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SwitchListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Min. Berat: ${data[index].minorder} Kg',
                                        style: const TextStyle(
                                            color: AppColors.titleText,
                                            fontFamily: objectApp.fontApp,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                        'Pilih',
                                        style: TextStyle(
                                          color: AppColors.titleText,
                                          fontFamily: objectApp.fontApp,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  value: orderC.switchValues.value[index],
                                  onChanged: (bool newValue) {
                                    print(newValue);
                                    orderC.onChange(index);
                                    orderC.onTap(index, data[index].id);
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, bottom: 15),
                                  child: Text(
                                    "Estimasi ${data[index].estimasiPoin.toString()}",
                                    style: const TextStyle(
                                      color: AppColors.titleText,
                                      fontFamily: objectApp.fontApp,
                                      fontSize: 12,
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
                },
              ),
            ],
          )),
    );
  }
}
