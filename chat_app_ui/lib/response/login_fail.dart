// To parse this JSON data, do
//
//     final loginFail = loginFailFromJson(jsonString);

import 'dart:convert';

LoginFail loginFailFromJson(String str) => LoginFail.fromJson(json.decode(str));

String loginFailToJson(LoginFail data) => json.encode(data.toJson());

class LoginFail {
  LoginFail({
    this.path,
    this.error,
    this.message,
    this.status,
  });

  String path;
  String error;
  String message;
  int status;

  factory LoginFail.fromJson(Map<String, dynamic> json) => LoginFail(
    path: json["path"],
    error: json["error"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "path": path,
    "error": error,
    "message": message,
    "status": status,
  };
}
