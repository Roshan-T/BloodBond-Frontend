import 'dart:convert';
import 'package:bloodbond/routes/url.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class DonorController extends GetxController {
  Rx<Donor?> donor = Rx<Donor?>(null);
  RxBool loading = false.obs;

  Future<void> fetchDonor(int id) async {
    loading.value = true;
    try {
      int id = await GetStorage().read('id');
      print("Oid:{$id}");
      var response = await http.get(Uri.parse('${Url.getdonor}$id'));
      if (response.statusCode == 200) {
        loading.value = false;
        donor.value = donorFromJson(response.body);
      } else if (response.statusCode == 422) {
        print("response:${response.statusCode}");
        var errorResponse = jsonDecode(response.body);
        var errorDetails = errorResponse['detail'][0];
        throw Exception('Validation Error: ${errorDetails['msg']}');
      } else {
        print(response.body);
        print("response:{$response.body}");
        print("response:${response.statusCode}");
        print('Failed to load donor');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      loading.value = false; // End loading
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
        firstName: json["first_name"] ?? '',
        lastName: json["last_name"] ?? '',
        phone: json["phone"] ?? '',
        sex: json["sex"] ?? '',
        dateOfBirth:
            DateTime.tryParse(json["date_of_birth"] ?? '') ?? DateTime.now(),
        bloodGroup: json["blood_group"] ?? '',
        latitude: json["latitude"]?.toDouble() ?? 0.0,
        longitude: json["longitude"]?.toDouble() ?? 0.0,
        city: json["city"] ?? '',
        id: json["id"] ?? 0,
        email: json["email"] ?? '',
        createdAt:
            DateTime.tryParse(json["created_at"] ?? '') ?? DateTime.now(),
        image: json["image"] ?? '',
        lastDonationDate: DateTime.tryParse(json["last_donation_date"] ?? '') ??
            DateTime.now(),
        points: json["points"] ?? 0,
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
