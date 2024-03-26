// To parse this JSON data, do
//
//     final modelRiwayatJemputanDriver = modelRiwayatJemputanDriverFromJson(jsonString);

import 'dart:convert';

ModelRiwayatJemputanDriver modelRiwayatJemputanDriverFromJson(String str) =>
    ModelRiwayatJemputanDriver.fromJson(json.decode(str));

String modelRiwayatJemputanDriverToJson(ModelRiwayatJemputanDriver data) =>
    json.encode(data.toJson());

class ModelRiwayatJemputanDriver {
  bool status;
  String message;
  List<DataRiwayat> data;
  int totalpage;
  int nextpage;
  String urlnext;

  ModelRiwayatJemputanDriver({
    required this.status,
    required this.message,
    required this.data,
    required this.totalpage,
    required this.nextpage,
    required this.urlnext,
  });

  factory ModelRiwayatJemputanDriver.fromJson(Map<String, dynamic> json) =>
      ModelRiwayatJemputanDriver(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: List<DataRiwayat>.from(
            json["data"].map((x) => DataRiwayat.fromJson(x))),
        totalpage: json["totalpage"] ?? 0,
        nextpage: json["nextpage"] ?? 0,
        urlnext: json["urlnext"] ?? "",
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

class DataRiwayat {
  String id;
  String tglorder;
  String tgljemput;
  String driver;
  String member;
  String foto;
  String status;
  Lokasijemput lokasijemput;
  List<Detail> detail;

  DataRiwayat({
    required this.id,
    required this.tglorder,
    required this.tgljemput,
    required this.driver,
    required this.member,
    required this.foto,
    required this.status,
    required this.lokasijemput,
    required this.detail,
  });

  factory DataRiwayat.fromJson(Map<String, dynamic> json) => DataRiwayat(
        id: json["id"] ?? "",
        tglorder: json["tglorder"] ?? "",
        tgljemput: json["tgljemput"] ?? "",
        driver: json["driver"] ?? "",
        member: json["member"] ?? "",
        foto: json["foto"] ?? "",
        status: json["status"] ?? "",
        lokasijemput: Lokasijemput.fromJson(json["lokasijemput"]),
        detail:
            List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
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
        "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
      };
}

class Detail {
  String nama;
  String berat;
  String hargaJual;
  String total;

  Detail({
    required this.nama,
    required this.berat,
    required this.hargaJual,
    required this.total,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        nama: json["nama"] ?? "",
        berat: json["berat"] ?? "",
        hargaJual: json["harga_jual"] ?? "",
        total: json["total"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "berat": berat,
        "harga_jual": hargaJual,
        "total": total,
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
