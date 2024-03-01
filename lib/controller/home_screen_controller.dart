import 'dart:convert';
import 'dart:io';

import 'package:bloodbond/models/campaignModel.dart';
import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/screen/hospital_ind_reqandcamp.dart';
import 'package:bloodbond/screen/main_screen.dart';
import 'package:bloodbond/services/services.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class HomeController extends GetxController {
  RxBool isRequestLoading = false.obs;
  var requestList = <EmergencyRequest>[].obs;
  RxBool isCampaignLoading = false.obs;
  var campaignList = <CampaignDetails>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCampaigns();
    fetchEmergencyRequest();
  }

  removeRequest(final id) async {
    try {
      var token = GetStorage().read('token');

      final response = await delete(
        Uri.parse("${Url.getEmergencyRequest}/$id"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token ',
        },
      );
      // print(response.body);
      var data = jsonDecode(response.body);
      // var user = data.user;
      // print(response.statusCode);
      print(data);
      if (response.statusCode == 204) {
        Get.closeAllSnackbars();
        Get.snackbar(
          'Sucessfully Deleted',
          "",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );

        // Get.offAll(MainScreen());
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

  removeCampaign(final id) async {
    try {
      var token = GetStorage().read('token');

      final response = await delete(
        Uri.parse("${Url.getCampaings}/$id"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token ',
        },
      );
      // print(response.body);
      var data = jsonDecode(response.body);
      // var user = data.user;
      // print(response.statusCode);

      if (response.statusCode == 204) {
        Get.closeAllSnackbars();
        Get.snackbar(
          'Sucessfully Deleted',
          "",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
        Get.to(HospitalIndRequest());

        // Get.offAll(MainScreen());
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

  Future<void> fetchEmergencyRequest({bool a = false}) async {
    isRequestLoading(true);
    try {
      var list = await ApiService.fetchEmergencyRequest(All: a);
      print(list);
      if (list != null) {
        requestList.value = list;
      } else {
        requestList = [] as RxList<EmergencyRequest>;
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

  fetchCampaigns({bool a = false}) async {
    isCampaignLoading(true);
    try {
      var clist = await ApiService.fetchCampaigns(All: a);

      if (clist != null) {
        campaignList.value = clist;
      } else {
        campaignList = [] as RxList<CampaignDetails>;
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

      isCampaignLoading(false);
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
