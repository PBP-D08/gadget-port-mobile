// To parse this JSON data, do
//
//     final store = storeFromJson(jsonString);

import 'dart:convert';

List<Store> storeFromJson(String str) =>
    List<Store>.from(json.decode(str).map((x) => Store.fromJson(x)));

String storeToJson(List<Store> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Store {
  Model model;
  int pk;
  Fields fields;

  Store({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int user;
  String nama;
  String alamat;
  String nomorTelepon;
  String logo;
  String jamBuka;
  String jamTutup;

  Fields({
    required this.user,
    required this.nama,
    required this.alamat,
    required this.nomorTelepon,
    required this.logo,
    required this.jamBuka,
    required this.jamTutup,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        nama: json["nama"],
        alamat: json["alamat"],
        nomorTelepon: json["nomor_telepon"],
        logo: json["logo"],
        jamBuka: json["jam_buka"],
        jamTutup: json["jam_tutup"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "nama": nama,
        "alamat": alamat,
        "nomor_telepon": nomorTelepon,
        "logo": logo,
        "jam_buka": jamBuka,
        "jam_tutup": jamTutup,
      };
}

enum Model { STORE_STORE }

final modelValues = EnumValues({"store.store": Model.STORE_STORE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
