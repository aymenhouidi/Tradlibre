// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:intl/intl.dart';
import '../Model/reserve.dart';
import '../Service/reserve_service.dart';
import '../Widgets/AppDrawer.dart';
import '../Widgets/BlueBar.dart';
import 'LoginPage.dart';

class Reservation extends StatefulWidget {
  const Reservation({Key? key}) : super(key: key);

  @override
  _Reservation createState() => _Reservation();
}

class _Reservation extends State<Reservation> {
  DateTime? selectedDate = DateTime.now();
  DateTime? changedDate = DateTime.now();

  List<Rdv> rdvs = [];
  //late Rdv rdv;
  //initialisation
  @override
  void initState() {
    super.initState();
    ReserveService()
        .postReserve(Login.token.toString(),
            DateFormat('yyyy-MM-dd').format(changedDate!), "week")
        .then((value) {
      for (Rdv rdv in value.rdv) {
        rdvs.add(rdv);
      }
      setState(() {});
    });
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
            name: "Réservations",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 300,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(2, 40, 2, 0),
                                        child: Text(
                                          "ANNULER",
                                          style: TextStyle(
                                              fontFamily: 'Neometric',
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                  const SizedBox(width: 32),
                                  GestureDetector(
                                      onTap: () {
                                        changedDate = selectedDate;
                                        ReserveService()
                                            .postReserve(
                                                Login.token.toString(),
                                                DateFormat('yyyy-MM-dd')
                                                    .format(changedDate!),
                                                "week")
                                            .then((value) {
                                          rdvs.clear();
                                          for (Rdv rdv in value.rdv) {
                                            rdvs.add(rdv);
                                          }
                                          setState(() {});
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(2, 40, 2, 0),
                                        child: Text(
                                          "OK",
                                          style: TextStyle(
                                              fontFamily: 'Neometric',
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                  const SizedBox(width: 16),
                                ],
                              ),
                              DatePickerWidget(
                                  looping: false,
                                  firstDate: DateTime(1922, 01, 01),
                                  lastDate: DateTime(2025, 12, 31),
                                  initialDate: changedDate,
                                  dateFormat: "dd-MM-yyyy",
                                  locale: DatePicker.localeFromString('en'),
                                  onChange: (DateTime newDate, _) {
                                    setState(() {
                                      selectedDate = newDate;
                                    });
                                  }),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(35, 13, 35, 8),
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    DateFormat('dd/MM/yyyy').format(changedDate!),
                    style: const TextStyle(
                        fontFamily: 'Neometric',
                        fontSize: 22,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            if (rdvs.isEmpty)
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 48, 0, 0),
                child: Text("Vous n'avez aucune réservation cette semaine",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              )
            else
              for (int index = 0; index < rdvs.length; index++)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                  child: Card(
                    //elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconContainer(
                                title: "Numero de telephone",
                                text: rdvs[index].phone,
                                icon: Image.asset(
                                    "assets/tel.png" /*, width: 85, height: 85*/),
                              ),
                              const SizedBox(
                                width: 24,
                              ),
                              IconContainer(
                                title: "Date et heure",
                                text: DateFormat('dd/MM/yyyy')
                                        .format(rdvs[index].start) +
                                    " ${rdvs[index].start.hour + 2}:${rdvs[index].start.minute}",
                                icon: Image.asset(
                                    "assets/iconDate.png" /*, width: 85, height: 85*/),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          IconButton(
                            onPressed: (() {
                              Info info = rdvs[index].info;
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        content: Text(
                                            '''${info.gender} ${info.prenom} ${info.nom}
Adresse: ${info.adresse}
Tel: ${info.phone}
Service: ${info.service}
Entreprise: ${info.entreprise}
Langue: ${rdvs[index].langue}''',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700)),
                                      ));
                            }),
                            icon: const Icon(Icons.info, color: Colors.blue),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconContainer(
                                title: "Duree",
                                text: rdvs[index].duree.toString() + " min",
                                icon: Image.asset(
                                    "assets/iconDuree.png" /*, width: 85, height: 85*/),
                              ),
                              const SizedBox(
                                width: 24,
                              ),
                              IconContainer(
                                title: "Type",
                                text:
                                    '${rdvs[index].type}\n${rdvs[index].typeTarif}\n${rdvs[index].tarification}€',
                                icon: Image.asset(
                                    "assets/iconType.png" /*, width: 85, height: 85*/),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                              rdvs[index].etat,
                              style: const TextStyle(
                                  fontFamily: 'Neometric',
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
          ]),
        ));
  }
}

class IconContainer extends StatelessWidget {
  final String title;
  final String text;
  final Image icon;
  const IconContainer({
    required this.title,
    required this.text,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //margin: EdgeInsets.all(16.0),

        child: Stack(alignment: Alignment.topCenter, children: [
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontFamily: 'Neometric',
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              text,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.41,
        height: MediaQuery.of(context).size.height * 0.18,
        margin: const EdgeInsets.only(top: 16.0),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 239, 239, 239),
            border: Border.all(
              color: Colors.transparent,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
      ),
      SizedBox(
          child: CircleAvatar(
        backgroundColor: const Color.fromARGB(250, 239, 239, 239),
        child: icon,
      )),
    ]));
  }
}
