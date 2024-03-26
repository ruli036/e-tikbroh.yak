// To parse this JSON data, do
//
//     final modelDetailJemputanDriver = modelDetailJemputanDriverFromJson(jsonString);

import 'dart:convert';

ModelDetailJemputanDriver modelDetailJemputanDriverFromJson(String str) =>
    ModelDetailJemputanDriver.fromJson(json.decode(str));

String modelDetailJemputanDriverToJson(ModelDetailJemputanDriver data) =>
    json.encode(data.toJson());

class ModelDetailJemputanDriver {
  bool status;
  String message;
  Data data;

  ModelDetailJemputanDriver({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ModelDetailJemputanDriver.fromJson(Map<String, dynamic> json) =>
      ModelDetailJemputanDriver(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String id;
  String tglorder;
  String tgljemput;
  String member;
  String driver;
  String kontakmember;
  String foto;
  String keterangan;
  String status;
  Lokasijemput lokasijemput;
  List<DetailJemputanDriver> detail;

  Data({
    required this.id,
    required this.tglorder,
    required this.tgljemput,
    required this.member,
    required this.driver,
    required this.kontakmember,
    required this.foto,
    required this.keterangan,
    required this.status,
    required this.lokasijemput,
    required this.detail,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] ?? "",
        tglorder: json["tglorder"] ?? "",
        tgljemput: json["tgljemput"] ?? "",
        member: json["member"] ?? "",
        driver: json["driver"] ?? "",
        kontakmember: json["kontakmember"] ?? "",
        foto: json["foto"] ?? "",
        keterangan: json["keterangan"] ?? "",
        status: json["status"] ?? "",
        lokasijemput: Lokasijemput.fromJson(json["lokasijemput"]),
        detail: List<DetailJemputanDriver>.from(
            json["detail"].map((x) => DetailJemputanDriver.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tglorder": tglorder,
        "tgljemput": tgljemput,
        "member": member,
        "driver": driver,
        "kontakmember": kontakmember,
        "foto": foto,
        "keterangan": keterangan,
        "status": status,
        "lokasijemput": lokasijemput.toJson(),
        "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
      };
}

class DetailJemputanDriver {
  String id;
  String nama;
  String berat;
  String poin;
  String hargaJual;
  String total;
  String foto;

  DetailJemputanDriver({
    required this.id,
    required this.nama,
    required this.berat,
    required this.poin,
    required this.hargaJual,
    required this.total,
    required this.foto,
  });

  factory DetailJemputanDriver.fromJson(Map<String, dynamic> json) =>
      DetailJemputanDriver(
        id: json["Id"] ?? "",
        nama: json["nama"] ?? "",
        berat: json["berat"] ?? "",
        poin: json["poin"] ?? "0",
        hargaJual: json["harga_jual"] ?? "",
        total: json["total"] ?? "",
        foto: json["foto"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "nama": nama,
        "berat": berat,
        "poin": poin,
        "harga_jual": hargaJual,
        "total": total,
        "foto": foto,
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
