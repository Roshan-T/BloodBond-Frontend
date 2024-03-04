import 'dart:convert';
import 'dart:io';

import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/screen/home_screen.dart';
import 'package:bloodbond/screen/main_screen.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;

class RequestController extends GetxController {
  RxBool loading = false.obs;

  void acceptRequest(final id) async {
    loading.value = true;
    try {
      var token = GetStorage().read('token');

      final response = await http.put(
        Uri.parse("${Url.getEmergencyRequest}/$id/accept"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token ',
        },
      );
      // print(response.body);
      var data = jsonDecode(response.body);
      // var user = data.user;
      // print(response.statusCode);
      print(data);
      if (response.statusCode == 200) {
        loading.value = false;

        Get.closeAllSnackbars();
        Get.snackbar(
          'Sucessfully Accepted',
          "Congratulations",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
        Get.deleteAll();
        Get.offAll(MainScreen());
      } else {
        loading.value = false;
        Get.closeAllSnackbars();
        Get.snackbar(
          "Failed",
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

  confirmDonate(final id) async {
    loading.value = true;
    try {
      var token = GetStorage().read('token');

      final response = await http.put(
        Uri.parse("${Url.getEmergencyRequest}/$id/donate"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token ',
        },
      );
      // print(response.body);
      var data = jsonDecode(response.body);
      // var user = data.user;
      // print(response.statusCode);
      print(data);
      if (response.statusCode == 200) {
        loading.value = false;

        Get.closeAllSnackbars();
        Get.snackbar(
          'Confirmed.',
          "Congratulations",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
        Get.deleteAll();
        Get.offAll(const MainScreen());
      } else {
        loading.value = false;
        Get.closeAllSnackbars();
        Get.snackbar(
          "Failed",
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
