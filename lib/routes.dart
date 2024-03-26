import 'package:e_tikbroh_yok/Models/Driver/detail_jemputan_view.dart';
import 'package:e_tikbroh_yok/Models/Edukasi/edukasi_view.dart';
import 'package:e_tikbroh_yok/Models/LokasiJemputan/lokasi_view.dart';
import 'package:e_tikbroh_yok/Models/LokasiJemputan/tambah_lokasi.dart';
import 'package:e_tikbroh_yok/Models/Mitra/daftar_mitra_view.dart';
import 'package:e_tikbroh_yok/Models/Mitra/detail_mitra_view.dart';
import 'package:e_tikbroh_yok/Models/OrderJemputan/daftar_jemputan_view.dart';
import 'package:e_tikbroh_yok/Models/OrderJemputan/detail_jemputan.dart';
import 'package:e_tikbroh_yok/Models/OrderJemputan/order_jemputan.dart';
import 'package:e_tikbroh_yok/Models/Point/konfirmasi_penukaran_view.dart';
import 'package:e_tikbroh_yok/Models/Profile/mutasi_poin_view.dart';
import 'package:e_tikbroh_yok/Models/home.dart';
import 'package:get/get.dart';

import 'Models/Auth/ForgotPassword/gantiPasswordView.dart';
import 'Models/Auth/ForgotPassword/lupaPasswordPageView.dart';
import 'Models/Auth/loginPageView.dart';
import 'Models/Auth/registrasiPageView.dart';
import 'Models/Auth/requestOtpPageView.dart';
import 'Models/Auth/verifikasiOtpPageView.dart';
import 'Models/splashScreenView.dart';
import 'bindings.dart';

final List<GetPage<dynamic>> route = [
  GetPage(
      name: '/splas-screen',
      page: () => const SplasScreenView(),
      binding: SplashBindigs()),
  GetPage(
      name: '/request-otp',
      page: () => const RequestOtpPageView(),
      binding: RequetOTPBindigs(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: '/cek-otp',
      page: () => const VerifikasiOTPPageView(),
      binding: VerifikasiOtpBindigs(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
      arguments: false),
  GetPage(
      name: '/cek-otp-reset-pass',
      page: () => const VerifikasiOTPPageView(),
      binding: VerifikasiOtpResetPassBindigs(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
      arguments: true),
  GetPage(
      name: '/registrasi-user',
      page: () => const RegistrasiPageView(),
      binding: RegitrasiBindigs(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: '/forgot-pass',
      page: () => const LupaPasswordPageView(),
      binding: LupaPasswordBindigs(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: '/reset-pass',
      page: () => const RegistrasiPageView(),
      binding: RegitrasiBindigs(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
      arguments: true),
  GetPage(
      name: '/login',
      page: () => const LoginPageView(),
      binding: LoginBindigs(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: '/home-page',
      page: () => const HomePage(),
      binding: HomeBindigs(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: '/ganti-pass-page',
      page: () => const GantiPasswordView(),
      binding: LupaPasswordBindigs(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: '/lokasi-jemputan',
      page: () => const DaftarLokasiJemputan(),
      binding: LokasiBindigs(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: '/tambah-lokasi-baru',
      page: () => const TambahLokasiJemputan(),
      binding: LokasiBindigs(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: '/daftar-order-jemputan',
      page: () => const DaftarJemputanView(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: '/order-jemputan',
      page: () => const OrderJemputanView(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: '/detail-jemputan',
      page: () => const DetailJemputanSampah(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: '/detail-jemputan-driver',
      page: () => const DetailJemputanDriverView(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: '/mitra-view',
      page: () => const DaftarMitraView(),
      binding: MitraBindigs(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: '/detail-mitra-view',
      page: () => const DetailMitraView(),
      binding: MitraBindigs(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: '/konfirmasi-penukara-poin',
      page: () => const KonfirmasiPenukaranPoin(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: '/mutasi-poin',
      page: () => const MutasiPoinView(),
      binding: MutasiBindigs(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300)),
  GetPage(
      name: '/edukasi',
      page: () => const EdukasiView(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300)),
];
