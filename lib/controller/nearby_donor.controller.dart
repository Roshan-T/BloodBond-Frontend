import 'dart:convert';

import 'package:bloodbond/controller/network_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/services.dart';
import '../utils/constants.dart';

class NearbyDonorController extends GetxController {
  RxBool isLoading = true.obs;
  var donorList = <NearbyDonor>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDonors();
  }

  void fetchDonors() async {
    try {
      isLoading(true);
      var donors = await ApiService.fetchDonors();
      if (donors != null) {
        donorList.value = donors;
      }
    } 
    catch (e) {
      Get.closeAllSnackbars();

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
    } finally {
      isLoading(false);
    }
  }
}

List<NearbyDonor> nearbyDonorFromJson(String str) => List<NearbyDonor>.from(
    json.decode(str).map((x) => NearbyDonor.fromJson(x)));

String nearbyDonorToJson(List<NearbyDonor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NearbyDonor {
  String firstName;
  String lastName;
  String bloodGroup;
  double latitude;
  double longitude;
  String image;

  NearbyDonor({
    required this.firstName,
    required this.lastName,
    required this.bloodGroup,
    required this.latitude,
    required this.longitude,
    required this.image,
  });

  factory NearbyDonor.fromJson(Map<String, dynamic> json) => NearbyDonor(
        firstName: json["first_name"],
        lastName: json["last_name"],
        bloodGroup: json["blood_group"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "blood_group": bloodGroup,
        "latitude": latitude,
        "longitude": longitude,
        "image": image,
      };
}
