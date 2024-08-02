// To parse this JSON data, do
//
//     final modelDaftarJemputanDriver = modelDaftarJemputanDriverFromJson(jsonString);

import 'dart:convert';

ModelDaftarJemputanDriver modelDaftarJemputanDriverFromJson(String str) =>
    ModelDaftarJemputanDriver.fromJson(json.decode(str));

String modelDaftarJemputanDriverToJson(ModelDaftarJemputanDriver data) =>
    json.encode(data.toJson());

class ModelDaftarJemputanDriver {
  bool status;
  String message;
  List<Data> data;

  ModelDaftarJemputanDriver({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ModelDaftarJemputanDriver.fromJson(Map<String, dynamic> json) =>
      ModelDaftarJemputanDriver(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  String id;
  String tglorder;
  String tgljemput;
  String driver;
  String member;
  String foto;
  String status;
  Lokasijemput lokasijemput;

  Data({
    required this.id,
    required this.tglorder,
    required this.tgljemput,
    required this.driver,
    required this.member,
    required this.foto,
    required this.status,
    required this.lokasijemput,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] ?? "",
        tglorder: json["tglorder"] ?? "",
        tgljemput: json["tgljemput"] ?? "",
        driver: json["driver"] ?? "",
        member: json["member"] ?? "",
        foto: json["foto"] ?? "",
        status: json["status"] ?? "",
        lokasijemput: Lokasijemput.fromJson(json["lokasijemput"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tglorder": tglorder,
        "tgljemput": tgljemput,
        "driver": driver,
        "member": member,
        "foto": foto,
        "status": status,
        "lokasijemput": lokasijemput.toJson(),
      };
}

class Lokasijemput {
  String namaTempat;
  String alamat;
  String titikGps;
  String foto;
  String detailTempat;

  Lokasijemput({
    required this.namaTempat,
    required this.alamat,
    required this.titikGps,
    required this.foto,
    required this.detailTempat,
  });

  factory Lokasijemput.fromJson(Map<String, dynamic> json) => Lokasijemput(
        namaTempat: json["nama_tempat"] ?? "",
        alamat: json["alamat"] ?? "",
        titikGps: json["titik_gps"] ?? "",
        foto: json["foto"] ?? "",
        detailTempat: json["detail_tempat"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "nama_tempat": namaTempat,
        "alamat": alamat,
        "titik_gps": titikGps,
        "foto": foto,
        "detail_tempat": detailTempat,
      };
}
