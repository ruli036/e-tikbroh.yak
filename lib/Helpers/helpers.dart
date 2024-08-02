import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../Server/api_server.dart';
import 'constans.dart';
import 'widgets.dart';

class Helpers {
  var formater = NumberFormat('###,###');
  var formatDate = DateFormat('yyyy-MM-dd');
}

formatDate(dateValue, format) {
  final DateTime now = dateValue;
  final DateFormat formatter = DateFormat(format, 'id_ID');
  final String formatted = formatter.format(dateValue);
  return formatted;
}

emailValidate(value) {
  final bool isValid = !EmailValidator.validate(value);
  return isValid;
}

bool isInitialized = false;
TextEditingController keteraganBataljemput = TextEditingController();
final keyForm = GlobalKey<FormState>();

class AppColors {
  static const buttonColor = Color.fromARGB(255, 171, 194, 112);
  static const cancelButtonColor = Color.fromARGB(255, 249, 94, 92);
  static const deleteButtonColor = Color.fromARGB(255, 222, 25, 23);
  static const warningButtonColor = Color.fromARGB(255, 234, 210, 28);
  static const warningIconColor = Color.fromARGB(255, 95, 234, 20);
  static const bagroudColorHomeButton = Color.fromARGB(255, 238, 238, 246);
  static const textColor = Color.fromARGB(255, 243, 240, 240);
  static const whiteButton = Color.fromARGB(255, 243, 240, 240);
  static const fontColor = Color.fromARGB(255, 156, 155, 155);

  static const fontTitleColor = Color.fromARGB(255, 8, 68, 26);
  static const blackColor = Color.fromARGB(255, 22, 23, 22);
  static const fontTitleColor1 = Color.fromARGB(255, 80, 121, 86);
  static const warnaTitik = Color.fromARGB(255, 236, 214, 136);
  static const warnaKategoriSampah = Color.fromARGB(255, 165, 228, 175);
  static const iconColor1 = Color.fromARGB(255, 163, 177, 138);
  static const iconColorButton = Color.fromARGB(255, 14, 14, 14);
  static const disableButtonColor = Color.fromARGB(255, 206, 206, 204);
  static const filledColor = Color.fromARGB(255, 206, 206, 204);
  static const hinttext = Color.fromARGB(255, 8, 68, 26);
  static const bagroudHome = Color.fromARGB(255, 233, 236, 233);
  static const bagroudPoket = Color.fromARGB(255, 160, 216, 179);
  static const bagroudApp = Color.fromARGB(255, 160, 216, 179);
  // static const themeColor = Color.fromARGB(255, 8, 68, 26);
  // static const colorMenu = Color.fromARGB(255, 160, 216, 179).withOpacity(0.5);
  // static const themeColor = Color.fromARGB(255, 160, 216, 179);
  // static const colorMenu = Color.fromARGB(255, 229, 249, 219);
  static const themeColor = Color.fromARGB(255, 87, 133, 94);
  static const colorMenu = Color.fromARGB(255, 229, 249, 219);
  static const colorMenu2 = Color.fromARGB(255, 248, 250, 249);
  static const gradientcolor1 = Color.fromARGB(255, 247, 230, 82);
  static const gradientcolor2 = Color.fromARGB(255, 248, 248, 246);
  static const gradientcolor3 = Color.fromARGB(255, 247, 230, 82);
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

String extractVideoIdFromUrl(String url) {
  RegExp regExp = RegExp(
    r"(?:(?:youtu\.be\/|youtube\.com(?:\/embed\/|\/v\/|\/watch\?v=|\/watch\?.+&v=))([a-zA-Z0-9\-_]+))",
    caseSensitive: false,
    multiLine: false,
  );
  RegExpMatch? match = regExp.firstMatch(url);
  return (match?.group(1) ?? '');
}

bool keyboardIsVisible(context) {
  return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
}

size(context) {
  return MediaQuery.of(context).size;
}

Future<void> luncurkanbrowserdihp(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}

class StorageAPP {
  static storageLogin(String email, bool statusLogin, String token, String nama,
      String nohp, foto, level) {
    GetStorage().write(STORAGE_EMAIL, email);
    GetStorage().write(STORAGE_TOKEN, token);
    GetStorage().write(STORAGE_NAMA, nama);
    GetStorage().write(STORAGE_FOTO, foto);
    GetStorage().write(STORAGE_NO_HP, nohp);
    GetStorage().write(STORAGE_STATUS_USER, level);
    GetStorage().write(STORAGE_STATUS_LOGIN, statusLogin);
    // GetStorage().write(STORAGE_DATA_LOKASI, lokasi);
  }

