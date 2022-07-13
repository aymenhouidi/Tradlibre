import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  final String name;
  final pageName;
  const DrawerButton({
    required this.name,
    required this.pageName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  pageName),
                  );
                }, 
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Row(
        children: [
          const SizedBox(width:32,),
          Text(
            name,
            style: const TextStyle(fontFamily: 'Neometric',fontSize: 22, color: Colors.white),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    )
    );
  }
}