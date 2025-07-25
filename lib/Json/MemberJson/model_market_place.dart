import 'dart:convert';

ModelListDataMarketPlace modelListDataMarketPlace(String str) => ModelListDataMarketPlace.fromJson(json.decode(str));
class ModelListDataMarketPlace {
  bool? status;
  String? message;
  List<ItemData>? data;
  int? totalpage;
  int? nextpage;
  String? urlnext;

  ModelListDataMarketPlace(
      {this.status,
        this.message,
        this.data,
        this.totalpage,
        this.nextpage,
        this.urlnext});

  ModelListDataMarketPlace.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ItemData>[];
      json['data'].forEach((v) {
        data!.add(new ItemData.fromJson(v));
      });
    }
    totalpage = json['totalpage'];
    nextpage = json['nextpage'];
    urlnext = json['urlnext'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalpage'] = this.totalpage;
    data['nextpage'] = this.nextpage;
    data['urlnext'] = this.urlnext;
    return data;
  }
}

class ItemData {
  String? id;
  String? namaProduk;
  String? deskripsi;
  String? mitra;
  String? readyStok;
  int? harga;
  String? dilihat;
  String? terjual;
  List<Photo>? photo;

  ItemData(
      {this.id,
        this.namaProduk,
        this.deskripsi,
        this.mitra,
        this.readyStok,
        this.harga,
        this.dilihat,
        this.terjual,
        this.photo});

  ItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaProduk = json['nama_produk'];
    deskripsi = json['deskripsi'];
    mitra = json['mitra'];
    readyStok = json['ready_stok'];
    harga = json['harga'];
    dilihat = json['dilihat'];
    terjual = json['terjual'];
    if (json['photo'] != null) {
      photo = <Photo>[];
      json['photo'].forEach((v) {
        photo!.add(new Photo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_produk'] = this.namaProduk;
    data['deskripsi'] = this.deskripsi;
    data['mitra'] = this.mitra;
    data['ready_stok'] = this.readyStok;
    data['harga'] = this.harga;
    data['dilihat'] = this.dilihat;
    data['terjual'] = this.terjual;
    if (this.photo != null) {
      data['photo'] = this.photo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Photo {
  String? image;

  Photo({this.image});

  Photo.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}
