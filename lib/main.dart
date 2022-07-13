import 'package:flutter/material.dart';
import 'Pages/LoginPage.dart';
import 'package:flutter/services.dart';
//preprod.tradlibre.fr

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
     SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);
  runApp(const TradlibreApp());}
 class TradlibreApp extends StatelessWidget {
  const TradlibreApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }


}


