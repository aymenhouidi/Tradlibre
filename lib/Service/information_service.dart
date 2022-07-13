import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tradlibre/Model/information.dart';

import '../Model/login.dart';

class InformationService {
  Future<Information> postInformation(User user) async {
    final response = await http.post(
      Uri.parse("https://preprod.tradlibre.fr/api/interprete/update"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({"user": user}),
    );

    if (response.statusCode == 200) {
      return Information.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed!');
    }
  }
}
