import 'package:e_tikbroh_yok/Helpers/helpers.dart';
import 'package:e_tikbroh_yok/Models/Driver/jemputan_view.dart';
import 'package:e_tikbroh_yok/Models/Edukasi/edukasi_view.dart';
import 'package:e_tikbroh_yok/Models/Home/home_view.dart';
import 'package:e_tikbroh_yok/Models/OrderJemputan/daftar_jemputan_view.dart';
import 'package:e_tikbroh_yok/Models/Point/pont_view.dart';
import 'package:e_tikbroh_yok/Models/Profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class objectApp {
  static const logoApp = 'assets/logo2.png';
  static const fontApp = 'Roboto1';
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
double IconSize = 20;
double IconSizeMenu = 22;
FaIcon iconNotFound =
    const FaIcon(FontAwesomeIcons.fileCircleExclamation, color: Colors.grey);
List<Widget> widgetOptions = <Widget>[
  const HomePageView(),
  const DaftarJemputanView(),
  const EdukasiView(),
  const PointView(),
  const ProfileView(),
];

List<Widget> IconMenu = [
  FaIcon(
    FontAwesomeIcons.truck,
    color: AppColors.iconColorButton,
    size: IconSize,
  ),
  FaIcon(
    FontAwesomeIcons.box,
    color: AppColors.iconColorButton,
    size: IconSize,
  ),
  FaIcon(
    FontAwesomeIcons.store,
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
    FontAwesomeIcons.box,
    size: IconSizeMenu,
  ),
  FaIcon(
    FontAwesomeIcons.circleUser,
    size: IconSizeMenu,
  ),
];

List TitleMenu = [
  'jemputan',
  'tukar poin',
  'Mitra',
  'Katalog',
  'Market Place',
  'lainnya',
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
  const HomePageView(),
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
    FontAwesomeIcons.store,
    color: AppColors.iconColorButton,
    size: IconSize,
  ),
  FaIcon(
    FontAwesomeIcons.box,
    color: AppColors.iconColorButton,
    size: IconSize,
  ),
  FaIcon(
    FontAwesomeIcons.book,
    size: IconSizeMenu,
  ),
  FaIcon(
    FontAwesomeIcons.box,
    size: IconSizeMenu,
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
    FontAwesomeIcons.box,
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
