import 'dart:convert';

class FacilitiesModel {
  final bool active;
  final String id;
  final String image;
  final String name;

  FacilitiesModel({
    required this.active,
    required this.id,
    required this.image,
    required this.name,
  });

  factory FacilitiesModel.fromRawJson(String str) => FacilitiesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FacilitiesModel.fromJson(Map<String, dynamic> json) => FacilitiesModel(
    active: json["active"],
    id: json["id"],
    image: json["image"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "active": active,
    "id": id,
    "image": image,
    "name": name,
  };
}
