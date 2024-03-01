import 'package:bloodbond/routes/url.dart';
import 'package:bloodbond/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DonorDetailsController extends GetxController {
  RxBool isLoading = true.obs;
  Rx<Donor?> donor = Rx<Donor?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchDonor(1);
  }

  void fetchDonor(int id) async {
    try {
      isLoading(true);
      var donorDetails = await _fetchDonor(id);
      donor.value = donorDetails;
    } catch (e) {
      Get.closeAllSnackbars();

      Get.snackbar(
        'Error Occurred',
        '$e',
        colorText: Colors.white,
        backgroundColor: Constants.kPrimaryColor,
      );
    } finally {
      isLoading(false);
    }
  }

  static Future<Donor?> _fetchDonor(int id) async {
    var token = GetStorage().read('token');

    var response = await http.get(
      Uri.parse("${Url.getdonor}/$id"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      print("response : ${response.body}${response.statusCode}");
      return Donor.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      print("response : ${response.statusCode}");
      throw Exception('User doesn\'t exist');
    } else if (response.statusCode == 422) {
      print("response : ${response.statusCode}");
      Map<String, dynamic> responseData = jsonDecode(response.body);
      String errorMessage = responseData['detail'][0]['msg'];
      throw Exception(errorMessage);
    } else {
      print("response : ${response.statusCode}");
      throw Exception('Failed to load donor details');
    }
  }
}

Donor donorFromJson(String str) => Donor.fromJson(json.decode(str));

String donorToJson(Donor data) => json.encode(data.toJson());

class Donor {
  String firstName;
  String lastName;
  String phone;
  String sex;
  DateTime dateOfBirth;
  String bloodGroup;
  double latitude;
  double longitude;
  String city;
  int id;
  String email;
  DateTime createdAt;
  String image;
  DateTime lastDonationDate;
  int points;

  Donor({
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

  factory Donor.fromJson(Map<String, dynamic> json) => Donor(
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
