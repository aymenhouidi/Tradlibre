import 'package:flutter/material.dart';

Color? myColor=Colors.blue;
  alertBoxDetail(BuildContext context,String titre,String description, {String? detail}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding:const EdgeInsets.only(top: 10.0),
            content: SizedBox(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        titre,
                        style: const TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                    Padding(
                    padding:const EdgeInsets.all(20.0),
                    child: Text(description,textAlign: TextAlign.center,),
                  ),
              if(detail!=null)
              ExpansionTile(
                iconColor: Colors.red,
                title: const Text("More Details",style: TextStyle(color: Colors.red),),
                children: [ListTile(title: Text(detail,overflow: TextOverflow.clip,),)],
              ),
                  InkWell(
                    onTap: ()=>Navigator.of(context).pop(false),
                    child: Container(
                      padding:const EdgeInsets.only(top: 17.0, bottom: 17.0),
                      decoration: BoxDecoration(
                        color: myColor,
                        borderRadius:const BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child:const Text(
                        "OK",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }