// To parse this JSON data, do
//
//     final modeMutasiPoin = modeMutasiPoinFromJson(jsonString);

import 'dart:convert';

ModelMutasiPoin modelMutasiPoinFromJson(String str) =>
    ModelMutasiPoin.fromJson(json.decode(str));

String modelMutasiPoinToJson(ModelMutasiPoin data) =>
    json.encode(data.toJson());

class ModelMutasiPoin {
  bool status;
  String message;
  List<DataMutasi> data;
  int totalpage;
  int nextpage;
  String urlnext;

  ModelMutasiPoin({
    required this.status,
    required this.message,
    required this.data,
    required this.totalpage,
    required this.nextpage,
    required this.urlnext,
  });

  factory ModelMutasiPoin.fromJson(Map<String, dynamic> json) =>
      ModelMutasiPoin(
        status: json["status"],
        message: json["message"],
        data: List<DataMutasi>.from(
            json["data"].map((x) => DataMutasi.fromJson(x))),
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

class DataMutasi {
  String tanggal;
  String keterangan;
  String post;
  String saldo;

  DataMutasi({
    required this.tanggal,
    required this.keterangan,
    required this.post,
    required this.saldo,
  });

  factory DataMutasi.fromJson(Map<String, dynamic> json) => DataMutasi(
        tanggal: json["tanggal"] ?? "",
        keterangan: json["keterangan"] ?? "",
        post: json["post"] ?? "",
        saldo: json["saldo"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "tanggal": tanggal,
        "keterangan": keterangan,
        "post": post,
        "saldo": saldo,
      };
}