  static updateDataLokasi(lokasi) {
    GetStorage().write(STORAGE_DATA_LOKASI, lokasi);
  }

  static updateDataUserLogin(nama, noHp) {
    GetStorage().write(STORAGE_NAMA, nama);
    GetStorage().write(STORAGE_NO_HP, noHp);
  }

  static updateFotoProfile(foto) {
    GetStorage().write(STORAGE_FOTO, foto);
  }
}

Future requestOTP(email) async {
  try {
    final respone =
        await http.post(Uri.parse(ApiUrl.requestOpt), body: {'email': email});
    print(respone.statusCode);
    final hasil = json.decode(respone.body);
    if (respone.statusCode == 200) {
      if (hasil['status'] == true) {
        Get.back();
        Get.toNamed("/cek-otp", arguments: false);
      } else {
        Get.back();
        Get.defaultDialog(
            title: "WARNING",
            barrierDismissible: true,
            content: AlertErrorView(
              text: hasil['message'],
              colors: Colors.yellow,
            ));
      }
    } else {
      Get.back();
      Get.defaultDialog(
          title: "ERROR",
          barrierDismissible: true,
          content: AlertErrorCodeView(
            text: "${hasil['message']} ${respone.statusCode}",
          ));
    }
  } catch (e) {
    Get.back();
    Get.defaultDialog(
        title: "ERROR",
        barrierDismissible: true,
        content: AlertErrorCodeView(
          text: "Server Sedang Dalam Perbaikan, Coba Lagi Nanti! ${e}",
        ));
  }
}

Future requestOTPResetPassword(email) async {
  try {
    final respone = await http
        .post(Uri.parse(ApiUrl.requestOptResetPass), body: {'email': email});
    print('-----------------------------');
    print(respone.statusCode);
    final hasil = json.decode(respone.body);
    if (respone.statusCode == 200) {
      if (hasil['status'] == true) {
        Get.back();
        Get.toNamed("/cek-otp-reset-pass", arguments: true);
      } else {
        Get.back();
        Get.defaultDialog(
            title: "WARNING",
            barrierDismissible: true,
            content: AlertErrorView(
              text: hasil['message'],
              colors: Colors.yellow,
            ));
      }
    } else {
      Get.back();
      Get.defaultDialog(
          title: "ERROR",
          barrierDismissible: true,
          content: AlertErrorCodeView(
            text: "${hasil['message']} ${respone.statusCode}",
          ));
    }
  } catch (e) {
    Get.back();
    Get.defaultDialog(
        title: "ERROR",
        barrierDismissible: true,
        content: AlertErrorCodeView(
          text: "Server Sedang Dalam Perbaikan, Coba Lagi Nanti! ${e}",
        ));
  }
}

Future cekKoneksi(Function action) async {
  try {
    final result = await InternetAddress.lookup('example.com');
    print('result------------------');
    print(result);
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      try {
        action();
        print('--------------------INTERNET ------------------');
        print('OK');
      } on SocketException catch (_) {
        Get.back();
        Get.defaultDialog(
            title: "WARNING",
            barrierDismissible: true,
            content: AlertErrorView(
              text: "Kesalan Pemanggilan Data, Mohon Hubungi Admin!",
              colors: Colors.yellow,
            ));
      }
    }
  } on SocketException catch (_) {
    Get.back();
    Get.defaultDialog(
        title: "INFO",
        barrierDismissible: true,
        content: AlertErrorView(
          text: 'Tidak Ada Koneksi Internet',
          colors: Colors.yellow,
        ));
  }
}

