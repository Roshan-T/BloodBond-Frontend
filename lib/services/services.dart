import 'dart:convert';

import 'package:bloodbond/controller/all_hospitals_detail_controller.dart';
import 'package:bloodbond/routes/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../controller/nearby_donor.controller.dart';
import '../utils/constants.dart' as cons;

class ApiService {
  //For nearby donors
  static Future<List<NearbyDonor>?> fetchDonors() async {
    var response = await get(
      Uri.parse(Url.nearbyDonor),
      headers: {"Content-Type": "application/json"},
    );
    var data = response.body;
    if (response.statusCode == 200) {
      return nearbyDonorFromJson(data);
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

//for all hospitals detail

  static Future<List<AllHospital>?> fetchAllHospitals() async {
    var response = await get(
      Uri.parse(Url.allhospital),
      headers: {"Content-Type": "application/json"},
    );
    var data = response.body;
    if (response.statusCode == 200) {
      return allHospitalFromJson(data);
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

//

  static void forgetPassword() async {
    final response = await post(
      Uri.parse(Url.login),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        //"email": emailController.value.text,
      }),
    );
  }
}
