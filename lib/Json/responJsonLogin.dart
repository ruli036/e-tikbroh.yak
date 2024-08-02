class ResponLogin {
  ResponLogin(
      {required this.status,
      required this.message,
      required this.level,
      required this.nohp,
      required this.version,
      required this.foto,
      required this.nama,
      required this.token,
      required this.email});

  bool status;
  String message;
  String nama;
  String email;
  String nohp;
  String foto;
  String level;
  String version;
  String token;

  factory ResponLogin.fromJson(Map<String, dynamic> json) => ResponLogin(
        status: json["status"] ?? false,
        message: json["message"] ?? '',
        nama: json["nama"] ?? '',
        email: json["email"] ?? '',
        nohp: json["nohp"] ?? '',
        level: json["level"] ?? '',
        foto: json["foto"] ?? '',
        version: json["version"] ?? '',
        token: json["token"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "nama": nama,
        "email": email,
        "nohp": nohp,
        "foto": foto,
        "level": level,
        "version": version,
        "token": token,
      };
}
