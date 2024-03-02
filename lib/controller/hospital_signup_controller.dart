import 'dart:convert';

import 'package:bloodbond/controller/network_controller.dart';
import 'package:bloodbond/screen/login_screen.dart';
import 'package:bloodbond/services/services.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:bloodbond/routes/url.dart';

class HospitalSignUpController extends GetxController {
  double? lat;
  double? long;
  String? city;
  bool? is_verified;
  final hospitalnamecontroller = TextEditingController().obs;
  final phonecontroller = TextEditingController().obs;
  final emailcontroller = TextEditingController().obs;
  final passwordcontroller = TextEditingController().obs;
  final imagecontroller = TextEditingController().obs;

  RxBool loading = false.obs;

  Future<void> hospitalSignUp(image) async {
    loading.value = true;

    try {
      var file = await ApiService.uploadImage(image);
      final userdata = {
        "name": hospitalnamecontroller.value.text,
        "email": emailcontroller.value.text,
        "phone": phonecontroller.value.text,
        "password": passwordcontroller.value.text,
        "latitude": lat!.toDouble(),
        "longitude": long!.toDouble(),
        "city": city,
        "image": file,
        "is_verified": false
      };
      //  print("user data: ${userdata}");
      final response = await post(
        Uri.parse(Url.hospitalregister),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(userdata),
      );
      print("response.body: ${response.body}");
      var data = response.body;

      if (response.statusCode == 201) {
        loading.value = false;
        Get.snackbar(" Success Message :", "Hospital successfully registered!",
            backgroundColor: Colors.green, colorText: Colors.white);
        print(data);

        Get.to(const LoginScreen());
      } else {
        loading.value = false;
        Get.closeAllSnackbars();
        Get.snackbar(
          "SignUp Failed",
          data ?? "hi",
          colorText: Colors.white,
          backgroundColor: Constants.kPrimaryColor,
        );
      }
    } catch (e) {
      Get.closeAllSnackbars();
      loading.value = false;
      if (NetworkController().connectionStatus == 0.obs) {
        Get.snackbar(
          'Check Your Internet Connection ',
          "$e",
          colorText: Colors.white,
          backgroundColor: Constants.kPrimaryColor,
        );
        print('$e');
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
