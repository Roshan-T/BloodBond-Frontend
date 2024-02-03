import 'dart:convert';
import 'dart:io';

import 'package:bloodbond/controller/network_controller.dart';
import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

import '../utils/constants.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  RxBool loading = false.obs;

  final getStorage = GetStorage();

  void loginApi() async {
    loading.value = true;
    try {
      final response = await post(
        Uri.parse(Url.login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.value.text,
          "password": passwordController.value.text
        }),
      );
      // print(response.body);
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        loading.value = false;
        getStorage.write("token", data['access_token']);
        getStorage.write('firstLogin', false);
        Get.closeAllSnackbars();
        Get.snackbar(
          'Login Sucessful',
          "Congratulations",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
        emailController.close();
        passwordController.close();
        Get.offAll(const MainScreen());
      } else {
        loading.value = false;
        Get.closeAllSnackbars();
        Get.snackbar(
          "Login Failed",
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
