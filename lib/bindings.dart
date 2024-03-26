import 'package:e_tikbroh_yok/Controllers/MemberController/lokasi_controller.dart';
import 'package:e_tikbroh_yok/Controllers/MemberController/riwayat_jemputan_controller.dart';
import 'package:e_tikbroh_yok/Controllers/home_controller.dart';
import 'package:e_tikbroh_yok/Controllers/mitra_controller.dart';
import 'package:e_tikbroh_yok/Controllers/mutasi_poin_controller.dart';
import 'package:e_tikbroh_yok/Controllers/point_controller.dart';
import 'package:e_tikbroh_yok/Controllers/profile_controller.dart';
import 'package:get/get.dart';

import 'Controllers/Auth/loginController.dart';
import 'Controllers/Auth/lupaPassController.dart';
import 'Controllers/Auth/registerController.dart';
import 'Controllers/Auth/requestOtpController.dart';
import 'Controllers/Auth/verifikasiOtpController.dart';
import 'Controllers/splash_screen_controller.dart';

class SplashBindigs extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplasScreenController());
  }
}

class LoginBindigs extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

class RequetOTPBindigs extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RequestOtpController());
  }
}

class VerifikasiOtpBindigs extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifikasiOtpController());
    Get.lazyPut(() => LupaPasswordController());
  }
}

class VerifikasiOtpResetPassBindigs extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RequestOtpController());
    Get.lazyPut(() => VerifikasiOtpController());
  }
}

class RegitrasiBindigs extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegitrasiController());
  }
}

class LupaPasswordBindigs extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LupaPasswordController());
  }
}

class HomeBindigs extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ProfileController());
  }
}

class LokasiBindigs extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LokasiController());
    Get.lazyPut(() => OrderJemputanController());
  }
}

class MitraBindigs extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MitraController());
    Get.lazyPut(() => PointController());
  }
}

class MutasiBindigs extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MutasiPointController());
  }
}
