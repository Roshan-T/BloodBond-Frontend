import 'dart:convert';

import 'package:bloodbond/controller/network_controller.dart';
import 'package:bloodbond/screen/login_screen.dart';
import 'package:bloodbond/screen/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../routes/url.dart';
import '../utils/constants.dart';

class ForgetPasswordController extends GetxController {
  final emailController = TextEditingController().obs;

  RxBool loading = false.obs;

  void forgetPassword() async {
    loading.value = true;
    try {
      final response = await post(
        Uri.parse(Url.forgetPassword),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.value.text,
        }),
      );
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        loading.value = false;

        Get.closeAllSnackbars();
        Get.snackbar(
          'Enter the OTP send in email',
          "",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
        emailController.close();

        Get.to(const VerificationScreen());
      } else {
        loading.value = false;
        Get.closeAllSnackbars();
        Get.snackbar(
          "Error Occured! ",
          data['detail'],
          colorText: Colors.white,
          backgroundColor: Constants.kPrimaryColor,
        );
      }
    } catch (e) {
      Get.closeAllSnackbars();
      loading.value = false;
      if (NetworkController().connectionStatus == 0.obs) {
        Get.snackbar(
          'Check Your Internet Connection',
          "",
          colorText: Colors.white,
          backgroundColor: Constants.kPrimaryColor,
        );
      }

      Get.snackbar(
        'Error Occured',
        "",
        colorText: Colors.white,
        backgroundColor: Constants.kPrimaryColor,
      );
    }
  }
}
