// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:bloodbond/controller/home_screen_controller.dart';
import 'package:bloodbond/controller/network_controller.dart';
import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/screen/home_screen.dart';
import 'package:bloodbond/screen/main_screen.dart';
import 'package:bloodbond/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

import '../utils/constants.dart';

class CreateCampaginController extends GetxController {
  RxBool loading = false.obs;

  void emergencyRequest(final title, final description, final address,
      final city, final date, final banner) async {
    loading.value = true;

    try {
      var token = GetStorage().read('token');
      print("token is : $token");
      var file = await ApiService.uploadImage(banner);
      final response = await post(
        Uri.parse(Url.postCampaings),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token ',
        },
        body: jsonEncode({
          "title": title,
          "description": description,
          "address": address,
          "city": city,
          "date": date.toString(),
          "banner": file
        }),
      );

      var data = jsonDecode(response.body);
      // var user = data.user;
      print(data);

      if (response.statusCode == 201) {
        loading.value = false;

        Get.closeAllSnackbars();

        Get.snackbar(
          'Campaign Created Sucessfully',
          "",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );

        Get.off(const MainScreen());
      } else {
        loading.value = false;
        Get.closeAllSnackbars();
        Get.snackbar(
          "Campaign Creation Failed",
          data['detail'],
          colorText: Colors.white,
          backgroundColor: Constants.kPrimaryColor,
        );
      }
    } catch (e) {
      Get.closeAllSnackbars();
      loading.value = false;
      if (e == SocketException) {
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