Future LogOut() async {
  Get.defaultDialog(
      title: "Log Out",
      barrierDismissible: true,
      content: KonfirmasiLogOut(text: "Keluar Dari Akun Anda?"),
      textConfirm: "Keluar",
      textCancel: "Cancel",
      confirmTextColor: AppColors.textColor,
      // buttonColor:AppColors.cancelButtonColor ,
      onConfirm: () {
        GetStorage().erase();
        Get.offAllNamed("/login");
      });
}

Future<File?> getImagefromCamera(rasio) async {
  final ImagePicker picker = ImagePicker();
  final XFile? result = await picker.pickImage(source: ImageSource.camera);
  if (result != null) {
    var fileImage = result.path;
    File imageFile = File(fileImage);
    CroppedFile? cropeImage = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        compressQuality: 60,
        aspectRatioPresets: rasio);
    if (cropeImage == null) {
      return null;
    } else {
      print("--------------------IMAGE RESULT-------------------");
      fileImage = cropeImage.path;
      var image = await compressImage(File(fileImage), 60);
      return File(image!.path);
    }
  } else {
    print("No file selected");
  }
}

Future<File?> getImagefromgalery(rasio) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
  );
  if (result != null) {
    var fileImage = result.files.single.path;
    File imageFile = File(fileImage!);
    CroppedFile? cropeImage = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        compressQuality: 60,
        aspectRatioPresets: rasio);
    if (cropeImage == null) {
      return null;
    } else {
      print("--------------------IMAGE RESULT-------------------");
      fileImage = cropeImage.path;
      var image = await compressImage(File(fileImage), 60);
      return File(image!.path);
    }
  } else {
    print("No file selected");
  }
}

Future<XFile?> compressImage(File file, int quality) async {
  final tempDir = await getTemporaryDirectory();
  final targetPath =
      '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,
    quality: quality,
  );

  return result;
}

Future<void> openMap(koordinat) async {
  String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$koordinat';
  if (await canLaunch(googleUrl)) {
    await launch(googleUrl);
  } else {
    throw 'Could not open the map.';
  }
}

Future<void> buatPanggilan(String phone) async {
  // final link = 'https://wa.me/$url';
  final String link = 'tel:$phone';
  if (await launchUrlString(link)) {
    await launchUrlString(link);
  } else {
    throw 'Could not launch $link';
  }
}

void bukaWA(String phone) async {
  final link = "whatsapp://send?phone=$phone&text=Hello Admin :)";
  if (await launchUrlString(link)) {
    await launchUrlString(link);
  } else {
    throw 'Could not launch $link';
  }
}

Future<void> bukaWeb(link) async {
  await launchUrlString(link);
}

Future<void> openEmail(email) async {
  String emailUrl = 'mailto:${email}?subject=Subject&body=Body%20Text';
  await launchUrlString(emailUrl);
}

Future<void> reguestPermissionNotification() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    return Future.error('Location services are disabled');
  }

  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      Get.back();
      return Future.error("Location permission denied");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    Get.back();
    return Future.error('Location permissions are permanently denied');
  }

  Position position = await Geolocator.getCurrentPosition();

  return position;
}

TextEditingController koordinat = TextEditingController();
GoogleMapController? googleMapController;
CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(5.551694360956613, 95.31766511499882), zoom: 16);

RxInt cek = 0.obs;
List<Marker> myMarker = [];
RxInt changeImg = 0.obs;
onMapTap(LatLng poinTap) {
  print(poinTap.toString());
  myMarker = [];
  myMarker.add(Marker(
    markerId: MarkerId(poinTap.toString()),
    position: poinTap,
  ));
  koordinat.text = "${poinTap.latitude},${poinTap.longitude}";
  print("-----------------TITIK KOORDINAT---------------------");
  print(koordinat.text);
  cek += 1;
}

Future myLocation() async {
  Position position = await determinePosition();
  googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 16)));
  myMarker.clear();
  myMarker.add(Marker(
      markerId: const MarkerId('currentLocation'),
      position: LatLng(position.latitude, position.longitude)));
  koordinat.text = "${position.latitude},${position.longitude}";
  print(koordinat.text);
  if (myMarker.isNotEmpty) {
    cek += 1;
    print(cek);
    print(myMarker);
    Get.back();
  }
}

final validasi20karakter = RegExp(r'^.{1,20}$');
