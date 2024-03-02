import 'dart:convert';

List<RedeemedRewards> redeemedRewardsFromJson(String str) =>
    List<RedeemedRewards>.from(
        json.decode(str).map((x) => RedeemedRewards.fromJson(x)));

String redeemedRewardsToJson(List<RedeemedRewards> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RedeemedRewards {
  int rewardId;
  int donorId;
  int id;
  DateTime redeemedAt;
  Reward reward;

  RedeemedRewards({
    required this.rewardId,
    required this.donorId,
    required this.id,
    required this.redeemedAt,
    required this.reward,
  });

  factory RedeemedRewards.fromJson(Map<String, dynamic> json) =>
      RedeemedRewards(
        rewardId: json["reward_id"],
        donorId: json["donor_id"],
        id: json["id"],
        redeemedAt: DateTime.parse(json["redeemed_at"]),
        reward: Reward.fromJson(json["reward"]),
      );

  Map<String, dynamic> toJson() => {
        "reward_id": rewardId,
        "donor_id": donorId,
        "id": id,
        "redeemed_at": redeemedAt.toIso8601String(),
        "reward": reward.toJson(),
      };
}

class Reward {
  String name;
  String description;
  int points;
  int totalQuantity;
  int id;
  int ownerId;
  int redeemedQuantity;

  Reward({
    required this.name,
    required this.description,
    required this.points,
    required this.totalQuantity,
    required this.id,
    required this.ownerId,
    required this.redeemedQuantity,
  });

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        name: json["name"],
        description: json["description"],
        points: json["points"],
        totalQuantity: json["total_quantity"],
        id: json["id"],
        ownerId: json["owner_id"],
        redeemedQuantity: json["redeemed_quantity"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "points": points,
        "total_quantity": totalQuantity,
        "id": id,
        "owner_id": ownerId,
        "redeemed_quantity": redeemedQuantity,
      };
}
