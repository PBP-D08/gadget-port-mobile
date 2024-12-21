// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

List<Review> reviewFromJson(String str) => List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
    int id;
    Fields fields;
    User user;

    Review({
        required this.id,
        required this.fields,
        required this.user,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        fields: Fields.fromJson(json["fields"]),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fields": fields.toJson(),
        "user": user.toJson(),
    };
}

class Fields {
    int rating;
    String reviewText;
    DateTime timestamp;

    Fields({
        required this.rating,
        required this.reviewText,
        required this.timestamp,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        rating: json["rating"],
        reviewText: json["review_text"],
        timestamp: DateTime.parse(json["timestamp"]),
    );

  get text => null;

  get username => null;

    Map<String, dynamic> toJson() => {
        "rating": rating,
        "review_text": reviewText,
        "timestamp": timestamp.toIso8601String(),
    };
}

class User {
    String username;
    int id;

    User({
        required this.username,
        required this.id,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "id": id,
    };
}
