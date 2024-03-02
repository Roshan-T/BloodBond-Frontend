import 'dart:convert';
import 'package:bloodbond/routes/url.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HospitalController extends GetxController {
  Rx<Hospital?> hospital = Rx<Hospital?>(null);
  RxBool loading = false.obs;

  Future<void> fetchDonor(int id) async {
    loading.value = true;
    try {
      int id = await GetStorage().read('id');
      print("Oid:{$id}");
      var response = await http.get(Uri.parse('${Url.gethospitaldetail}$id'));
      if (response.statusCode == 200) {
        loading.value = false;
        hospital.value = hospitalFromJson(response.body);
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

Hospital hospitalFromJson(String str) => Hospital.fromJson(json.decode(str));

String hospitalToJson(Hospital data) => json.encode(data.toJson());

class Hospital {
  String name;
  String email;
  String phone;
  int latitude;
  int longitude;
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
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        phone: json["phone"] ?? "",
        latitude: json["latitude"] ?? 0.0,
        longitude: json["longitude"] ?? 0.0,
        image: json["image"] ?? "",
        isVerified: json["is_verified"] ?? false,
        city: json["city"] ?? "",
        id: json["id"] ?? 0,
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : DateTime.now(),
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
