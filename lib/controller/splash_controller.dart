import 'package:bloodbond/screen/login_screen.dart';
import 'package:bloodbond/screen/main_screen.dart';
import 'package:bloodbond/screen/onboarding_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final getStorage = GetStorage();
  @override
  void onInit() {
    super.onInit();
  }

  void onReady() {
    super.onReady();
    if (getStorage.read('token') != null) {
      Get.offAll(
        const MainScreen(),
      );
    } else if (getStorage.read('firstLogin') != false) {
      Get.offAll(const OnboardingScreen());
    } else {
      Get.offAll(const LoginScreen());
    }
  }
}
