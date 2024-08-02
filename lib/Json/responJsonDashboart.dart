import 'dart:convert';

ModelDaftarIklan modelDaftarIklanFromJson(String str) =>
    ModelDaftarIklan.fromJson(json.decode(str));

String modelDaftarIklanToJson(ModelDaftarIklan data) =>
    json.encode(data.toJson());

class ModelDaftarIklan {
  bool status;
  List<Datum> data;

  ModelDaftarIklan({
    required this.status,
    required this.data,
  });

  factory ModelDaftarIklan.fromJson(Map<String, dynamic> json) =>
      ModelDaftarIklan(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String gambar;

  Datum({
    required this.id,
    required this.gambar,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        gambar: json["gambar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gambar": gambar,
      };
}

ModelPoinUser modelPoinUserFromJson(String str) =>
    ModelPoinUser.fromJson(json.decode(str));

String modelPoinUserToJson(ModelPoinUser data) => json.encode(data.toJson());

class ModelPoinUser {
  bool status;
  Keluar masuk;
  Keluar keluar;
  Keluar selisih;

  ModelPoinUser({
    required this.status,
    required this.masuk,
    required this.keluar,
    required this.selisih,
  });

  factory ModelPoinUser.fromJson(Map<String, dynamic> json) => ModelPoinUser(
        status: json["status"],
        masuk: Keluar.fromJson(json["masuk"]),
        keluar: Keluar.fromJson(json["keluar"]),
        selisih: Keluar.fromJson(json["selisih"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "masuk": masuk.toJson(),
        "keluar": keluar.toJson(),
        "selisih": selisih.toJson(),
      };
}

class Keluar {
  int rupiah;
  int poin;

  Keluar({
    required this.rupiah,
    required this.poin,
  });

  factory Keluar.fromJson(Map<String, dynamic> json) => Keluar(
        rupiah: json["rupiah"],
        poin: json["poin"],
      );

  Map<String, dynamic> toJson() => {
        "rupiah": rupiah,
        "poin": poin,
      };
}
