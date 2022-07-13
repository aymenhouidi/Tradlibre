// To parse this JSON data, do
//
//     final absence = absenceFromJson(jsonString);

import 'dart:convert';

Absence absenceFromJson(String str) => Absence.fromJson(json.decode(str));

String absenceToJson(Absence data) => json.encode(data.toJson());

class Absence {
    Absence({
        required this.message,
        required this.status,
        required this.hasPermission,
    });

    String message;
    bool status;
    bool hasPermission;

    factory Absence.fromJson(Map<String, dynamic> json) => Absence(
        message: json["message"],
        status: json["status"],
        hasPermission: json["hasPermission"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "hasPermission": hasPermission,
    };
}
