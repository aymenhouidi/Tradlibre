// ignore_for_file: deprecated_member_use

import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:tradlibre/Service/information_service.dart';
import 'package:tradlibre/Widgets/BlackButton.dart';

import '../Model/login.dart' as log;
import '../Widgets/AppDrawer.dart';
import '../Widgets/BlueBar.dart';
import 'LoginPage.dart';

class Infos extends StatefulWidget {
  const Infos({Key? key}) : super(key: key);

  @override
  _Infos createState() => _Infos();
}

List<int> indexes = [];
List<String> genderList = ["M", "Mme", "Mlle"];
TextEditingController nomController = TextEditingController();
TextEditingController prenomController = TextEditingController();
TextEditingController entrepriseController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController genreController = TextEditingController();
TextEditingController adresseController = TextEditingController();
log.User user = Login.user;
String genderValue = Login.user.gender;
double sliderValue = double.parse(Login.user.limitDistance);
List<log.Langue> initialValue = [];

class _Infos extends State<Infos> {
  //initialisation
  @override
  void initState() {
    super.initState();
    nomController.text = Login.user.nom;
    prenomController.text = Login.user.prenom;
    emailController.text = Login.user.email;
    entrepriseController.text = Login.user.entreprise;
    passwordController.text = Login.user.password;
    adresseController.text = Login.user.adresse;
    phoneController.text = Login.user.phone;
    initialValue.clear();
    for (int index = 0; index < Login.user.langue.length; index++) {
      if (Login.user.langue[index].status == true) {
        initialValue.add(Login.user.langue[index]);
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      backgroundColor: const Color.fromARGB(250, 239, 239, 239),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: BlueBar(
          scaffoldKey: _scaffoldKey,
          name: "Mes infos",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 40, 0, 16),
              child: Text(
                'ESPACE INTERPRETE',
                style: TextStyle(
                    fontFamily: 'Neometric',
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w800),
              ),
            ),
            InfoField(
              obscureText: false,
              controller: nomController,
              hint: "Nom",
              onChanged: (String? string) {
                user.nom = string!;
              },
            ),
            InfoField(
              obscureText: false,
              controller: prenomController,
              hint: "Prenom",
              onChanged: (String? string) {
                user.prenom = string!;
              },
            ),
            InfoField(
              obscureText: false,
              controller: emailController,
              hint: "Email",
              onChanged: (String? string) {
                user.email = string!;
              },
            ),
            InfoField(
              obscureText: false,
              controller: entrepriseController,
              hint: "Nom de l'entreprise",
              onChanged: (String? string) {
                user.entreprise = string!;
              },
            ),
            InfoField(
              obscureText: true,
              controller: passwordController,
              hint: "Mot de passe",
              onChanged: (String? string) {
                user.password = string!;
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: CustomDropdownButton2(
                buttonHeight: 55,
                buttonWidth: MediaQuery.of(context).size.width,
                buttonDecoration: BoxDecoration(
                  
                  color: Colors.white,
                  border: Border.all(
                      width: 3,
                      color: const Color.fromARGB(255, 234, 231, 231)),
                  borderRadius: BorderRadius.circular(50),
                ),
                dropdownItems: genderList,
                hint: 'select',
                onChanged: (value) {                 
                  setState(() {
                    genderValue = value!;
                    user.gender = genderValue;
                  });
                },
                value: genderValue,
              ),
            ),
            InfoField(
              obscureText: false,
              controller: adresseController,
              hint: "Adresse",
              onChanged: (String? string) {
                user.adresse = string!;
              },
            ),
            InfoField(
              obscureText: false,
              controller: phoneController,
              hint: "Numero de telephone",
              onChanged: (String? string) {
                user.phone = string!;
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: MultiSelectDialogField(
                cancelText: const Text("Annuler", style: TextStyle(fontSize: 15),),
                searchable: true,
                buttonText: const Text(
                  "Langues choisies",
                  style: TextStyle(
                      fontFamily: 'Neometric',
                      fontSize: 19,
                      color: Colors.black),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      width: 3, color: Color.fromARGB(255, 234, 231, 231)),
                  borderRadius: BorderRadius.circular(50),
                ),
                items: user.langue
                    .map((item) => MultiSelectItem<log.Langue>(item, item.name))
                    .toList(),
                initialValue: initialValue,
                onConfirm: (list) {
                  setState(() {
                    List<log.Langue> lan = list as List<log.Langue>;
                    indexes.clear();
                    for (int index1 = 0; index1 < lan.length; index1++) {
                      for (int index2 = 0;
                          index2 < user.langue.length;
                          index2++) {
                        if (lan[index1].name == user.langue[index2].name) {
                          indexes.add(index2);
                        }
                      }
                    }

                    for (int index = 0; index < user.langue.length; index++) {
                      if (indexes.contains(index)) {
                        if (user.langue[index].status == false) {
                          user.langue[index].status = true;
                        }
                      } else {
                        if (user.langue[index].status == true) {
                          user.langue[index].status = false;
                        }
                      }
                    }
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  const Text("5Km"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.72,
                  ),
                  const Text("200Km"),
                ],
              ),
            ),
            Slider(
                divisions: 195,
                min: 5,
                label: "Km",
                max: 200,
                value: sliderValue,
                onChanged: (value) {
                  setState(() {
                    sliderValue = value;
                    user.limitDistance = sliderValue.toString();
                  });
                }),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 32),
              child: Center(
                  child: BlackButton(
                      name: "Enregistrer",
                      onPressed: () {
                        InformationService()
                            .postInformation(user)
                            .then((value) => null);
                      },
                      fontsize: 22)),
            )
          ],
        ),
      ),
    );
  }
}

class InfoField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final onChanged;
  const InfoField({
    required this.hint,
    required this.controller,
    required this.obscureText,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: TextFormField(
        obscureText: obscureText,
          controller: controller,
          onChanged: onChanged,
          style: const TextStyle(
              fontFamily: 'Neometric', fontSize: 19, color: Colors.black),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(18),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 3, color: Color.fromARGB(255, 234, 231, 231)),
              borderRadius: BorderRadius.circular(50),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.blue),
              borderRadius: BorderRadius.circular(50),
            ),
            hintText: hint,
            hintStyle: const TextStyle(
                fontFamily: 'Neometric', fontSize: 19, color: Colors.grey),
          )),
    );
  }
}
