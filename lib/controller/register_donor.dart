import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:bloodbond/routes/url.dart';

class RegisterDonor extends GetxController {
  final firstnamecontroller = TextEditingController().obs;
  final lastnamecontroller = TextEditingController().obs;
  final phonecontroller = TextEditingController().obs;
  final sexcontroller = TextEditingController().obs;
  final dateofbirthcontroller = TextEditingController().obs;
  final bloodgroupcontroller = TextEditingController().obs;
  final latitudecontroller = TextEditingController().obs;
  final longitudecontroller = TextEditingController().obs;
  final emailcontroller = TextEditingController().obs;
  final passwordcontroller = TextEditingController().obs;
  final imagecontroller = TextEditingController().obs;

  RxBool loading = false.obs;

  final getStorage = GetStorage();

  Future<void> registerDonor() async {
    loading.value = true;
    try {
      final response = await post(
        Uri.parse(Url.registerdonor),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "first_name": firstnamecontroller.value.text,
          "last_name": lastnamecontroller.value.text,
          "phone": phonecontroller.value.text,
          "sex": sexcontroller.value.text,
          "date_of_birth": dateofbirthcontroller.value.text,
          "blood_group": bloodgroupcontroller.value.text,
          "latitude": latitudecontroller.value.text,
          "longitude": longitudecontroller.value.text,
          "email": emailcontroller.value.text,
          "password": passwordcontroller.value.text,
          "image": imagecontroller.value.text,
        }),
      );
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        loading.value = false;
        

      }
    } catch (e) {}
  }
}
