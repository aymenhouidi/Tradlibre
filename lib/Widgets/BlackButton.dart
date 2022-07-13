import 'package:flutter/material.dart';

class BlackButton extends StatelessWidget {
  final double fontsize;
  final String name;
  final onPressed;
  const BlackButton({
    required this.name,
    required this.onPressed,
    required this.fontsize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.fromLTRB(35, 13, 35, 8),
            primary: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              
          ),),
                        
          child:  Text(
            name,
            style: TextStyle(fontFamily: 'Neometric',fontSize: fontsize, color: Colors.white),
      ),);
  }
}