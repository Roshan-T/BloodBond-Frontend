import 'dart:convert';
import 'dart:io';

import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/screen/profile_screen_hospital.dart';
import 'package:bloodbond/services/services.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class CreateRewardController extends GetxController {
  RxBool loading = false.obs;

  createReward(
      final name, final description, final points, final total_quantity) async {
    loading.value = true;

    try {
      var token = GetStorage().read('token');

      final response = await post(
        Uri.parse(Url.getRewards),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token ',
        },
        body: jsonEncode({
          "name": name,
          "description": description,
          "points": points,
          "total_quantity": total_quantity,
        }),
      );

      var data = jsonDecode(response.body);
      // var user = data.user;
      print(data);

      if (response.statusCode == 201) {
        loading.value = false;

        Get.closeAllSnackbars();

        Get.snackbar(
          'Reward Created Sucessfully',
          "",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
        Get.off(MyRewards());
      } else {
        loading.value = false;
        Get.closeAllSnackbars();
        Get.snackbar(
          "Reward Creation Failed",
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
