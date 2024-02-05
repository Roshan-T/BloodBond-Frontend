import 'dart:convert';

import 'package:bloodbond/controller/network_controller.dart';
import 'package:bloodbond/screen/login_screen.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:bloodbond/routes/url.dart';

class SignUpController extends GetxController {
  String selectedBloodType = "";
  String selectedBloodRh = "";
  String gender = "";
  double? lat;
  double? long;
  String? city;

  final firstnamecontroller = TextEditingController().obs;
  final lastnamecontroller = TextEditingController().obs;
  final phonecontroller = TextEditingController().obs;
  final sexcontroller = TextEditingController().obs;
  final dateofbirthcontroller = TextEditingController().obs;
  final bloodgroupcontroller = TextEditingController().obs;
  final emailcontroller = TextEditingController().obs;
  final passwordcontroller = TextEditingController().obs;
  final imagecontroller = TextEditingController().obs;

  RxBool loading = false.obs;



  Future<void> registerDonor() async {
    loading.value = true;
    try {
      final userdata = {
        "first_name": firstnamecontroller.value.text,
        "last_name": lastnamecontroller.value.text,
        "phone": phonecontroller.value.text,
        "sex": gender,
        "date_of_birth": dateofbirthcontroller.value.text,
        "blood_group": selectedBloodType + selectedBloodRh,
        "latitude": lat.toString(),
        "longitude": long.toString(),
        "city": city,
        "email": emailcontroller.value.text,
        "password": passwordcontroller.value.text,
        "image": imagecontroller.value.text,
      };
      //  print("user data: ${userdata}");
      final response = await post(
        Uri.parse(Url.register),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(userdata),
      );
      print("response.body: ${response.body}");
      var data = response.body;

      if (response.statusCode == 201) {
        loading.value = false;
        Get.snackbar(" Success Message :", "User successfully registered!",
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
