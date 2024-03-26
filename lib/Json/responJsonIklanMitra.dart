import 'dart:convert';

ModelIklanMitra modelIklanMitraFromJson(String str) =>
    ModelIklanMitra.fromJson(json.decode(str));

String modelIklanMitraToJson(ModelIklanMitra data) =>
    json.encode(data.toJson());

class ModelIklanMitra {
  bool status;
  List<AllData> data;

  ModelIklanMitra({
    required this.status,
    required this.data,
  });

  factory ModelIklanMitra.fromJson(Map<String, dynamic> json) =>
      ModelIklanMitra(
        status: json["status"],
        data: List<AllData>.from(json["data"].map((x) => AllData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AllData {
  String id;
  String gambar;
  String title;
  String deskripsi;

  AllData({
    required this.id,
    required this.gambar,
    required this.title,
    required this.deskripsi,
  });

  factory AllData.fromJson(Map<String, dynamic> json) => AllData(
        id: json["id"],
        gambar: json["gambar"],
        title: json["title"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gambar": gambar,
        "title": title,
        "deskripsi": deskripsi,
      };
}

class IklanHome {
  String id;
  String gambar;
  String title;
  String deskripsi;

  IklanHome({
    required this.id,
    required this.gambar,
    required this.title,
    required this.deskripsi,
  });

  factory IklanHome.fromJson(Map<String, dynamic> json) => IklanHome(
        id: json["id"],
        gambar: json["gambar"],
        title: json["title"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gambar": gambar,
        "title": title,
        "deskripsi": deskripsi,
      };
}
