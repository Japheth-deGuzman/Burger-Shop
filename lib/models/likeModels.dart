import 'dart:convert';

List<Food> foodFromJson(String str) =>
    List<Food>.from(json.decode(str).map((x) => Food.fromJson(x)));

String foodToJson(List<Food> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Food {
  Food({
    required this.id,
    required this.like,
  });

  final String id;
  final String like;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["id"],
        like: json["like"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "like": like,
      };
}
