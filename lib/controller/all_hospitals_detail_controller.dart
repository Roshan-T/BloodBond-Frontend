import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/services.dart';
import '../utils/constants.dart';

class AllHospitalsController extends GetxController {
  RxBool isLoading = true.obs;
  var allHospitalList = <AllHospital>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchallHospitals();
  }

  void fetchallHospitals() async {
    try {
      isLoading(true);
      var allhospitals = await ApiService.fetchAllHospitals();
      if (allhospitals != null) {
        allHospitalList.value = allhospitals;
      }
    } catch (e) {
      Get.closeAllSnackbars();

      Get.snackbar(
        'Error Occured',
        "$e",
        colorText: Colors.white,
        backgroundColor: Constants.kPrimaryColor,
      );
    } finally {
      isLoading(false);
    }
  }
}

//List<AllHospital> allHospitalFromJson(String str) => List<AllHospital>.from(json.decode(str).map((x) => AllHospital.fromJson(x)));

List<AllHospital> allHospitalFromJson(String str) {
  try {
    return List<AllHospital>.from(
        json.decode(str).map((x) => AllHospital.fromJson(x)));
  } catch (e) {
    print("Error parsing JSON: $e");
    return [];
  }
}

String allHospitalToJson(List<AllHospital> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllHospital {
  String name;
  String email;
  String phone;
  double latitude;
  double longitude;
  String image;
  bool isVerified;
  String city;
  int id;
  DateTime createdAt;

  AllHospital({
    required this.name,
    required this.email,
    required this.phone,
    required this.latitude,
    required this.longitude,
    required this.image,
    required this.isVerified,
    required this.city,
    required this.id,
    required this.createdAt,
  });

  factory AllHospital.fromJson(Map<String, dynamic> json) => AllHospital(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        image: json["image"],
        isVerified: json["is_verified"],
        city: json["city"],
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "latitude": latitude,
        "longitude": longitude,
        "image": image,
        "is_verified": isVerified,
        "city": city,
        "id": id,
        "created_at": createdAt.toIso8601String(),
      };
}
