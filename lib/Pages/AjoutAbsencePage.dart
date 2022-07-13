// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tradlibre/Pages/LoginPage.dart';
import 'package:tradlibre/Service/absence_service.dart';
import 'package:tradlibre/Service/semaine_service.dart';
import 'package:tradlibre/Widgets/TimeButton.dart';
import 'package:tradlibre/Widgets/BlackButton.dart';
import '../Model/reserve.dart';
import '../Service/reserve_service.dart';
import '../Widgets/BlackButton.dart';
import '../Widgets/AppDrawer.dart';
import '../Widgets/BlueBar.dart';

class AjoutAbsence extends StatefulWidget {
  const AjoutAbsence({Key? key}) : super(key: key);

  @override
  _AjoutAbsence createState() => _AjoutAbsence();
}

class _AjoutAbsence extends State<AjoutAbsence> {
  List<TimeOfDay> De = [const TimeOfDay(hour: 8, minute: 30)];
  List<TimeOfDay> A = [const TimeOfDay(hour: 18, minute: 00)];
  DateTime? selectedDate = DateTime.now();
  DateTime? changedDate = DateTime.now();
  List<Appointment> meetings = <Appointment>[];

  //initialisation
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    setState(() {});
    List<String> morningTime = [];
    List<String> afternoonBeginTime = [];
    List<String> afternoonEndTime = [];
    for (int week = 1; week <= 52; week++) {
      SemaineService().postSemaine(Login.token, week).then((value) {
        for (int dayIndex = 0; dayIndex < 7; dayIndex++) {
          DateTime day = monday(week).add(Duration(days: dayIndex));
          if (value.workShedule.shedule[dayIndex].workDay == true) {
            morningTime = value.workShedule.shedule[dayIndex].time.morningToTime
                .split(":");
            afternoonBeginTime = value
                .workShedule.shedule[dayIndex].time.afternoonFromTime
                .split(":");
            afternoonEndTime = value
                .workShedule.shedule[dayIndex].time.afternoonToTime
                .split(":");
            if (value.workShedule.shedule[dayIndex].wholeDay == false) {
              meetings.add(Appointment(
                  startTime: DateTime(day.year, day.month, day.day,
                      int.parse(morningTime[0]), int.parse(morningTime[1]), 0),
                  endTime: DateTime(
                      day.year,
                      day.month,
                      day.day,
                      int.parse(afternoonBeginTime[0]),
                      int.parse(afternoonBeginTime[1]),
                      0),
                  color: const Color.fromARGB(255, 108, 122, 137),
                  isAllDay: false));
            }

            meetings.add(Appointment(
                startTime: DateTime(
                    day.year,
                    day.month,
                    day.day,
                    int.parse(afternoonEndTime[0]),
                    int.parse(afternoonEndTime[1]),
                    0),
                endTime: DateTime(day.year, day.month, day.day, 19, 0, 0),
                color: const Color.fromARGB(255, 108, 122, 137),
                isAllDay: false));
          } else {
            meetings.add(Appointment(
                startTime: DateTime(day.year, day.month, day.day, 8, 0, 0),
                endTime: DateTime(day.year, day.month, day.day, 19, 0, 0),
                color: const Color.fromARGB(255, 108, 122, 137),
                isAllDay: false));
          }
        }


      });
    }
    for (int month = 1; month <= 12; month++) {
      ReserveService()
          .postReserve(Login.token, "${DateTime.now().year}-$month-1", "month")
          .then((value) {
        if (value.rdv != []) {
          for (Rdv rdv in value.rdv) {
            if (rdv.etat != "Annulé") {
              if (rdv.type == "téléphonique") {
                meetings.add(Appointment(
                    startTime: rdv.start.add(const Duration(hours: 2)),
                    endTime: rdv.end.add(const Duration(hours: 2)),
                    color: const Color.fromARGB(255, 206, 235, 255),
                    isAllDay: false));
              }
              if (rdv.type == "visio") {
                meetings.add(Appointment(
                    startTime: rdv.start.add(const Duration(hours: 2)),
                    endTime: rdv.end.add(const Duration(hours: 2)),
                    color: const Color.fromARGB(255, 232, 207, 255),
                    isAllDay: false));
              }
              if (rdv.type == "physique") {
                meetings.add(Appointment(
                    startTime: rdv.start.add(const Duration(hours: 2)),
                    endTime: rdv.end.add(const Duration(hours: 2)),
                    color: const Color.fromARGB(255, 233, 251, 254),
                    isAllDay: false));
              }
            }
          }
        }
      });
    }
    return Scaffold(
        key: _scaffoldKey,
        drawer: const AppDrawer(),
        backgroundColor: const Color.fromARGB(250, 239, 239, 239),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: BlueBar(
            scaffoldKey: _scaffoldKey,
            name: "Ajout d'absence",
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Center(
                child: BlackButton(
              name: "OUVRIR MON CALENDRIER",
              onPressed: () {
                showModalBottomSheet<void>(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 545 + MediaQuery.of(context).size.height * 0.11,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 545,
                              child: FutureBuilder(
                                future: ReserveService().postReserve(
                                    Login.token,
                                    "${DateTime.now().year}-12-1",
                                    "month"),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState
                                          .waiting) //While waiting for response return this
                                  {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }

                                  return SfCalendar(
                                    view: CalendarView.week,
                                    firstDayOfWeek: 1,
                                    dataSource: MeetingDataSource(meetings),
                                    timeSlotViewSettings:
                                        const TimeSlotViewSettings(
                                      startHour: 8,
                                      endHour: 19,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 0, 8, 0),
                                              child: Container(
                                                height: 15,
                                                width: 30,
                                                decoration: const BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 108, 122, 137)),
                                              ),
                                            ),
                                            const Text(
                                              "Non disponible",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 0, 8, 0),
                                              child: Container(
                                                height: 15,
                                                width: 30,
                                                decoration: const BoxDecoration(
                                                    color: Colors.red),
                                              ),
                                            ),
                                            const Text(
                                              "Absent",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 0, 8, 0),
                                              child: Container(
                                                height: 15,
                                                width: 30,
                                                decoration: const BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 206, 235, 255)),
                                              ),
                                            ),
                                            const Text(
                                              "Téléphonique",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 48),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 0, 8, 0),
                                              child: Container(
                                                height: 15,
                                                width: 30,
                                                decoration: const BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 232, 207, 255)),
                                              ),
                                            ),
                                            const Text(
                                              "Visio",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 0, 8, 0),
                                              child: Container(
                                                height: 15,
                                                width: 30,
                                                decoration: const BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 233, 251, 254),
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              "Physique",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              },
              fontsize: 17,
            )),
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 40, 8, 16),
              child: Text(
                "Date",
                style: TextStyle(
                    fontFamily: 'Neometric',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Center(
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
                                    padding: EdgeInsets.fromLTRB(2, 40, 2, 0),
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
                                    setState(() {
                                      changedDate = selectedDate;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(2, 40, 2, 0),
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
                    fontFamily: 'Neometric', fontSize: 22, color: Colors.black),
              ),
            )),
            Center(
              child: Row(
                children: [
                  const SizedBox(width: 32),
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(8, 32, 8, 16),
                        child: Text(
                          "De",
                          style: TextStyle(
                              fontFamily: 'Neometric',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TimeButton(index: 0, timeList: De),
                    ],
                  ),
                  const SizedBox(width: 32),
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(8, 32, 8, 16),
                        child: Text(
                          "A",
                          style: TextStyle(
                              fontFamily: 'Neometric',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TimeButton(index: 0, timeList: A),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(48),
              child: BlackButton(
                  name: "AJOUTER",
                  onPressed: () {
                    AbsenceService()
                        .postAbsence(
                            Login.token,
                            DateFormat('yyyy-MM-dd').format(changedDate!),
                            stringTime(De[0]),
                            stringTime(A[0]))
                        .then((value) {
                      print(value.message);
                    });
                    setState(() {});
                  },
                  fontsize: 17),
            ),
          ],
        ));
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

  List<Appointment> getAppointments() {
    final List<Appointment> meetings = <Appointment>[];
    for (int week = 1; week <= 52; week++) {
      SemaineService().postSemaine(Login.token, week).then((value) {
        for (int dayIndex = 0; dayIndex < 7; dayIndex++) {
          if (value.workShedule.shedule[dayIndex].wholeDay == false) {
            DateTime day = monday(week).add(Duration(days: dayIndex));
            meetings.add(Appointment(
                startTime: DateTime(day.year, day.month, day.day, 12, 0, 0),
                endTime: DateTime(day.year, day.month, day.day, 14, 0, 0),
                color: Colors.red,
                isAllDay: false));
            // print(meetings.length);
          }
        }
      });
    }

    return meetings;
  }

  DateTime monday(int week) {
    var now = DateTime.now();

    var firstOfMonth = DateTime(now.year, 1, 1);
    var firstMonday = firstOfMonth.add(
        Duration(days: (7 - (firstOfMonth.weekday - DateTime.monday)) % 7));
    var Monday = firstMonday;

    Monday = Monday.add(Duration(days: 7 * week - 7));

    return Monday;
  }

  DateTime firstMonday() {
    var now = DateTime.now();

    var firstOfMonth = DateTime(now.year, 1, 1);
    var firstMonday = firstOfMonth.add(
        Duration(days: (7 - (firstOfMonth.weekday - DateTime.monday)) % 7));

    return firstMonday;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
