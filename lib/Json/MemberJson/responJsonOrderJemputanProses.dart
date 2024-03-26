
import 'dart:convert';

ModelResponProsesJemputan modelResponProsesJemputanFromJson(String str) => ModelResponProsesJemputan.fromJson(json.decode(str));

String modelResponProsesJemputanToJson(ModelResponProsesJemputan data) => json.encode(data.toJson());

class ModelResponProsesJemputan {
  bool status;
  List<ListstatusProses> liststatus;
  String message;
  List<DataProses> data;

  ModelResponProsesJemputan({
    required this.status,
    required this.liststatus,
    required this.message,
    required this.data,
  });

  factory ModelResponProsesJemputan.fromJson(Map<String, dynamic> json) => ModelResponProsesJemputan(
    status: json["status"],
    liststatus: List<ListstatusProses>.from(json["liststatus"].map((x) => ListstatusProses.fromJson(x))),
    message: json["message"],
    data: List<DataProses>.from(json["data"].map((x) => DataProses.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "liststatus": List<dynamic>.from(liststatus.map((x) => x.toJson())),
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataProses {
  String id;
  String tglorder;
  String tgljemput;
  String driver;
  String foto;
  String status;
  String statuscode;
  Lokasijemput lokasijemput;
  List<Detail> detail;

  DataProses({
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

  factory DataProses.fromJson(Map<String, dynamic> json) => DataProses(
    id: json["id"],
    tglorder: json["tglorder"],
    tgljemput: json["tgljemput"],
    driver: json["driver"],
    foto: json["foto"],
    status: json["status"],
    statuscode: json["statuscode"],
    lokasijemput: Lokasijemput.fromJson(json["lokasijemput"]),
    detail: List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
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
    nama: json["nama"],
    berat: json["berat"],
    hargaJual: json["harga_jual"],
    total: json["total"],
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
    namaTempat: json["nama_tempat"],
    alamat: json["alamat"],
    titikGps: json["titik_gps"],
    foto: json["foto"],
    detailTempat: json["detail_tempat"],
  );

  Map<String, dynamic> toJson() => {
    "nama_tempat": namaTempat,
    "alamat": alamat,
    "titik_gps": titikGps,
    "foto": foto,
    "detail_tempat": detailTempat,
  };
}

class ListstatusProses {
  String code;
  String keterangan;

  ListstatusProses({
    required this.code,
    required this.keterangan,
  });

  factory ListstatusProses.fromJson(Map<String, dynamic> json) => ListstatusProses(
    code: json["code"],
    keterangan: json["keterangan"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "keterangan": keterangan,
  };
}
