import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:tradlibre/Pages/ReservationPage.dart';
import 'package:tradlibre/Service/login_service.dart';
import '../Model/login.dart';
import '../Widgets/AlertBox.dart';
import '../Widgets/BlackButton.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static String token = "";
  static List<Appointment> meetings = <Appointment>[];
  static User user = User(
      id: 0,
      entreprise: "",
      nom: "",
      prenom: "",
      adresse: "",
      gender: "",
      email: "",
      phone: "",
      enabled: 1,
      lat: "",
      lng: "",
      deleted: 0,
      langue: [],
      password: "",
      limitDistance: "",
      token: token,
      blackList: 0);

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool validEmail = true;
  bool validPassword = true;
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/connexion.jpg"), fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 230, 0, 60),
                  child: Image.asset('assets/logo.png',
                      cacheWidth: 70, cacheHeight: 70),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 9),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          EmailValidator.validate(value) == false) {
                        validEmail = false;
                        return "Merci de saisir une adresse e-mail valide.";
                      } else {
                        validEmail = true & EmailValidator.validate(value);
                      }
                      return null;
                    },
                    controller: emailController,
                    style: const TextStyle(
                        fontFamily: 'Neometric',
                        fontSize: 22,
                        color: Colors.white),
                    cursorColor: Colors.white,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(
                          fontFamily: 'Neometric',
                          fontSize: 20,
                          color: Colors.white),
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none),
                      hintText: "Adresse e-mail",
                      hintStyle: const TextStyle(
                          fontFamily: 'Neometric',
                          fontSize: 22,
                          color: Colors.white),
                      fillColor: Colors.grey.withOpacity(0.2),
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 9, 30, 12),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        validPassword = false;
                        return "Merci de saisir un mot de passe valide.";
                      } else {
                        validPassword = true;
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: true,
                    style: const TextStyle(
                        fontFamily: 'Neometric',
                        fontSize: 22,
                        color: Colors.white),
                    cursorColor: Colors.white,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(
                          fontFamily: 'Neometric',
                          fontSize: 20,
                          color: Colors.white),
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none),
                      hintText: "Mot de passe",
                      hintStyle: const TextStyle(
                          fontFamily: 'Neometric',
                          fontSize: 22,
                          color: Colors.white),
                      fillColor: Colors.grey.withOpacity(0.2),
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 10, 35, 0),
                  child: Container(
                    child: BlackButton(
                      name: "CONNEXION",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                        LoginService()
                            .connect(
                                emailController.text, passwordController.text)
                            .then((value) {
                          if (value.token != "") {
                            Login.token = value.token;
                            Login.user = User.fromJson(value.user);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Reservation()),
                            );
                          } else if (validEmail & validPassword) {
                            alertBoxDetail(context, "Connexion impossible!",
                                value.message);
                          }
                        });
                      },
                      fontsize: 22,
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(2, 40, 2, 0),
                      child: Text(
                        "Mot de passe oublie",
                        style: TextStyle(
                            fontFamily: 'Neometric',
                            fontSize: 22,
                            color: Colors.white),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}

DateTime monday(int week) {
  var now = DateTime.now();

  var firstOfMonth = DateTime(now.year, 1, 1);
  var firstMonday = firstOfMonth
      .add(Duration(days: (7 - (firstOfMonth.weekday - DateTime.monday)) % 7));
  var Monday = firstMonday;

  Monday = Monday.add(Duration(days: 7 * week - 7));

  return Monday;
}
