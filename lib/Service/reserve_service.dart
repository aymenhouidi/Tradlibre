import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tradlibre/Model/reserve.dart';



class ReserveService {
  Future<Reserve> postReserve(
      String token, String date, String type) async {
    final response = await http.post(
      Uri.parse("https://preprod.tradlibre.fr/api/interprete/historique/rdv"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({"token": token, "date": date, "type": type}),
    );

    if (response.statusCode == 200) {
      return Reserve.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed!');
    }
  }
}
