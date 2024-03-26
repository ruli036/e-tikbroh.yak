// To parse this JSON data, do
//
//     final modelKategoriSampah = modelKategoriSampahFromJson(jsonString);

import 'dart:convert';

ModelKategoriSampah modelKategoriSampahFromJson(String str) =>
    ModelKategoriSampah.fromJson(json.decode(str));

String modelKategoriSampahToJson(ModelKategoriSampah data) =>
    json.encode(data.toJson());

class ModelKategoriSampah {
  bool status;
  List<Kategori> kategori;

  ModelKategoriSampah({
    required this.status,
    required this.kategori,
  });

  factory ModelKategoriSampah.fromJson(Map<String, dynamic> json) =>
      ModelKategoriSampah(
        status: json["status"],
        kategori: List<Kategori>.from(
            json["kategori"].map((x) => Kategori.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "kategori": List<dynamic>.from(kategori.map((x) => x.toJson())),
      };
}

class Kategori {
  String id;
  String nama;
  String deskripsi;
  String image;
  String minorder;
  String satuan;
  String basil;
  String hargajual;
  String videoLink;
  String estimasiPoin;
  List<Katalogsampah> katalogsampah;

  Kategori({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.image,
    required this.minorder,
    required this.satuan,
    required this.basil,
    required this.hargajual,
    required this.videoLink,
    required this.estimasiPoin,
    required this.katalogsampah,
  });

  factory Kategori.fromJson(Map<String, dynamic> json) => Kategori(
        id: json["id"],
        nama: json["nama"],
        deskripsi: json["deskripsi"],
        image: json["image"],
        minorder: json["minorder"],
        satuan: json["satuan"],
        basil: json["basil"],
        hargajual: json["hargajual"],
        videoLink: json["video_link"],
        estimasiPoin: json["estimasi_poin"],
        katalogsampah: List<Katalogsampah>.from(
            json["katalogsampah"].map((x) => Katalogsampah.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "deskripsi": deskripsi,
        "image": image,
        "minorder": minorder,
        "satuan": satuan,
        "basil": basil,
        "hargajual": hargajual,
        "video_link": videoLink,
        "estimasi_poin": estimasiPoin,
        "katalogsampah":
            List<dynamic>.from(katalogsampah.map((x) => x.toJson())),
      };
}

class Katalogsampah {
  String id;
  String idKategori;
  String image;

  Katalogsampah({
    required this.id,
    required this.idKategori,
    required this.image,
  });

  factory Katalogsampah.fromJson(Map<String, dynamic> json) => Katalogsampah(
        id: json["Id"],
        idKategori: json["id_kategori"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "id_kategori": idKategori,
        "image": image,
      };
}
