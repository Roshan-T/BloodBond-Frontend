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
    } catch (e) {
      Get.closeAllSnackbars();

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
    json.decode(str).map((x) => NearbyDonor.fromJson(x)));   // converts from json into list of nearbydonors
    
String nearbyDonorToJson(List<NearbyDonor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NearbyDonor {
  String firstName;
  String lastName;
  String phone;
  String sex;
  DateTime dateOfBirth;
  String bloodGroup;
  int latitude;
  int longitude;
  String city;
  int id;
  String email;
  DateTime createdAt;
  String image;
  DateTime lastDonationDate;
  int points;

  NearbyDonor({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.sex,
    required this.dateOfBirth,
    required this.bloodGroup,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.id,
    required this.email,
    required this.createdAt,
    required this.image,
    required this.lastDonationDate,
    required this.points,
  });

  factory NearbyDonor.fromJson(Map<String, dynamic> json) => NearbyDonor(
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        sex: json["sex"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        bloodGroup: json["blood_group"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        city: json["city"],
        id: json["id"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
        image: json["image"],
        lastDonationDate: DateTime.parse(json["last_donation_date"]),
        points: json["points"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "sex": sex,
        "date_of_birth": dateOfBirth.toIso8601String(),
        "blood_group": bloodGroup,
        "latitude": latitude,
        "longitude": longitude,
        "city": city,
        "id": id,
        "email": email,
        "created_at": createdAt.toIso8601String(),
        "image": image,
        "last_donation_date": lastDonationDate.toIso8601String(),
        "points": points,
      };
}
