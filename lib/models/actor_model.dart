
import 'package:meta/meta.dart';
import 'dart:convert';

Actor actorFromJson(String str) => Actor.fromJson(json.decode(str));

String actorToJson(Actor data) => json.encode(data.toJson());

class Actor {
  Actor({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
    adult: json["adult"]??false,
    gender: json["gender"]??0,
    id: json["id"]??0,
    knownForDepartment: json["known_for_department"]??"",
    name: json["name"]??"",
    originalName: json["original_name"]??"",
    popularity: json["popularity"].toDouble()??0.0,
    profilePath: json["profile_path"] ?? "https://180dc.org/wp-content/uploads/2017/11/profile-placeholder.png",
    castId: json["cast_id"]??0,
    character: json["character"]??"",
    creditId: json["credit_id"]??"",
    order: json["order"]??0,
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "gender": gender,
    "id": id,
    "known_for_department": knownForDepartment,
    "name": name,
    "original_name": originalName,
    "popularity": popularity,
    "profile_path": profilePath,
    "cast_id": castId,
    "character": character,
    "credit_id": creditId,
    "order": order,
  };
}