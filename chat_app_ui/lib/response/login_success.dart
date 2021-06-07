// To parse this JSON data, do
//
//     final loginSuccess = loginSuccessFromJson(jsonString);

import 'dart:convert';

LoginSuccess loginSuccessFromJson(String str) => LoginSuccess.fromJson(json.decode(str));

String loginSuccessToJson(LoginSuccess data) => json.encode(data.toJson());

class LoginSuccess {
  LoginSuccess({
    this.refreshToken,
    this.id,
    this.username,
    this.email,
    this.roles,
    this.accessToken,
    this.tokenType,
  });

  String refreshToken;
  int id;
  String username;
  String email;
  List<String> roles;
  String accessToken;
  String tokenType;

  factory LoginSuccess.fromJson(Map<String, dynamic> json) => LoginSuccess(
    refreshToken: json["refreshToken"],
    id: json["id"],
    username: json["username"],
    email: json["email"],
    roles: List<String>.from(json["roles"].map((x) => x)),
    accessToken: json["accessToken"],
    tokenType: json["tokenType"],
  );

  Map<String, dynamic> toJson() => {
    "refreshToken": refreshToken,
    "id": id,
    "username": username,
    "email": email,
    "roles": List<dynamic>.from(roles.map((x) => x)),
    "accessToken": accessToken,
    "tokenType": tokenType,
  };
}
