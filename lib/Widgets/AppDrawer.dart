import 'package:flutter/material.dart';
import 'package:tradlibre/Pages/AjoutAbsencePage.dart';
import 'package:tradlibre/Pages/LoginPage.dart';
import '../Pages/InfoPage.dart';
import '../Pages/HorairePage.dart';
import '../Pages/ReservationPage.dart';
import 'DrawerButton.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color.fromARGB(222, 33, 165, 205), Color.fromARGB(255, 28, 122, 199)]),
        ),
        child: Stack(
          children:[ 
            Positioned(
              top:-12,
              left: MediaQuery.of(context).size.width-209,
              child: FlatButton(
                  onPressed: (){Navigator.of(context).pop();}, 
                  child: Image.asset("assets/menuClose.png", width: 85, height: 85),
                      ),
            ),
            Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.25,),
              const DrawerButton(name: "Horaires", pageName: Horaire()),
              const SizedBox(height: 8),
              const DrawerButton(name: "Ajout absence", pageName: AjoutAbsence()),
              const SizedBox(height: 8),
              const DrawerButton(name: "Mes reservations", pageName: Reservation()),
              const SizedBox(height: 8),
              const DrawerButton(name: "Mes infos", pageName: Infos()),
              const SizedBox(height: 32),
              const DrawerButton(name: "Deconnexion", pageName: Login()),
            ],
          ),
          ]
        ),
      ),
    );
  }
}