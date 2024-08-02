// To parse this JSON data, do
//
//     final modelProdukPenukaran = modelProdukPenukaranFromJson(jsonString);

import 'dart:convert';

List<ModelProdukPenukaran> modelProdukPenukaranFromJson(String str) =>
    List<ModelProdukPenukaran>.from(
        json.decode(str).map((x) => ModelProdukPenukaran.fromJson(x)));

String modelProdukPenukaranToJson(List<ModelProdukPenukaran> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelProdukPenukaran {
  String id;
  String namaProduk;
  String deskripsi;
  String poin;
  String image;
  String namaMitra;

  ModelProdukPenukaran({
    required this.id,
    required this.namaProduk,
    required this.deskripsi,
    required this.poin,
    required this.image,
    required this.namaMitra,
  });

  factory ModelProdukPenukaran.fromJson(Map<String, dynamic> json) =>
      ModelProdukPenukaran(
        id: json["id"],
        namaProduk: json["nama_produk"],
        deskripsi: json["deskripsi"],
        poin: json["poin"],
        image: json["image"],
        namaMitra: json["nama_mitra"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_produk": namaProduk,
        "deskripsi": deskripsi,
        "poin": poin,
        "image": image,
        "nama_mitra": namaMitra,
      };
}
