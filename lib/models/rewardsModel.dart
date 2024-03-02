import 'dart:convert';

List<Rewards> rewardsFromJson(String str) =>
    List<Rewards>.from(json.decode(str).map((x) => Rewards.fromJson(x)));

String rewardsToJson(List<Rewards> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rewards {
  String name;
  String description;
  int points;
  int totalQuantity;
  int id;
  int ownerId;
  int redeemedQuantity;

  Rewards({
    required this.name,
    required this.description,
    required this.points,
    required this.totalQuantity,
    required this.id,
    required this.ownerId,
    required this.redeemedQuantity,
  });

  factory Rewards.fromJson(Map<String, dynamic> json) => Rewards(
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
