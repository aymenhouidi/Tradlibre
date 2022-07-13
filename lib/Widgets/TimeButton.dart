import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class TimeButton extends StatefulWidget {
  final int index;
  final List<TimeOfDay> timeList;
  const TimeButton({
    Key? key,
    required this.index,
    required this.timeList,
  }) : super(key: key);
  
  @override
  _TimeButton createState() => _TimeButton();
}
class _TimeButton extends State<TimeButton> {
	late TimeOfDay auxTime;
  DateTime now=DateTime.now();
@override
  void initState() {
    super.initState();
    
  }
  
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return ElevatedButton(onPressed: (){
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
                                              onTap: (){Navigator.pop(context);}, 
                                              child: const Padding(
                                                padding: EdgeInsets.fromLTRB(2,40,2,0),
                                                child: Text(
                                                  "ANNULER",
                                                  style: TextStyle(fontFamily: 'Neometric',fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                                                ),
                                              )
                                              ),
                                              const SizedBox(width: 32),
                                            GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  widget.timeList[widget.index]=auxTime;
                                                });
                                                Navigator.pop(context);
                                              }, 
                                              child: const Padding(
                                                padding: EdgeInsets.fromLTRB(2,40,2,0),
                                                child: Text(
                                                  "OK",
                                                  style: TextStyle(fontFamily: 'Neometric',fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                                                ),
                                              )
                                              ),
                                              const SizedBox(width: 16),
                                          ],
                                        ),
                                        TimePickerSpinner(
                                          time: DateTime(now.year, now.month, now.day, widget.timeList[widget.index].hour, widget.timeList[widget.index].minute),
                                          normalTextStyle: const TextStyle(
                                            fontSize: 24,
                                            color: Colors.black
                                          ),
                                          highlightedTextStyle: const TextStyle(
                                            fontSize: 24,
                                            color: Colors.blue
                                          ),
                                          spacing: 50,
                                          itemHeight: 80,
                                          isForce2Digits: true,
                                          
                                          onTimeChange: (time) {
                                            setState(() {
                                              auxTime=TimeOfDay(hour: time.hour, minute: time.minute);
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  
                                  );
                                },
                              );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(20, 13, 27, 8),
                            primary: Colors.white,
                            shape:  RoundedRectangleBorder(
                              borderRadius:  BorderRadius.circular(30.0),
                            ),),
                          child: Row(
                            children: [
                              Text( hour()! +":"+minute()!, style: const TextStyle(color: Colors.black, fontSize: 20),),
                              const SizedBox(width: 40),
                              Image.asset("assets/clock.png", width: 20, height: 20),
                            ],
                          ));
  }
  String? hour (){
    return widget.timeList[widget.index].hour.toString().length==1 ? "0"+widget.timeList[widget.index].hour.toString() : widget.timeList[widget.index].hour.toString();
  }
  String? minute (){
    return widget.timeList[widget.index].minute.toString().length==1 ? "0"+widget.timeList[widget.index].minute.toString() : widget.timeList[widget.index].minute.toString();
  }
  }
