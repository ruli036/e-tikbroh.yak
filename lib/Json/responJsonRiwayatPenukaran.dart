// To parse this JSON data, do
//
//     final modelRiwayatPenukaran = modelRiwayatPenukaranFromJson(jsonString);

import 'dart:convert';

ModelRiwayatPenukaran modelRiwayatPenukaranFromJson(String str) =>
    ModelRiwayatPenukaran.fromJson(json.decode(str));

String modelRiwayatPenukaranToJson(ModelRiwayatPenukaran data) =>
    json.encode(data.toJson());

class ModelRiwayatPenukaran {
  bool status;
  String message;
  List<ItemRiwayat> data;
  int totalpage;
  int nextpage;
  String urlnext;

  ModelRiwayatPenukaran({
    required this.status,
    required this.message,
    required this.data,
    required this.totalpage,
    required this.nextpage,
    required this.urlnext,
  });

  factory ModelRiwayatPenukaran.fromJson(Map<String, dynamic> json) =>
      ModelRiwayatPenukaran(
        status: json["status"],
        message: json["message"],
        data: List<ItemRiwayat>.from(
            json["data"].map((x) => ItemRiwayat.fromJson(x))),
        totalpage: json["totalpage"],
        nextpage: json["nextpage"],
        urlnext: json["urlnext"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "totalpage": totalpage,
        "nextpage": nextpage,
        "urlnext": urlnext,
      };
}

class ItemRiwayat {
  String tanggal;
  String namaProduk;
  String deskripsi;
  String poin;
  String image;
  String stts;

  ItemRiwayat({
    required this.tanggal,
    required this.namaProduk,
    required this.deskripsi,
    required this.poin,
    required this.image,
    required this.stts,
  });

  factory ItemRiwayat.fromJson(Map<String, dynamic> json) => ItemRiwayat(
        tanggal: json["tanggal"],
        namaProduk: json["nama_produk"],
        deskripsi: json["deskripsi"],
        poin: json["poin"],
        image: json["image"],
        stts: json["stts"],
      );

  Map<String, dynamic> toJson() => {
        "tanggal": tanggal,
        "nama_produk": namaProduk,
        "deskripsi": deskripsi,
        "poin": poin,
        "image": image,
        "stts": stts,
      };
}
