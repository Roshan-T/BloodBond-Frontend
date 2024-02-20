import 'dart:convert';

List<CampaignDetails> campaignDetailsFromJson(String str) =>
    List<CampaignDetails>.from(
        json.decode(str).map((x) => CampaignDetails.fromJson(x)));

String campaignDetailsToJson(List<CampaignDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CampaignDetails {
  String title;
  String description;
  String address;
  String city;
  DateTime date;
  String banner;
  int id;
  int interestedDonors;
  int donatedDonors;
  int totalBags;
  int hospitalId;
  Hospital hospital;

  CampaignDetails({
    required this.title,
    required this.description,
    required this.address,
    required this.city,
    required this.date,
    required this.banner,
    required this.id,
    required this.interestedDonors,
    required this.donatedDonors,
    required this.totalBags,
    required this.hospitalId,
    required this.hospital,
  });

  factory CampaignDetails.fromJson(Map<String, dynamic> json) =>
      CampaignDetails(
        title: json["title"],
        description: json["description"],
        address: json["address"],
        city: json["city"],
        date: DateTime.parse(json["date"]),
        banner: json["banner"],
        id: json["id"],
        interestedDonors: json["interested_donors"],
        donatedDonors: json["donated_donors"],
        totalBags: json["total_bags"],
        hospitalId: json["hospital_id"],
        hospital: Hospital.fromJson(json["hospital"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "address": address,
        "city": city,
        "date": date.toIso8601String(),
        "banner": banner,
        "id": id,
        "interested_donors": interestedDonors,
        "donated_donors": donatedDonors,
        "total_bags": totalBags,
        "hospital_id": hospitalId,
        "hospital": hospital.toJson(),
      };
}

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
