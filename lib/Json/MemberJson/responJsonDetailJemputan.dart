// To parse this JSON data, do
//
//     final modelDetailJemputan = modelDetailJemputanFromJson(jsonString);

import 'dart:convert';

ModelDetailJemputan modelDetailJemputanFromJson(String str) =>
    ModelDetailJemputan.fromJson(json.decode(str));

String modelDetailJemputanToJson(ModelDetailJemputan data) =>
    json.encode(data.toJson());

class ModelDetailJemputan {
  bool status;
  String message;
  Data data;

  ModelDetailJemputan({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ModelDetailJemputan.fromJson(Map<String, dynamic> json) =>
      ModelDetailJemputan(
        status: json["status"] ?? false,
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
  String noinv;
  String driver;
  String foto;
  String keterangan;
  String status;
  Lokasijemput lokasijemput;
  List<Detail> detail;
  List<Tracking> tracking;

  Data({
    required this.id,
    required this.tglorder,
    required this.noinv,
    required this.tgljemput,
    required this.driver,
    required this.foto,
    required this.keterangan,
    required this.status,
    required this.lokasijemput,
    required this.detail,
    required this.tracking,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["Id"] ?? "",
        tglorder: json["tglorder"] ?? "",
        noinv: json["noinv"] ?? "",
        tgljemput: json["tgljemput"] ?? "",
        driver: json["driver"] ?? "",
        foto: json["foto"] ?? "",
        keterangan: json["keterangan"] ?? "",
        status: json["status"] ?? "",
        lokasijemput: Lokasijemput.fromJson(json["lokasijemput"]),
        detail:
            List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
        tracking: List<Tracking>.from(
            json["tracking"].map((x) => Tracking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "tglorder": tglorder,
        "tgljemput": tgljemput,
        "noinv": noinv,
        "driver": driver,
        "foto": foto,
        "keterangan": keterangan,
        "status": status,
        "lokasijemput": lokasijemput.toJson(),
        "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
        "tracking": List<dynamic>.from(tracking.map((x) => x.toJson())),
      };
}

class Detail {
  String nama;
  String berat;
  String hargaJual;
  String total;
  String poin;
  String foto;

  Detail({
    required this.nama,
    required this.berat,
    required this.hargaJual,
    required this.total,
    required this.poin,
    required this.foto,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        nama: json["nama"] ?? "",
        berat: json["berat"] ?? "",
        hargaJual: json["harga_jual"] ?? "",
        total: json["total"] ?? "",
        poin: json["poin"] ?? "",
        foto: json["foto"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "berat": berat,
        "harga_jual": hargaJual,
        "total": total,
        "poin": poin,
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

class Tracking {
  String admin;
  String member;
  String driver;
  String status;
  String catatan;
  String waktu;

  Tracking({
    required this.admin,
    required this.member,
    required this.driver,
    required this.status,
    required this.catatan,
    required this.waktu,
  });

  factory Tracking.fromJson(Map<String, dynamic> json) => Tracking(
        admin: json["admin"] ?? "",
        member: json["member"] ?? "",
        driver: json["driver"] ?? "",
        status: json["status"] ?? "",
        catatan: json["catatan"] ?? "",
        waktu: json["waktu"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "admin": admin,
        "member": member,
        "driver": driver,
        "status": status,
        "catatan": catatan,
        "waktu": waktu,
      };
}
