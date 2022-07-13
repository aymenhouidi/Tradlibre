import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tradlibre/Model/changerSemaine.dart';

import '../Model/semaine.dart';


class ChangerSemaineService {
  Future<ChangerSemaine> postChangerSemaine(String token, int week, bool redundant, List<Shedule> shedule) async {
    final response = await http.post(
      Uri.parse("https://preprod.tradlibre.fr/api/horaire"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({"token": token, "week": week, "redundant":redundant, "shedule":shedule}),
    );

    if (response.statusCode == 200) {
      return ChangerSemaine.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed!');
    }
  }
}
