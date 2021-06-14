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
    this.tokenType,
    this.accessToken,
  });

  String refreshToken;
  int id;
  String username;
  String email;
  List<String> roles;
  String tokenType;
  String accessToken;

  factory LoginSuccess.fromJson(Map<String, dynamic> json) => LoginSuccess(
    refreshToken: json["refreshToken"],
    id: json["id"],
    username: json["username"],
    email: json["email"],
    roles: List<String>.from(json["roles"].map((x) => x)),
    tokenType: json["tokenType"],
    accessToken: json["accessToken"],
  );

  Map<String, dynamic> toJson() => {
    "refreshToken": refreshToken,
    "id": id,
    "username": username,
    "email": email,
    "roles": List<dynamic>.from(roles.map((x) => x)),
    "tokenType": tokenType,
    "accessToken": accessToken,
  };
}
