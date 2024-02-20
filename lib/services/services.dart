import 'dart:convert';
import 'dart:io';

import 'package:bloodbond/controller/home_screen_controller.dart';
import 'package:bloodbond/routes/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controller/nearby_donor.controller.dart';
import '../utils/constants.dart' as cons;

class ApiService {
  static Future<List<NearbyDonor>?> fetchDonors() async {
    var response = await http.get(
      Uri.parse(Url.nearbyDonor),
      headers: {"Content-Type": "application/json"},
    );
    var data = response.body;
    // print(data);
    // print(nearbyDonorFromJson(data));
    if (response.statusCode == 200) {
      final x = nearbyDonorFromJson(data);
      return x;
    } else {
      Get.closeAllSnackbars();
      Get.snackbar(
        jsonDecode(data)['detail'],
        "",
        colorText: Colors.white,
        backgroundColor: cons.Constants.kPrimaryColor,
      );
      return null;
    }
  }

  static Future<List<EmergencyRequest>?> fetchEmergencyRequest() async {
    var response = await http.get(
      Uri.parse(Url.getEmergencyRequest),
      headers: {"Content-Type": "application/json"},
    );
    var data = response.body;

    if (response.statusCode == 200) {
      final x = emergencyRequestFromJson(data);
      print(x);
      return x;
    } else {
      Get.closeAllSnackbars();
      Get.snackbar(
        jsonDecode(data)['detail'],
        "",
        colorText: Colors.white,
        backgroundColor: cons.Constants.kPrimaryColor,
      );
      return null;
    }
  }

  static Future<String> uploadImage(File imageFile) async {
    final Uri uploadEndpoint = Uri.parse(Url.uploadImage);

    var request = http.MultipartRequest('POST', uploadEndpoint);

    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));

    var response = await request.send();

    var responseBody = await response.stream.bytesToString();
    print(responseBody);
    if (response.statusCode == 201) {
      return responseBody;
    } else {
      Get.closeAllSnackbars();
      Get.snackbar(
        "Error Uploading Image",
        "",
        colorText: Colors.white,
        backgroundColor: cons.Constants.kPrimaryColor,
      );

      return "";
    }
  }

  static void forgetPassword() async {
    final response = await http.post(
      Uri.parse(Url.login),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        //"email": emailController.value.text,
      }),
    );
  }
}
