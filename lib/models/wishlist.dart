// To parse this JSON data, do
//
//     final wishlist = wishlistFromJson(jsonString);

import 'dart:convert';

List<Wishlist> wishlistFromJson(String str) =>
    List<Wishlist>.from(json.decode(str).map((x) => Wishlist.fromJson(x)));

String wishlistToJson(List<Wishlist> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Wishlist {
  String model;
  int pk;
  Fields fields;

  Wishlist({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int user;
  int product;
  DateTime addedOn;

  Fields({
    required this.user,
    required this.product,
    required this.addedOn,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        product: json["product"],
        addedOn: DateTime.parse(json["added_on"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "product": product,
        "added_on": addedOn.toIso8601String(),
      };
}
