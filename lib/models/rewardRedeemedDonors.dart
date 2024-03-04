import 'dart:convert';

List<RewardRedeemedDonors> rewardRedeemedDonorsFromJson(String str) =>
    List<RewardRedeemedDonors>.from(
        json.decode(str).map((x) => RewardRedeemedDonors.fromJson(x)));

String rewardRedeemedDonorsToJson(List<RewardRedeemedDonors> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RewardRedeemedDonors {
  String rewardName;
  String rewardDescription;
  int rewardId;
  int redeemId;
  Donor donor;
  DateTime redeemedAt;

  RewardRedeemedDonors({
    required this.rewardName,
    required this.rewardDescription,
    required this.rewardId,
    required this.redeemId,
    required this.donor,
    required this.redeemedAt,
  });

  factory RewardRedeemedDonors.fromJson(Map<String, dynamic> json) =>
      RewardRedeemedDonors(
        rewardName: json["reward_name"],
        rewardDescription: json["reward_description"],
        rewardId: json["reward_id"],
        redeemId: json["redeem_id"],
        donor: Donor.fromJson(json["donor"]),
        redeemedAt: DateTime.parse(json["redeemed_at"]),
      );

  Map<String, dynamic> toJson() => {
        "reward_name": rewardName,
        "reward_description": rewardDescription,
        "reward_id": rewardId,
        "redeem_id": redeemId,
        "donor": donor.toJson(),
        "redeemed_at": redeemedAt.toIso8601String(),
      };
}

class Donor {
  String name;
  String email;
  String image;

  Donor({
    required this.name,
    required this.email,
    required this.image,
  });

  factory Donor.fromJson(Map<String, dynamic> json) => Donor(
        name: json["name"],
        email: json["email"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "image": image,
      };
}
