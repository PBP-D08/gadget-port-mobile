// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    Model model;
    int pk;
    Fields fields;

    Product({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
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
    Category? category;
    String? name;
    String? brand;
    int? price;
    String? imageLink;
    String? spec;
    int? store;
    String? nama;
    String? alamat;
    String? nomorTelepon;
    String? logo;
    JamBuka? jamBuka;
    JamTutup? jamTutup;
    int? user;
    String? password;
    DateTime? lastLogin;
    bool? isSuperuser;
    String? username;
    String? firstName;
    String? lastName;
    String? email;
    bool? isStaff;
    bool? isActive;
    DateTime? dateJoined;
    String? fullName;
    Role? role;
    List<dynamic>? groups;
    List<dynamic>? userPermissions;

    Fields({
        this.category,
        this.name,
        this.brand,
        this.price,
        this.imageLink,
        this.spec,
        this.store,
        this.nama,
        this.alamat,
        this.nomorTelepon,
        this.logo,
        this.jamBuka,
        this.jamTutup,
        this.user,
        this.password,
        this.lastLogin,
        this.isSuperuser,
        this.username,
        this.firstName,
        this.lastName,
        this.email,
        this.isStaff,
        this.isActive,
        this.dateJoined,
        this.fullName,
        this.role,
        this.groups,
        this.userPermissions,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        category: categoryValues.map[json["category"]]!,
        name: json["name"],
        brand: json["brand"],
        price: json["price"],
        imageLink: json["image_link"],
        spec: json["spec"],
        store: json["store"],
        nama: json["nama"],
        alamat: json["alamat"],
        nomorTelepon: json["nomor_telepon"],
        logo: json["logo"],
        jamBuka: jamBukaValues.map[json["jam_buka"]]!,
        jamTutup: jamTutupValues.map[json["jam_tutup"]]!,
        user: json["user"],
        password: json["password"],
        lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
        isSuperuser: json["is_superuser"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        isStaff: json["is_staff"],
        isActive: json["is_active"],
        dateJoined: json["date_joined"] == null ? null : DateTime.parse(json["date_joined"]),
        fullName: json["full_name"],
        role: roleValues.map[json["role"]]!,
        groups: json["groups"] == null ? [] : List<dynamic>.from(json["groups"]!.map((x) => x)),
        userPermissions: json["user_permissions"] == null ? [] : List<dynamic>.from(json["user_permissions"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "category": categoryValues.reverse[category],
        "name": name,
        "brand": brand,
        "price": price,
        "image_link": imageLink,
        "spec": spec,
        "store": store,
        "nama": nama,
        "alamat": alamat,
        "nomor_telepon": nomorTelepon,
        "logo": logo,
        "jam_buka": jamBukaValues.reverse[jamBuka],
        "jam_tutup": jamTutupValues.reverse[jamTutup],
        "user": user,
        "password": password,
        "last_login": lastLogin?.toIso8601String(),
        "is_superuser": isSuperuser,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "is_staff": isStaff,
        "is_active": isActive,
        "date_joined": dateJoined?.toIso8601String(),
        "full_name": fullName,
        "role": roleValues.reverse[role],
        "groups": groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
        "user_permissions": userPermissions == null ? [] : List<dynamic>.from(userPermissions!.map((x) => x)),
    };
}

enum Category {
    EARPHONE,
    HP,
    LAPTOP
}

final categoryValues = EnumValues({
    "earphone": Category.EARPHONE,
    "hp": Category.HP,
    "laptop": Category.LAPTOP
});

enum JamBuka {
    THE_0800,
    THE_0830,
    THE_0900
}

final jamBukaValues = EnumValues({
    "08:00": JamBuka.THE_0800,
    "08:30": JamBuka.THE_0830,
    "09:00": JamBuka.THE_0900
});

enum JamTutup {
    THE_2100,
    THE_2130,
    THE_2200,
    THE_2230
}

final jamTutupValues = EnumValues({
    "21:00": JamTutup.THE_2100,
    "21:30": JamTutup.THE_2130,
    "22:00": JamTutup.THE_2200,
    "22:30": JamTutup.THE_2230
});

enum Role {
    ADMIN,
    BUYER
}

final roleValues = EnumValues({
    "admin": Role.ADMIN,
    "buyer": Role.BUYER
});

enum Model {
    AUTHENTICATION_USER,
    PRODUCTS_KATALOG,
    STORE_STORE
}

final modelValues = EnumValues({
    "authentication.user": Model.AUTHENTICATION_USER,
    "products.Katalog": Model.PRODUCTS_KATALOG,
    "store.Store": Model.STORE_STORE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
