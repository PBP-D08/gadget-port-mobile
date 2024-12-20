// To parse this JSON data, do
//
//     final katalog = katalogFromJson(jsonString);

import 'dart:convert';

List<Katalog> katalogFromJson(String str) =>
    List<Katalog>.from(json.decode(str).map((x) => Katalog.fromJson(x)));

String katalogToJson(List<Katalog> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Katalog {
  Model model;
  int pk;
  Fields fields;

  Katalog({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Katalog.fromJson(Map<String, dynamic> json) {
    return Katalog(
      model: modelValues.map[json["model"]] ?? Model.PRODUCTS_KATALOG,
      pk: json["pk"],
      fields: Fields.fromJson(json["fields"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  Category category;
  String name;
  String brand;
  int price;
  String imageLink;
  String spec;
  int store;

  Fields({
    required this.category,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageLink,
    required this.spec,
    required this.store,
  });

  factory Fields.fromJson(Map<String, dynamic> json) {
      return Fields(
        category: categoryValues.map[json["category"]] ?? Category.HP,
        name: json["name"],
        brand: json["brand"],
        price: json["price"],
        imageLink: json["image_link"] ?? '',
        spec: json["spec"],
        store: json["store"],
      );
  }

  Map<String, dynamic> toJson() => {
        "category": categoryValues.reverse[category],
        "name": name,
        "brand": brand,
        "price": price,
        "image_link": imageLink,
        "spec": spec,
        "store": store,
      };

  String get formattedSpec {
    return spec
        .replaceAll('\\n', '\n')
        .replaceAll('<br>', '\n')
        .trim();
  }
}

enum Category { EARPHONE, HP, LAPTOP }

final categoryValues = EnumValues({
  "hp": Category.HP,
  "earphone": Category.EARPHONE,
  "laptop": Category.LAPTOP,
});

enum Model { PRODUCTS_KATALOG }

final modelValues = EnumValues({"products.katalog": Model.PRODUCTS_KATALOG});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }

  T? get(String? key) {
    if (!map.containsKey(key)) {
      print('Unknown key: $key in EnumValues');
      return null;
    }
    return map[key];
  }
}

