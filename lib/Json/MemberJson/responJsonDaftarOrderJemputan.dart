import 'dart:convert';

ModelDaftarOrderJemputan modelDaftarOrderJemputanFromJson(String str) =>
    ModelDaftarOrderJemputan.fromJson(json.decode(str));

String modelDaftarOrderJemputanToJson(ModelDaftarOrderJemputan data) =>
    json.encode(data.toJson());

class ModelDaftarOrderJemputan {
  bool status;
  String message;
  List<ItemOrder> data;
  List<Liststatus> liststatus;
  int totalpage;
  int nextpage;
  String urlnext;

  ModelDaftarOrderJemputan({
    required this.status,
    required this.message,
    required this.data,
    required this.liststatus,
    required this.totalpage,
    required this.nextpage,
    required this.urlnext,
  });

  factory ModelDaftarOrderJemputan.fromJson(Map<String, dynamic> json) =>
      ModelDaftarOrderJemputan(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: List<ItemOrder>.from(json["data"].map((x) => ItemOrder.fromJson(x))),
        liststatus: List<Liststatus>.from(json["liststatus"].map((x) => Liststatus.fromJson(x))),
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

class ItemOrder {
  String id;
  String tglorder;
  String tgljemput;
  String driver;
  String foto;
  String status;
  String statuscode;
  Lokasijemput lokasijemput;
  List<Detail> detail;

  ItemOrder({
    required this.id,
    required this.tglorder,
    required this.tgljemput,
    required this.driver,
    required this.foto,
    required this.status,
    required this.statuscode,
    required this.lokasijemput,
    required this.detail,
  });

  factory ItemOrder.fromJson(Map<String, dynamic> json) => ItemOrder(
        id: json["id"] ?? "",
        tglorder: json["tglorder"] ?? "",
        tgljemput: json["tgljemput"] ?? "",
        driver: json["driver"] ?? "",
        foto: json["foto"] ?? "",
        status: json["status"] ?? "",
        statuscode: json["statuscode"] ?? "",
        lokasijemput: Lokasijemput.fromJson(json["lokasijemput"]),
        detail:
            List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tglorder": tglorder,
        "tgljemput": tgljemput,
        "driver": driver,
        "foto": foto,
        "status": status,
        "statuscode": statuscode,
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

class Liststatus {
  String code;
  String keterangan;

  Liststatus({
    required this.code,
    required this.keterangan,
  });

  factory Liststatus.fromJson(Map<String, dynamic> json) => Liststatus(
        code: json["code"] ?? "",
        keterangan: json["keterangan"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "keterangan": keterangan,
      };
}

class Lokasijemput {
  String id;
  String iduser;
  String namaTempat;
  String alamat;
  String titikGps;
  String foto;
  String detailTempat;
  String stts;

  Lokasijemput({
    required this.id,
    required this.iduser,
    required this.namaTempat,
    required this.alamat,
    required this.titikGps,
    required this.foto,
    required this.detailTempat,
    required this.stts,
  });

  factory Lokasijemput.fromJson(Map<String, dynamic> json) => Lokasijemput(
        id: json["Id"] ?? "",
        iduser: json["iduser"] ?? "",
        namaTempat: json["nama_tempat"] ?? "",
        alamat: json["alamat"] ?? "",
        titikGps: json["titik_gps"] ?? "",
        foto: json["foto"] ?? "",
        detailTempat: json["detail_tempat"] ?? "",
        stts: json["stts"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "iduser": iduser,
        "nama_tempat": namaTempat,
        "alamat": alamat,
        "titik_gps": titikGps,
        "foto": foto,
        "detail_tempat": detailTempat,
        "stts": stts,
      };
}
