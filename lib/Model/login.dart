import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    required this.user,
    required this.token,
    required this.message,
    required this.hasPermission,
  });

  dynamic user;
  String token;
  String message;
  bool hasPermission;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        user: json["user"],
        token: json["token"],
        message: json["message"],
        hasPermission: json["hasPermission"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
        "message": message,
        "hasPermission": hasPermission,
      };
}
class checkbody{
  checkbody({required this.Message});
  bool Message;
   factory checkbody.fromJson(Map<String, dynamic> json) => checkbody(
        Message: json["hasPermission"],
      );
}
class User {
  User({
    required this.id,
    required this.entreprise,
    required this.nom,
    required this.prenom,
    required this.adresse,
    required this.gender,
    required this.email,
    required this.phone,
    required this.enabled,
    required this.lat,
    required this.lng,
    required this.deleted,
    required this.langue,
    required this.password,
    required this.limitDistance,
    required this.token,
    required this.blackList,
  });

  int id;
  String entreprise;
  String nom;
  String prenom;
  String adresse;
  String gender;
  String email;
  String phone;
  int enabled;
  String lat;
  String lng;
  int deleted;
  List<Langue> langue;
  String password;
  String limitDistance;
  String token;
  int blackList;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        entreprise: json["entreprise"],
        nom: json["nom"],
        prenom: json["prenom"],
        adresse: json["adresse"],
        gender: json["gender"],
        email: json["email"],
        phone: json["phone"],
        enabled: json["enabled"],
        lat: json["lat"],
        lng: json["lng"],
        deleted: json["deleted"],
        langue:
            List<Langue>.from(json["langue"].map((x) => Langue.fromJson(x))),
        password: json["password"],
        limitDistance: json["limitDistance"],
        token: json["token"],
        blackList: json["blackList"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "entreprise": entreprise,
        "nom": nom,
        "prenom": prenom,
        "adresse": adresse,
        "gender": gender,
        "email": email,
        "phone": phone,
        "enabled": enabled,
        "lat": lat,
        "lng": lng,
        "deleted": deleted,
        "langue": List<dynamic>.from(langue.map((x) => x.toJson())),
        "password": password,
        "limitDistance": limitDistance,
        "token": token,
        "blackList": blackList,
      };
}

class Langue {
  Langue({
    required this.name,
    required this.status,
  });

  String name;
  bool status;

  factory Langue.fromJson(Map<String, dynamic> json) => Langue(
        name: json["name"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "status": status,
      };
}
