import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tradlibre/Model/absence.dart';



class AbsenceService {
  Future<Absence> postAbsence(String token, String date, String start, String end) async {
    final response = await http.post(
      Uri.parse("https://preprod.tradlibre.fr/api/interprete/absence/add"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({"token": token, "date": date, "start":start, "end":end}),
    );

    if (response.statusCode == 200) {
      return Absence.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed!');
    }
  }
}
