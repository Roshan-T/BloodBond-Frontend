import 'dart:convert';

CampaignDonorsDetails campaignDonorsDetailsFromJson(String str) =>
    CampaignDonorsDetails.fromJson(json.decode(str));

String campaignDonorsDetailsToJson(CampaignDonorsDetails data) =>
    json.encode(data.toJson());

class CampaignDonorsDetails {
  List<Donor> donors;
  int registeredCount;
  int donatedCount;

  static var obs;

  CampaignDonorsDetails({
    required this.donors,
    required this.registeredCount,
    required this.donatedCount,
  });

  factory CampaignDonorsDetails.fromJson(Map<String, dynamic> json) =>
      CampaignDonorsDetails(
        donors: List<Donor>.from(json["donors"].map((x) => Donor.fromJson(x))),
        registeredCount: json["registered_count"],
        donatedCount: json["donated_count"],
      );

  Map<String, dynamic> toJson() => {
        "donors": List<dynamic>.from(donors.map((x) => x.toJson())),
        "registered_count": registeredCount,
        "donated_count": donatedCount,
      };
}

class Donor {
  int id;
  String name;
  String image;
  bool donated;

  Donor({
    required this.id,
    required this.name,
    required this.image,
    required this.donated,
  });

  factory Donor.fromJson(Map<String, dynamic> json) => Donor(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        donated: json["donated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "donated": donated,
      };
}
