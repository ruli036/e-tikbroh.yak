class ServerUrl {
  static const urlServer = 'https://rimsdev.com/etikbroh_api/';
}

class ApiUrl {
  /// API daftar dan login user
  static const requestOpt = '${ServerUrl.urlServer}auth/requestotp';
  static const verivikasiOtp = '${ServerUrl.urlServer}auth/verifikasiemail';
  static const registrasi = '${ServerUrl.urlServer}auth/register';
  static const login = '${ServerUrl.urlServer}auth/login';
  static const registertoken = '${ServerUrl.urlServer}profile/registertokenfcm';

  /// API forgot password
  static const requestOptResetPass =
      '${ServerUrl.urlServer}auth/requestotpreset';
  static const verivikasiOtpResetPass =
      '${ServerUrl.urlServer}auth/verifikasiotpreset';
  static const resetPassword = '${ServerUrl.urlServer}auth/resetpassword';

  ///API edit data user login
  static const editUserLogin = '${ServerUrl.urlServer}profile/editdata';
  static const uploudFotoProfile = '${ServerUrl.urlServer}profile/editphoto';

  /// API Lainnya
  static const cekVersionApp = '${ServerUrl.urlServer}profile/checkversion';

  /// API tambah titik jemputan
  static const daftarTitikJemputan = '${ServerUrl.urlServer}order/titikjemput';
  static const tambahTitikJemputan = '${ServerUrl.urlServer}order/titikjemput';
  static const hapusTitikJemputan = '${ServerUrl.urlServer}order/titikjemput';

  /// API daftar jemputan
  static const daftarOrderJemputan = '${ServerUrl.urlServer}order/orderjemput';
  static const tambahOrderJemputan = '${ServerUrl.urlServer}order/orderjemput';
  static const kategoriSampah = '${ServerUrl.urlServer}order/kategorisampah';
  static const detailOrderJemput =
      '${ServerUrl.urlServer}order/detailorderjemput';
  static const batalkanOrderan = '${ServerUrl.urlServer}order/batalorder';

  ///API mitra
  static const daftarMitra = '${ServerUrl.urlServer}mitra/mitrakerjasama';
  static const produktukarpoin = '${ServerUrl.urlServer}mitra/produktukarpoin';
  static const tukarkanPoin = '${ServerUrl.urlServer}order/ordertukarpoin';
  static const riwayattukarpoin =
      '${ServerUrl.urlServer}order/riwayattukarpoin';

  /// API driver
  static const daftarJemputanDriver =
      '${ServerUrl.urlServer}driver/orderjemput';
  static const daftarRiwayatJemputanDriver =
      '${ServerUrl.urlServer}driver/riwayatjemput';
  static const detailOrderJemputDriver =
      '${ServerUrl.urlServer}driver/detailorderjemput';
  static const catatBeratDriver = '${ServerUrl.urlServer}driver/catatberat';
  static const batalJemputDriver = '${ServerUrl.urlServer}driver/bataljemput';

  /// API dashboart
  static const daftariklan = '${ServerUrl.urlServer}parameter/daftariklan';
  static const daftariklanmitra =
      '${ServerUrl.urlServer}parameter/daftariklanmitra';

  /// API profile
  static const getPoin = '${ServerUrl.urlServer}profile/getpoin';
  static const ubahpassword = '${ServerUrl.urlServer}profile/ubahpassword';
  static const getmutasipoin = '${ServerUrl.urlServer}profile/getmutasipoin';
}
