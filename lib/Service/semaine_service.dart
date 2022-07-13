import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tradlibre/Model/semaine.dart';

class SemaineService {
  Future<Semaine> postSemaine(String token, int week) async {
    final response = await http.post(
      Uri.parse("https://preprod.tradlibre.fr/api/horaire/show"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({"token": token, "week": week}),
    );

    if (response.statusCode == 200) {
      return Semaine.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed!');
    }
  }
}
