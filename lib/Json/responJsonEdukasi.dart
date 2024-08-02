// To parse this JSON data, do
//
//     final modelDaftarMitra = modelDaftarMitraFromJson(jsonString);

import 'dart:convert';

List<ModelDaftarMitra> modelDaftarMitraFromJson(String str) =>
    List<ModelDaftarMitra>.from(
        json.decode(str).map((x) => ModelDaftarMitra.fromJson(x)));

String modelDaftarMitraToJson(List<ModelDaftarMitra> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelDaftarMitra {
  String id;
  String kategori;
  String nama;
  String alamat;
  String kontak;
  String image;
  String deskripsi;
  List<Produk> produk;

  ModelDaftarMitra({
    required this.id,
    required this.kategori,
    required this.nama,
    required this.alamat,
    required this.kontak,
    required this.image,
    required this.deskripsi,
    required this.produk,
  });

  factory ModelDaftarMitra.fromJson(Map<String, dynamic> json) =>
      ModelDaftarMitra(
        id: json["id"],
        kategori: json["kategori"],
        nama: json["nama"],
        alamat: json["alamat"],
        kontak: json["kontak"],
        image: json["image"],
        deskripsi: json["deskripsi"],
        produk:
            List<Produk>.from(json["produk"].map((x) => Produk.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kategori": kategori,
        "nama": nama,
        "alamat": alamat,
        "kontak": kontak,
        "image": image,
        "deskripsi": deskripsi,
        "produk": List<dynamic>.from(produk.map((x) => x.toJson())),
      };
}

class Produk {
  String id;
  String namaProduk;
  String deskripsi;
  String tukarPoin;
  String poin;
  String image;

  Produk({
    required this.id,
    required this.namaProduk,
    required this.deskripsi,
    required this.tukarPoin,
    required this.poin,
    required this.image,
  });

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
        id: json["id"],
        namaProduk: json["nama_produk"],
        deskripsi: json["deskripsi"],
        tukarPoin: json["tukar_poin"],
        poin: json["poin"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_produk": namaProduk,
        "deskripsi": deskripsi,
        "tukar_poin": tukarPoin,
        "poin": poin,
        "image": image,
      };
}

class ProdukItemData {
  String id;
  String namaProduk;
  String deskripsi;
  String tukarPoin;
  String poin;
  String image;

  ProdukItemData({
    required this.id,
    required this.namaProduk,
    required this.deskripsi,
    required this.tukarPoin,
    required this.poin,
    required this.image,
  });

  factory ProdukItemData.fromJson(Map<String, dynamic> json) => ProdukItemData(
        id: json["id"],
        namaProduk: json["nama_produk"],
        deskripsi: json["deskripsi"],
        tukarPoin: json["tukar_poin"],
        poin: json["poin"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_produk": namaProduk,
        "deskripsi": deskripsi,
        "tukar_poin": tukarPoin,
        "poin": poin,
        "image": image,
      };
}
