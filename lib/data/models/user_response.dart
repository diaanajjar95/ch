// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  int status;
  String msg;
  User data;

  UserResponse({
    this.status,
    this.msg,
    this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        status: json["status"],
        msg: json["Msg"],
        data: User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Msg": msg,
        "data": data.toJson(),
      };
}

class User {
  String id;
  String accessToken;
  String fireBaseAccessToken;
  String name;
  String phoneNumber;
  String email;
  double walet;
  int points;

  User({
    this.id,
    this.accessToken,
    this.fireBaseAccessToken,
    this.name,
    this.phoneNumber,
    this.email,
    this.walet,
    this.points,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["Id"],
        accessToken: json["AccessToken"],
        fireBaseAccessToken: json["FireBaseAccessToken"],
        name: json["Name"],
        phoneNumber: json["PhoneNumber"],
        email: json["Email"],
        walet: json["Walet"],
        points: json["Points"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "AccessToken": accessToken,
        "FireBaseAccessToken": fireBaseAccessToken,
        "Name": name,
        "PhoneNumber": phoneNumber,
        "Email": email,
        "Walet": walet,
        "Points": points,
      };
}
