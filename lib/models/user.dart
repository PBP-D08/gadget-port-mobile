// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

List<UserProfile> userProfileFromJson(String str) => List<UserProfile>.from(
    json.decode(str).map((x) => UserProfile.fromJson(x)));

String userProfileToJson(List<UserProfile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserProfile {
  int id;
  int userId;
  String userPassword;
  DateTime? userLastLogin;
  bool userIsSuperuser;
  String userUsername;
  String userFirstName;
  String userLastName;
  UserEmail userEmail;
  String? userBio;
  bool userIsStaff;
  bool userIsActive;
  DateTime userDateJoined;
  String userFullName;
  UserRole userRole;
  String userAlamat;
  dynamic userGroups;
  dynamic userUserPermissions;
  dynamic parentProfileId;

  UserProfile({
    required this.id,
    required this.userId,
    required this.userPassword,
    required this.userLastLogin,
    required this.userIsSuperuser,
    required this.userUsername,
    required this.userFirstName,
    required this.userLastName,
    required this.userEmail,
    required this.userBio,
    required this.userIsStaff,
    required this.userIsActive,
    required this.userDateJoined,
    required this.userFullName,
    required this.userRole,
    required this.userAlamat,
    required this.userGroups,
    required this.userUserPermissions,
    required this.parentProfileId,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        userId: json["user_id"],
        userPassword: json["user__password"],
        userLastLogin: json["user__last_login"] == null
            ? null
            : DateTime.parse(json["user__last_login"]),
        userIsSuperuser: json["user__is_superuser"],
        userUsername: json["user__username"],
        userFirstName: json["user__first_name"],
        userLastName: json["user__last_name"],
        userEmail: userEmailValues.map[json["user__email"]]!,
        userBio: json["user__bio"],
        userIsStaff: json["user__is_staff"],
        userIsActive: json["user__is_active"],
        userDateJoined: DateTime.parse(json["user__date_joined"]),
        userFullName: json["user__full_name"],
        userRole: userRoleValues.map[json["user__role"]]!,
        userAlamat: json["user__alamat"],
        userGroups: json["user__groups"],
        userUserPermissions: json["user__user_permissions"],
        parentProfileId: json["parent_profile_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user__password": userPassword,
        "user__last_login": userLastLogin?.toIso8601String(),
        "user__is_superuser": userIsSuperuser,
        "user__username": userUsername,
        "user__first_name": userFirstName,
        "user__last_name": userLastName,
        "user__email": userEmailValues.reverse[userEmail],
        "user__bio": userBio,
        "user__is_staff": userIsStaff,
        "user__is_active": userIsActive,
        "user__date_joined": userDateJoined.toIso8601String(),
        "user__full_name": userFullName,
        "user__role": userRoleValues.reverse[userRole],
        "user__alamat": userAlamat,
        "user__groups": userGroups,
        "user__user_permissions": userUserPermissions,
        "parent_profile_id": parentProfileId,
      };
}

enum UserEmail { AKHYAR_GMAIL_COM, AOSJISPDJD_GMAIL_COM, EMPTY }

final userEmailValues = EnumValues({
  "akhyar@gmail.com": UserEmail.AKHYAR_GMAIL_COM,
  "aosjispdjd@gmail.com": UserEmail.AOSJISPDJD_GMAIL_COM,
  "": UserEmail.EMPTY
});

enum UserRole { ADMIN, BUYER }

final userRoleValues =
    EnumValues({"admin": UserRole.ADMIN, "buyer": UserRole.BUYER});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
