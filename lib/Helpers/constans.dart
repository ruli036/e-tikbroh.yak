import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Models/Driver/jemputan_view.dart';
import 'package:e_tikbroh_yok/Models/Edukasi/edukasi_view.dart';
import 'package:e_tikbroh_yok/Models/Home/home_view.dart';
import 'package:e_tikbroh_yok/Models/Home_v2/home_view.dart';
import 'package:e_tikbroh_yok/Models/OrderJemputan/daftar_jemputan_view.dart';
import 'package:e_tikbroh_yok/Models/OrderJemputan/jemputan_view.dart';
import 'package:e_tikbroh_yok/Models/Point/pont_view.dart';
import 'package:e_tikbroh_yok/Models/Profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class objectApp {
  static const logoApp = 'assets/logo-putih.png';
  static const logoAlert = 'assets/logo2.png';
  static const fontApp = 'OpenSansBold';
  static const OpenSansreguler = 'OpenSansreguler';
  static double labelFont = 12;
}

const String STORAGE_STATUS_LOGIN = "status";
const String STORAGE_EMAIL = "email";
const String STORAGE_TOKEN = "token";
const String STORAGE_NAMA = "nama";
const String STORAGE_FOTO = "foto";
const String STORAGE_VERSION_APP = "version";
const String STORAGE_NO_HP = "nohp";
const String STORAGE_STATUS_USER = "level";
const String STORAGE_DATA_LOKASI = "lokasi";
const String STORAGE_POIN_USER = "poin";
const String STORAGE_NOMINAL_POIN = "rupiah";
double IconSize = 25;
double IconSizeMenu = 22;
FaIcon iconNotFound =
    const FaIcon(FontAwesomeIcons.fileCircleExclamation, color: Colors.grey);
List<Widget> widgetOptions = <Widget>[
  // const HomePageView(),
  const HomeView(),
  const JemputSampahView(),
  const EdukasiView(),
  const PointView(),
  const ProfileView(),
];

List<Widget> IconMenu = [
  Image.asset('assets/icon/jemput.png'),
  Image.asset('assets/icon/jemput.png'),
  Image.asset('assets/icon/jemput.png'),
  Image.asset('assets/icon/jemput.png'),
  Image.asset('assets/icon/jemput.png'),
];
List IconBottomMenu = [
  FaIcon(
    FontAwesomeIcons.house,
    size: IconSizeMenu,
  ),
  FaIcon(
    FontAwesomeIcons.truck,
    size: IconSizeMenu,
  ),
  FaIcon(
    FontAwesomeIcons.book,
    size: IconSizeMenu,
  ),
  FaIcon(
    FontAwesomeIcons.arrowRightArrowLeft,
    size: IconSizeMenu,
  ),
  FaIcon(
    FontAwesomeIcons.circleUser,
    size: IconSizeMenu,
  ),
];

List TitleMenu = [
  'jemput',
  'Market Place',
  'tukar poin',
  'Mitra',
  'Riwayat Jemputan',
];
List TitleBottomMenu = [
  'Home',
  'jemputan',
  'edukasi',
  'tukar poin',
  'Profile',
];

List MenuProfile = [
  'jemputan',
  'tukar poin',
  'Mitra',
  'Katalog',
  'lokasi jemputan',
  'Ganti Foto Profile',
  'Ganti Password',
];
List<Widget> widgetOptionsDriver = <Widget>[
  // const HomePageView(),
  const HomeView(),
  const JemputanDriver(),
  const EdukasiView(),
  const PointView(),
  const ProfileView(),
];
List<Widget> IconMenuDriver = [
  FaIcon(
    FontAwesomeIcons.truck,
    color: AppColors.iconColorButton,
    size: IconSize,
  ),
  FaIcon(
    FontAwesomeIcons.solidHandshake,
    color: AppColors.iconColorButton,
    size: IconSize,
  ),
  FaIcon(
    FontAwesomeIcons.arrowRightArrowLeft,
    color: AppColors.iconColorButton,
    size: IconSize,
  ),
  FaIcon(
    FontAwesomeIcons.book,
    color: AppColors.iconColorButton,
    size: IconSize,
  ),
  FaIcon(
    FontAwesomeIcons.cartShopping,
    color: AppColors.iconColorButton,
    size: IconSize,
  ),
  FaIcon(
    FontAwesomeIcons.arrowRight,
    color: AppColors.iconColorButton,
    size: IconSize,
  ),
];
List IconBottomMenuDriver = [
  FaIcon(
    FontAwesomeIcons.house,
    size: IconSizeMenu,
  ),
  FaIcon(
    FontAwesomeIcons.truck,
    size: IconSizeMenu,
  ),
  FaIcon(
    FontAwesomeIcons.book,
    size: IconSizeMenu,
  ),
  FaIcon(
    FontAwesomeIcons.arrowRightArrowLeft,
    size: IconSizeMenu,
  ),
  FaIcon(
    FontAwesomeIcons.circleUser,
    size: IconSizeMenu,
  ),
];
List TitleMenuDriver = [
  'jemputan',
  'Mitra',
  'tukar poin',
  'Katalog',
  'Market Place',
  'lainnya',
];

List MenuProfileDriver = [
  'jemputan',
  'tukar poin',
  'Katalog',
  'Mitra',
  'Ganti Foto Profile',
  'Ganti Password',
];

class Setting {
  static const String openMap = 'Telusuri';
  static const String hapus = 'Hapus';

  static const List<String> Pilih = <String>[openMap, hapus];
}

class SettingOrderLokasi {
  static const String pilihLokasi = 'Pilih Lokasi';
  static const String tambahLokasi = 'Tambah Lokasi';

  static const List<String> Pilih = <String>[pilihLokasi, tambahLokasi];
}

/// menu app versi 2.0
List TitleMenuV2 = [
  'Tukar Poin',
  'Riwayat',
  'Mitra',
];
List descTitleMenuV2 = [
  'Tukar poin dengan\nproduk menarik',
  'Lihat riwayat\npenjemputan\nsampahmu!',
  'Mari kenali\nmitra kami',
];
List IconTitleMenuV2 = [
  'assets/icon/tukar-poin.png',
  'assets/icon/riwayat.png',
  'assets/icon/mitra.png',
];

/// icon menu katalog
List TitleKatalog = [
  'Botol',
  'Kertas',
  'Kardus',
  'Plastik',
];
List IconTitleKatalog = [
  'assets/icon/botol.png',
  'assets/icon/kertas.png',
  'assets/icon/kardus.png',
  'assets/icon/plastik.png',
];