import 'package:bloodbond/services/services.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProfileController extends GetxController {
  RxBool isLoading = true.obs;
  RxString profile = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  void fetchUserProfile() async {
    try {
      isLoading(true);
      var userProfile = await ApiService.fetchUserProfile();
      if (userProfile != null) {
        profile.value = userProfile;
      }
    } catch (e) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Error Occurred',
        '$e',
        colorText: Colors.white,
        backgroundColor: Constants.kPrimaryColor,
      );
    } finally {
      isLoading(false);
    }
  }
}
