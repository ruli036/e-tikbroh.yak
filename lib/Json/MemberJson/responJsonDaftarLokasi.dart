// To parse this JSON data, do
//
//     final modelDaftarLokasiJemputan = modelDaftarLokasiJemputanFromJson(jsonString);

import 'dart:convert';

ModelDaftarLokasiJemputan modelDaftarLokasiJemputanFromJson(String str) =>
    ModelDaftarLokasiJemputan.fromJson(json.decode(str));

String modelDaftarLokasiJemputanToJson(ModelDaftarLokasiJemputan data) =>
    json.encode(data.toJson());

class ModelDaftarLokasiJemputan {
  bool status;
  List<ItemLokasi> data;

  ModelDaftarLokasiJemputan({
    required this.status,
    required this.data,
  });

  factory ModelDaftarLokasiJemputan.fromJson(Map<String, dynamic> json) =>
      ModelDaftarLokasiJemputan(
        status: json["status"] ?? false,
        data: List<ItemLokasi>.from(
            json["data"].map((x) => ItemLokasi.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ItemLokasi {
  String id;
  String namaTempat;
  String alamat;
  String titikGps;
  String detailTempat;
  String image;

  ItemLokasi({
    required this.id,
    required this.namaTempat,
    required this.alamat,
    required this.titikGps,
    required this.detailTempat,
    required this.image,
  });

  factory ItemLokasi.fromJson(Map<String, dynamic> json) => ItemLokasi(
        id: json["id"] ?? "",
        namaTempat: json["nama_tempat"] ?? "",
        alamat: json["alamat"] ?? "",
        titikGps: json["titik_gps"] ?? "",
        detailTempat: json["detail_tempat"] ?? "",
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_tempat": namaTempat,
        "alamat": alamat,
        "titik_gps": titikGps,
        "detail_tempat": detailTempat,
        "image": image,
      };
}

class ItemLokasiChace {
  String id;
  String namaTempat;
  String alamat;
  String titikGps;
  String detailTempat;
  String image;

  ItemLokasiChace({
    required this.id,
    required this.namaTempat,
    required this.alamat,
    required this.titikGps,
    required this.detailTempat,
    required this.image,
  });

  factory ItemLokasiChace.fromJson(Map<String, dynamic> json) =>
      ItemLokasiChace(
        id: json["id"] ?? "",
        namaTempat: json["nama_tempat"] ?? "",
        alamat: json["alamat"] ?? "",
        titikGps: json["titik_gps"] ?? "",
        detailTempat: json["detail_tempat"] ?? "",
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_tempat": namaTempat,
        "alamat": alamat,
        "titik_gps": titikGps,
        "detail_tempat": detailTempat,
        "image": image,
      };
}
