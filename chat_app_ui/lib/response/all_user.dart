// To parse this JSON data, do
//
//     final allUser = allUserFromJson(jsonString);

import 'dart:convert';

List<AllUser> allUserFromJson(String str) => List<AllUser>.from(json.decode(str).map((x) => AllUser.fromJson(x)));

String allUserToJson(List<AllUser> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllUser {
  AllUser({
    this.id,
    this.createdTime,
    this.lastUpdatedTime,
    this.username,
    this.email,
    this.password,
    this.roles,
  });

  int id;
  dynamic createdTime;
  dynamic lastUpdatedTime;
  String username;
  String email;
  String password;
  List<Role> roles;

  factory AllUser.fromJson(Map<String, dynamic> json) => AllUser(
    id: json["id"],
    createdTime: json["createdTime"],
    lastUpdatedTime: json["lastUpdatedTime"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdTime": createdTime,
    "lastUpdatedTime": lastUpdatedTime,
    "username": username,
    "email": email,
    "password": password,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
  };
}

class Role {
  Role({
    this.id,
    this.createdTime,
    this.lastUpdatedTime,
    this.name,
  });

  int id;
  dynamic createdTime;
  dynamic lastUpdatedTime;
  Name name;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    createdTime: json["createdTime"],
    lastUpdatedTime: json["lastUpdatedTime"],
    name: nameValues.map[json["name"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdTime": createdTime,
    "lastUpdatedTime": lastUpdatedTime,
    "name": nameValues.reverse[name],
  };
}

enum Name { ROLE_MODERATOR, ROLE_USER, ROLE_ADMIN }

final nameValues = EnumValues({
  "ROLE_ADMIN": Name.ROLE_ADMIN,
  "ROLE_MODERATOR": Name.ROLE_MODERATOR,
  "ROLE_USER": Name.ROLE_USER
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
