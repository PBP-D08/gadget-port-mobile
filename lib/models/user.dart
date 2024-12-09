// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
    int id;
    int userId;
    DateTime userLastLogin;
    String userUsername;
    String userFirstName;
    String userEmail;
    String? userBio;
    String userFullName;
    String userRole;
    String userAlamat;

    Welcome({
        required this.id,
        required this.userId,
        required this.userLastLogin,
        required this.userUsername,
        required this.userFirstName,
        required this.userEmail,
        required this.userBio,
        required this.userFullName,
        required this.userRole,
        required this.userAlamat,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        id: json["id"],
        userId: json["user_id"],
        userLastLogin: DateTime.parse(json["user__last_login"]),
        userUsername: json["user__username"],
        userFirstName: json["user__first_name"],
        userEmail: json["user__email"],
        userBio: json["user__bio"],
        userFullName: json["user__full_name"],
        userRole: json["user__role"],
        userAlamat: json["user__alamat"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user__last_login": userLastLogin.toIso8601String(),
        "user__username": userUsername,
        "user__first_name": userFirstName,
        "user__email": userEmail,
        "user__bio": userBio,
        "user__full_name": userFullName,
        "user__role": userRole,
        "user__alamat": userAlamat,
    };
}
