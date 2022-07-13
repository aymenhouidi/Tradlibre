// ignore_for_file: deprecated_member_use
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:tradlibre/Service/semaine_service.dart';
import 'package:tradlibre/Widgets/TimeButton.dart';
import 'package:tradlibre/Widgets/BlackButton.dart';

import '../Model/semaine.dart';
import '../Service/changerSeamine_service.dart';
import '../Widgets/AppDrawer.dart';
import '../Widgets/BlueBar.dart';
import 'LoginPage.dart';

class Horaire extends StatefulWidget {
  const Horaire({Key? key}) : super(key: key);

  @override
  _Horaire createState() => _Horaire();
}

class _Horaire extends State<Horaire> {
  //initialisation
  //late TimeOfDay auxTime;
  dynamic heureDebut1 = List<TimeOfDay>.generate(
      7, (int indexx) => const TimeOfDay(hour: 9, minute: 30));
  dynamic heureFin1 = List<TimeOfDay>.generate(
      7, (int indexx) => const TimeOfDay(hour: 13, minute: 0));
  dynamic heureDebut2 = List<TimeOfDay>.generate(
      7, (int indexx) => const TimeOfDay(hour: 15, minute: 0));
  dynamic heureFin2 = List<TimeOfDay>.generate(
      7, (int indexx) => const TimeOfDay(hour: 19, minute: 0));
  dynamic heureDebutAux1 = List<TimeOfDay>.generate(
      7, (int indexx) => const TimeOfDay(hour: 9, minute: 30));
  dynamic heureFinAux1 = List<TimeOfDay>.generate(
      7, (int indexx) => const TimeOfDay(hour: 13, minute: 0));
  dynamic heureDebutAux2 = List<TimeOfDay>.generate(
      7, (int indexx) => const TimeOfDay(hour: 15, minute: 0));
  dynamic heureFinAux2 = List<TimeOfDay>.generate(
      7, (int indexx) => const TimeOfDay(hour: 19, minute: 0));
  List<bool> checkedDays = List<bool>.generate(7, (int indexx) => false);
  List<bool> checkedService = List<bool>.generate(7, (int indexx) => false);
  List<Shedule> shedule = [];
  bool onlyWeek = false;
  late int selectedWeek = weekNumber();
  List<String> days = [
    "Lundi",
    "Mardi",
    "Mercredi",
    "Jeudi",
    "Vendredi",
    "Samedi",
    "Dimanche"
  ];
  final List<Map<String, dynamic>> _items =
      List.generate(7, (index) => {'id': index, 'isExpanded': false});
  @override
  void initState() {
    super.initState();
    SemaineService().postSemaine(Login.token, selectedWeek).then((value) {
      for (int index = 0; index < 7; index++) {
        heureDebut1[index] = TimeOfDay(
            hour: int.parse(value
                .workShedule.shedule[index].time.morningFromTime
                .substring(0, 2)),
            minute: int.parse(value
                .workShedule.shedule[index].time.morningFromTime
                .substring(3, 5)));
        heureDebut2[index] = TimeOfDay(
            hour: int.parse(value
                .workShedule.shedule[index].time.afternoonFromTime
                .substring(0, 2)),
            minute: int.parse(value
                .workShedule.shedule[index].time.afternoonFromTime
                .substring(3, 5)));
        heureFin1[index] = TimeOfDay(
            hour: int.parse(value.workShedule.shedule[index].time.morningToTime
                .substring(0, 2)),
            minute: int.parse(value
                .workShedule.shedule[index].time.morningToTime
                .substring(3, 5)));
        heureFin2[index] = TimeOfDay(
            hour: int.parse(value
                .workShedule.shedule[index].time.afternoonToTime
                .substring(0, 2)),
            minute: int.parse(value
                .workShedule.shedule[index].time.afternoonToTime
                .substring(3, 5)));
        checkedDays[index] = value.workShedule.shedule[index].workDay;
        checkedService[index] = value.workShedule.shedule[index].wholeDay;
      }
      setState(() {});
      shedule = value.workShedule.shedule;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color.fromARGB(250, 239, 239, 239),
      drawer: const AppDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: BlueBar(
          scaffoldKey: _scaffoldKey,
          name: "Horaires",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: Text(
                      'LA SEMAINE',
                      style: TextStyle(
                          fontFamily: 'Neometric',
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.25),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return FractionallySizedBox(
                              heightFactor: 1,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.93,
                                    child: ListView(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(8),
                                        children: <Widget>[
                                          for (int index = weekNumber();
                                              index <= 52;
                                              index++)
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.white,
                                                padding:
                                                    const EdgeInsets.all(15),
                                                elevation: 0,
                                              ),
                                              onPressed: () {
                                                /*heureDebut1.clear();
                                                heureDebut2.clear();
                                                heureFin1.clear();
                                                heureFin2.clear();*/
                                                selectedWeek = index;
                                                Navigator.pop(context);
                                                SemaineService()
                                                    .postSemaine(Login.token,
                                                        selectedWeek)
                                                    .then((value) {
                                                  for (int indexx = 0;
                                                      indexx < 7;
                                                      indexx++) {
                                                    heureDebutAux1[
                                                            indexx] =
                                                        TimeOfDay(
                                                            hour: int.parse(value
                                                                .workShedule
                                                                .shedule[indexx]
                                                                .time
                                                                .morningFromTime
                                                                .substring(
                                                                    0, 2)),
                                                            minute: int.parse(value
                                                                .workShedule
                                                                .shedule[indexx]
                                                                .time
                                                                .morningFromTime
                                                                .substring(
                                                                    3, 5)));
                                                    heureDebutAux2[indexx] = TimeOfDay(
                                                        hour: int.parse(value
                                                            .workShedule
                                                            .shedule[indexx]
                                                            .time
                                                            .afternoonFromTime
                                                            .substring(0, 2)),
                                                        minute: int.parse(value
                                                            .workShedule
                                                            .shedule[indexx]
                                                            .time
                                                            .afternoonFromTime
                                                            .substring(3, 5)));
                                                    heureFinAux1[
                                                            indexx] =
                                                        TimeOfDay(
                                                            hour: int.parse(value
                                                                .workShedule
                                                                .shedule[indexx]
                                                                .time
                                                                .morningToTime
                                                                .substring(
                                                                    0, 2)),
                                                            minute: int.parse(value
                                                                .workShedule
                                                                .shedule[indexx]
                                                                .time
                                                                .morningToTime
                                                                .substring(
                                                                    3, 5)));
                                                    heureFinAux2[
                                                            indexx] =
                                                        TimeOfDay(
                                                            hour: int.parse(value
                                                                .workShedule
                                                                .shedule[indexx]
                                                                .time
                                                                .afternoonToTime
                                                                .substring(
                                                                    0, 2)),
                                                            minute: int.parse(value
                                                                .workShedule
                                                                .shedule[indexx]
                                                                .time
                                                                .afternoonToTime
                                                                .substring(
                                                                    3, 5)));
                                                    checkedDays[indexx] = value
                                                        .workShedule
                                                        .shedule[indexx]
                                                        .workDay;
                                                    checkedService[indexx] =
                                                        value
                                                            .workShedule
                                                            .shedule[indexx]
                                                            .wholeDay;
                                                  }
                                                  setState(() {});
                                                });
                                                heureDebut1 = heureDebutAux1;
                                                heureDebut2 = heureDebutAux2;
                                                heureFin1 = heureFinAux1;
                                                heureFin2 = heureFinAux2;
                                              },
                                              child: Center(
                                                  child: Text(
                                                "$index",
                                                style: TextStyle(
                                                    fontFamily: 'Neometric',
                                                    fontSize: 22,
                                                    color: Colors.black,
                                                    fontWeight: selectedFont(
                                                        index, selectedWeek)),
                                              )),
                                            ),
                                        ]),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        .07,
                                    child: ElevatedButton(
                                      child: const Text('ANNULER'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(35, 13, 35, 8),
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "$selectedWeek",
                          style: const TextStyle(
                              fontFamily: 'Neometric',
                              fontSize: 22,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          width: 24,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ExpansionPanelList(
              elevation: 3,
              expansionCallback: (index, isExpanded) {
                setState(() {
                  _items[index]['isExpanded'] = !isExpanded;
                });
              },
              //animationDuration: Duration(milliseconds: 600),
              children: _items
                  .map(
                    (item) => ExpansionPanel(
                      canTapOnHeader: true,
                      headerBuilder: (_, isExpanded) => Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                          child: Row(
                            children: [
                              RoundCheckBox(
                                isChecked: checkedDays[item['id']],
                                uncheckedWidget: Image.asset(
                                    "assets/nocheck.png",
                                    width: 20,
                                    height: 20),
                                checkedWidget: Image.asset("assets/check.png",
                                    width: 20, height: 20),
                                size: 20,
                                onTap: (selected) {
                                  setState(() {
                                    if (checkedDays[item['id']] == true) {
                                      checkedDays[item['id']] = false;
                                    } else {
                                      checkedDays[item['id']] = true;
                                    }
                                  });
                                },
                              ),
                              const SizedBox(width: 40),
                              Text(
                                days[item['id']],
                                style: const TextStyle(
                                    fontFamily: 'Neometric',
                                    fontSize: 27,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )),
                      body: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 8,
                                ),
                                RoundCheckBox(
                                  isChecked: checkedService[item['id']],
                                  uncheckedWidget: Image.asset(
                                      "assets/nocheck.png",
                                      width: 20,
                                      height: 20),
                                  checkedWidget: Image.asset("assets/check.png",
                                      width: 20, height: 20),
                                  size: 20,
                                  onTap: (selected) {
                                    setState(() {
                                      if (checkedService[item['id']] == true) {
                                        checkedService[item['id']] = false;
                                      } else {
                                        checkedService[item['id']] = true;
                                      }
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                const Text(
                                  "Service continu",
                                  style: TextStyle(
                                      fontFamily: 'Neometric',
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      "Heure debut",
                                      style: TextStyle(
                                          fontFamily: 'Neometric',
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w200),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    TimeButton(
                                        index: item['id'],
                                        timeList: heureDebut1),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    if (checkedService[item['id']] == false)
                                      TimeButton(
                                          index: item['id'],
                                          timeList: heureDebut2),
                                  ],
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      "Heure fin",
                                      style: TextStyle(
                                          fontFamily: 'Neometric',
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w200),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    if (checkedService[item['id']] == false)
                                      TimeButton(
                                          index: item['id'],
                                          timeList: heureFin1),
                                    if (checkedService[item['id']] == false)
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.015,
                                      ),
                                    TimeButton(
                                        index: item['id'], timeList: heureFin2),
                                    if (checkedService[item['id']] == true)
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.015,
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      isExpanded: item['isExpanded'],
                    ),
                  )
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(31, 24, 0, 0),
              child: Row(
                children: [
                  RoundCheckBox(
                    uncheckedWidget: Image.asset("assets/nocheck.png",
                        width: 20, height: 20),
                    checkedWidget:
                        Image.asset("assets/check.png", width: 20, height: 20),
                    size: 20,
                    onTap: (selected) {
                      if (selected == true) {
                        onlyWeek = true;
                      } else if (selected == false) {
                        onlyWeek = false;
                      }
                    },
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Text(
                    "Uniquement cette semaine",
                    style: TextStyle(
                        fontFamily: 'Neometric',
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: BlackButton(
                name: "APPLIQUER",
                onPressed: () {
                  for (int i = 0; i < shedule.length; i++) {
                    shedule[i].time.morningFromTime =
                        stringTime(heureDebut1[i]);
                    shedule[i].time.morningToTime = stringTime(heureFin1[i]);
                    shedule[i].time.afternoonFromTime =
                        stringTime(heureDebut2[i]);
                    shedule[i].time.afternoonToTime = stringTime(heureFin2[i]);
                    shedule[i].workDay = checkedDays[i];
                    shedule[i].wholeDay = checkedService[i];
                  }
                  ChangerSemaineService()
                      .postChangerSemaine(
                          Login.token, selectedWeek, onlyWeek, shedule)
                      .then((value) {});
                  setState(() {});
                },
                fontsize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  int weekNumber() {
    var now = DateTime.now();
    int today = now.weekday;
    var dayNr = (today + 6) % 7;
    var thisMonday = now.subtract(Duration(days: (dayNr)));
    var thisThursday = thisMonday.add(const Duration(days: 3));
    var firstThursday = DateTime(now.year, 1, 1);

    if (firstThursday.weekday != (4)) {
      firstThursday =
          DateTime(now.year, 1, 1 + ((4 - firstThursday.weekday) + 7) % 7);
    }
    var x = thisThursday.millisecondsSinceEpoch -
        firstThursday.millisecondsSinceEpoch;
    var weekNumber = x.ceil() / 604800000;
    return weekNumber.ceil();
  }

  FontWeight selectedFont(int index, int week) {
    if (week == index) {
      return FontWeight.bold;
    } else {
      return FontWeight.normal;
    }
  }

  String stringTime(TimeOfDay time) {
    String hour = time.hour.toString().length == 1
        ? "0" + time.hour.toString()
        : time.hour.toString();
    String minute = time.minute.toString().length == 1
        ? "0" + time.minute.toString()
        : time.minute.toString();
    return hour + ":" + minute;
  }
}
