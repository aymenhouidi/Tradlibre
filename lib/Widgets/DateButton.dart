import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:intl/intl.dart';

class DateButton extends StatefulWidget {
  const DateButton({Key? key}) : super(key: key);
  
  static DateTime? selectedDate=DateTime.now();
  static DateTime? changedDate=DateTime.now();
  @override
  _DateButton createState() => _DateButton();
}
class _DateButton extends State<DateButton> {
	/*DateTime? selectedDate=DateTime.now();
  DateTime? changedDate=DateTime.now();*/

@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return ElevatedButton(
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
                                                DateButton.changedDate=DateButton.selectedDate;
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
                                      DatePickerWidget(
                                        looping: false,
                                        firstDate: DateTime(1922, 01, 01),
                                        lastDate: DateTime(2025, 12, 31),
                                        initialDate: DateButton.changedDate,
                                        dateFormat: "dd-MM-yyyy",
                                        locale: DatePicker.localeFromString('en'),
                                        onChange: (DateTime newDate, _){
                                          setState(() {
                                            DateButton.selectedDate = newDate;
                                            
                                          });
                                          
                                        }
                                        
                                      ),
                                    ],
                                  ),
                                
                                );
                              },
                            );
                            
                          
                        },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.fromLTRB(35, 13, 35, 8),
                              primary: Colors.white,
                              shape:  RoundedRectangleBorder(
                                borderRadius:  BorderRadius.circular(30.0),
                                
                            ),),
                                          
                            child:  Text(
                              DateFormat('dd/M/yyyy').format(DateButton.changedDate!),
                              style: const TextStyle(fontFamily: 'Neometric',fontSize: 22, color: Colors.black),
                        ),); 
  }
}