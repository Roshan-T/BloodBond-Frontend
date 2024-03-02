import 'dart:convert';
import 'dart:io';

import 'package:bloodbond/models/campaignDonorsModel.dart';
import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/screen/login_screen.dart';
import 'package:bloodbond/screen/main_screen.dart';
import 'package:bloodbond/services/services.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class CampaignController extends GetxController {
  @override
  register(final id) async {
    try {
      var token = GetStorage().read('token');

      final response = await post(
        Uri.parse("${Url.getCampaings}/$id/register"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token ',
        },
      );
      print(response.statusCode);
      var data = jsonDecode(response.body);
      // var user = data.user;
      // print(response.statusCode);
      print(data);
      if (response.statusCode == 201) {
        Get.closeAllSnackbars();
        Get.snackbar(
          'Sucessfully Registered',
          "",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );

        Get.offAll(const MainScreen());
      } else {
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

      if (e == SocketException) {
        Get.snackbar(
          'Check Your Internet Connection',
          "",
          colorText: Colors.white,
          backgroundColor: Constants.kPrimaryColor,
        );
      }
    }
  }

  donated(final campaignid, final donorId) async {
    try {
      var token = GetStorage().read('token');

      final response =
          await put(Uri.parse("${Url.getCampaings}/$campaignid/donate"),
              headers: {
                "Content-Type": "application/json",
                'Authorization': 'Bearer $token ',
              },
              body: jsonEncode({"donor_id": donorId}));

      var data = jsonDecode(response.body);
      // var user = data.user;
      // print(response.statusCode);
      print(data);
      if (response.statusCode == 200) {
        Get.closeAllSnackbars();
        Get.snackbar(
          'Sucessfully Donated',
          "",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );

        Get.deleteAll();
      } else {
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

      if (e == SocketException) {
        Get.snackbar(
          'Check Your Internet Connection',
          "",
          colorText: Colors.white,
          backgroundColor: Constants.kPrimaryColor,
        );
      }
    }
  }
}
