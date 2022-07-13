import 'package:flutter/material.dart';
class BlueBar extends StatelessWidget {
  final String name;
  const BlueBar({
    Key? key,
    required this.name,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey, super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AppBar(
        automaticallyImplyLeading: false,
        title:  Padding(
          padding: const EdgeInsets.fromLTRB(2, 15, 2, 5),
          child: Text(
            name,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromARGB(237, 45, 191, 236),
                  Color.fromARGB(255, 28, 122, 199)
                ]),
          ),
        ),
      ),
      Positioned(
        top: -10,
        left: MediaQuery.of(context).size.width - 100,
        child: FlatButton(
          onPressed: () {
            
            _scaffoldKey.currentState!.openDrawer();
          },
          child: Image.asset("assets/menu.png", width: 85, height: 85),
        ),
      ),
    ]);
  }
}