import 'dart:convert';

import 'package:bloodbond/services/services.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isRequestLoading = false.obs;
  var requestList = <EmergencyRequest>[];
  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchEmergencyRequest();
  }

  void fetchEmergencyRequest() async {
    isRequestLoading(true);
    try {
      var list = await ApiService.fetchEmergencyRequest();
      print(list);
      if (list != null) {
        requestList = list;
      } else {
        requestList = [];
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
      update();
      isRequestLoading(false);
    }
  }
}

List<EmergencyRequest> emergencyRequestFromJson(String str) =>
    List<EmergencyRequest>.from(
        json.decode(str).map((x) => EmergencyRequest.fromJson(x)));

String emergencyRequestToJson(List<EmergencyRequest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmergencyRequest {
  String patientName;
  String bloodGroup;
  String medicalCondition;
  String report;
  DateTime requestedTime;
  DateTime expiryTime;
  int id;
  bool accepted;
  bool donated;
  dynamic donor;
  Hospital hospital;

  EmergencyRequest({
    required this.patientName,
    required this.bloodGroup,
    required this.medicalCondition,
    required this.report,
    required this.requestedTime,
    required this.expiryTime,
    required this.id,
    required this.accepted,
    required this.donated,
    required this.donor,
    required this.hospital,
  });

  factory EmergencyRequest.fromJson(Map<String, dynamic> json) =>
      EmergencyRequest(
        patientName: json["patient_name"],
        bloodGroup: json["blood_group"],
        medicalCondition: json["medical_condition"],
        report: json["report"],
        requestedTime: DateTime.parse(json["requested_time"]),
        expiryTime: DateTime.parse(json["expiry_time"]),
        id: json["id"],
        accepted: json["accepted"],
        donated: json["donated"],
        donor: json["donor"],
        hospital: Hospital.fromJson(json["hospital"]),
      );

  Map<String, dynamic> toJson() => {
        "patient_name": patientName,
        "blood_group": bloodGroup,
        "medical_condition": medicalCondition,
        "report": report,
        "requested_time": requestedTime.toIso8601String(),
        "expiry_time": expiryTime.toIso8601String(),
        "id": id,
        "accepted": accepted,
        "donated": donated,
        "donor": donor,
        "hospital": hospital.toJson(),
      };
}

class Hospital {
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

  Hospital({
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

  factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
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
