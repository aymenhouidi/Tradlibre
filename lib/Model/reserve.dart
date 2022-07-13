// To parse required this JSON data, do
//
//     final reserve = reserveFromJson(jsonString);

import 'dart:convert';

Reserve reserveFromJson(String str) => Reserve.fromJson(json.decode(str));

String reserveToJson(Reserve data) => json.encode(data.toJson());

class Reserve {
    Reserve({
        required this.message,
        required this.hasPermission,
        required this.rdv,
    });

    String message;
    bool hasPermission;
    List<Rdv> rdv;

    factory Reserve.fromJson(Map<String, dynamic> json) => Reserve(
        message: json["message"],
        hasPermission: json["hasPermission"],
        rdv: List<Rdv>.from(json["rdv"].map((x) => Rdv.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "hasPermission": hasPermission,
        "rdv": List<dynamic>.from(rdv.map((x) => x.toJson())),
    };
}

class Rdv {
    Rdv({
        required this.id,
        required this.type,
        required this.langue,
        required this.adresse,
        required this.phone,
        required this.start,
        required this.end,
        required this.duree,
        required this.etat,
        required this.desc,
        required this.pc,
        required this.hasEdit,
        required this.typeTarif,
        required this.tarification,
        required this.info,
        required this.hasVue,
        required this.autoentrepreneur,
        required this.hasChangeDuration,
    });

    int id;
    String type;
    String langue;
    String adresse;
    String phone;
    DateTime start;
    DateTime end;
    int duree;
    String etat;
    String desc;
    String pc;
    bool hasEdit;
    String typeTarif;
    int tarification;
    Info info;
    int hasVue;
    bool autoentrepreneur;
    int hasChangeDuration;

    factory Rdv.fromJson(Map<String, dynamic> json) => Rdv(
        id: json["id"],
        type: json["type"],
        langue: json["langue"],
        adresse: json["adresse"],
        phone: json["phone"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        duree: json["duree"],
        etat: json["etat"],
        desc: json["desc"],
        pc: json["pc"],
        hasEdit: json["hasEdit"],
        typeTarif: json["typeTarif"],
        tarification: json["tarification"],
        info: Info.fromJson(json["info"]),
        hasVue: json["hasVue"],
        autoentrepreneur: json["Autoentrepreneur"],
        hasChangeDuration: json["hasChangeDuration"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "langue": langue,
        "adresse": adresse,
        "phone": phone,
        "start": start.toIso8601String(),
        "end": end.toIso8601String(),
        "duree": duree,
        "etat": etat,
        "desc": desc,
        "pc": pc,
        "hasEdit": hasEdit,
        "typeTarif": typeTarif,
        "tarification": tarification,
        "info": info.toJson(),
        "hasVue": hasVue,
        "Autoentrepreneur": autoentrepreneur,
        "hasChangeDuration": hasChangeDuration,
    };
}

class Info {
    Info({
        required this.nom,
        required this.prenom,
        required this.gender,
        required this.entreprise,
        required this.service,
        required this.adresse,
        required this.phone,
        required this.email,
    });

    String nom;
    String prenom;
    String gender;
    String entreprise;
    String service;
    String adresse;
    String phone;
    String email;

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        nom: json["nom"],
        prenom: json["prenom"],
        gender: json["gender"],
        entreprise: json["entreprise"],
        service: json["service"],
        adresse: json["adresse"],
        phone: json["phone"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "nom": nom,
        "prenom": prenom,
        "gender": gender,
        "entreprise": entreprise,
        "service": service,
        "adresse": adresse,
        "phone": phone,
        "email": email,
    };
}
