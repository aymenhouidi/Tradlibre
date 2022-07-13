// To parse required this JSON data, do
//
//     final changerSemaine = changerSemaineFromJson(jsonString);

import 'dart:convert';

import 'package:tradlibre/Model/semaine.dart';

ChangerSemaine changerSemaineFromJson(String str) => ChangerSemaine.fromJson(json.decode(str));

String changerSemaineToJson(ChangerSemaine data) => json.encode(data.toJson());

class ChangerSemaine {
    ChangerSemaine({
        required this.message,
        required this.hasPermission,
        required this.workShedule,
        required this.status,
    });

    String message;
    bool hasPermission;
    WorkShedule workShedule;
    bool status;

    factory ChangerSemaine.fromJson(Map<String, dynamic> json) => ChangerSemaine(
        message: json["message"],
        hasPermission: json["hasPermission"],
        workShedule: WorkShedule.fromJson(json["workShedule"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "hasPermission": hasPermission,
        "workShedule": workShedule.toJson(),
        "status": status,
    };
}

class WorkShedule {
    WorkShedule({
        required this.week,
        required this.shedule,
    });

    int week;
    List<Shedule> shedule;

    factory WorkShedule.fromJson(Map<String, dynamic> json) => WorkShedule(
        week: json["week"],
        shedule: List<Shedule>.from(json["shedule"].map((x) => Shedule.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "week": week,
        "shedule": List<dynamic>.from(shedule.map((x) => x.toJson())),
    };
}

