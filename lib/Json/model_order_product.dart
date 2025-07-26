class ModelOrderProduct {
  bool? status;
  String? message;
  Data? data;

  ModelOrderProduct({this.status, this.message, this.data});

  ModelOrderProduct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? kode;
  String? namaPemesan;
  String? produk;
  String? waAdmin;
  String? waktuPesanan;

  Data(
      {this.kode,
        this.namaPemesan,
        this.produk,
        this.waAdmin,
        this.waktuPesanan});

  Data.fromJson(Map<String, dynamic> json) {
    kode = json['kode'];
    namaPemesan = json['nama_pemesan'];
    produk = json['produk'];
    waAdmin = json['wa_admin'];
    waktuPesanan = json['waktu_pesanan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kode'] = this.kode;
    data['nama_pemesan'] = this.namaPemesan;
    data['produk'] = this.produk;
    data['wa_admin'] = this.waAdmin;
    data['waktu_pesanan'] = this.waktuPesanan;
    return data;
  }
}
