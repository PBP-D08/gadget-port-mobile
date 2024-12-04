// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

List<Review> reviewFromJson(String str) =>
    List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
  String model;
  int pk;
  Fields fields;

  Review({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
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
  String reviewText;
  int rating;
  int product;
  DateTime timestamp;

  Fields({
    required this.user,
    required this.reviewText,
    required this.rating,
    required this.product,
    required this.timestamp,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        reviewText: json["review_text"],
        rating: json["rating"],
        product: json["product"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "review_text": reviewText,
        "rating": rating,
        "product": product,
        "timestamp": timestamp.toIso8601String(),
      };
}
