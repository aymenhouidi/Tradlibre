// To parse required this JSON data, do
//
//     final semaine = semaineFromJson(jsonString);

import 'dart:convert';

Semaine semaineFromJson(String str) => Semaine.fromJson(json.decode(str));

String semaineToJson(Semaine data) => json.encode(data.toJson());

class Semaine {
    Semaine({
        required this.message,
        required this.hasPermission,
        required this.workShedule,
    });

    String message;
    bool hasPermission;
    WorkShedule workShedule;

    factory Semaine.fromJson(Map<String, dynamic> json) => Semaine(
        message: json["message"],
        hasPermission: json["hasPermission"],
        workShedule: WorkShedule.fromJson(json["workShedule"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "hasPermission": hasPermission,
        "workShedule": workShedule.toJson(),
    };
}

class WorkShedule {
    WorkShedule({
        required this.week,
        required this.redundant,
        required this.shedule,
    });

    int week;
    bool redundant;
    List<Shedule> shedule;

    factory WorkShedule.fromJson(Map<String, dynamic> json) => WorkShedule(
        week: json["week"],
        redundant: json["redundant"],
        shedule: List<Shedule>.from(json["shedule"].map((x) => Shedule.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "week": week,
        "redundant": redundant,
        "shedule": List<dynamic>.from(shedule.map((x) => x.toJson())),
    };
}

class Shedule {
    Shedule({
        required this.wholeDay,
        required this.workDay,
        required this.dayName,
        required this.day,
        required this.open,
        required this.time,
    });

    bool wholeDay;
    bool workDay;
    String dayName;
    int day;
    bool open;
    Time time;

    factory Shedule.fromJson(Map<String, dynamic> json) => Shedule(
        wholeDay: json["whole_day"],
        workDay: json["work_day"],
        dayName: json["dayName"],
        day: json["day"],
        open: json["open"],
        time: Time.fromJson(json["time"]),
    );

    Map<String, dynamic> toJson() => {
        "whole_day": wholeDay,
        "work_day": workDay,
        "dayName": dayName,
        "day": day,
        "open": open,
        "time": time.toJson(),
    };
}

class Time {
    Time({
        required this.morningFromTime,
        required this.morningToTime,
        required this.afternoonFromTime,
        required this.afternoonToTime,
    });

    String morningFromTime;
    String morningToTime;
    String afternoonFromTime;
    String afternoonToTime;

    factory Time.fromJson(Map<String, dynamic> json) => Time(
        morningFromTime: json["morning_from_time"],
        morningToTime: json["morning_to_time"],
        afternoonFromTime: json["afternoon_from_time"],
        afternoonToTime: json["afternoon_to_time"],
    );

    Map<String, dynamic> toJson() => {
        "morning_from_time": morningFromTime,
        "morning_to_time": morningToTime,
        "afternoon_from_time": afternoonFromTime,
        "afternoon_to_time": afternoonToTime,
    };
}
