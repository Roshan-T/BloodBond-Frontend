import 'package:bloodbond/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  final getStorage = GetStorage();

  void logout() {
    getStorage.remove('token');

    Get.offAll(const LoginScreen());
  }
}
