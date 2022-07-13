// To parse required this JSON data, do
//
//     final information = informationFromJson(jsonString);

import 'dart:convert';

import 'package:tradlibre/Model/login.dart';

Information informationFromJson(String str) => Information.fromJson(json.decode(str));

String informationToJson(Information data) => json.encode(data.toJson());

class Information {
    Information({
        required this.message,
        required this.hasPermission,
        required this.user,
    });

    String message;
    bool hasPermission;
    User user;

    factory Information.fromJson(Map<String, dynamic> json) => Information(
        message: json["message"],
        hasPermission: json["hasPermission"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "hasPermission": hasPermission,
        "user": user.toJson(),
    };
}

