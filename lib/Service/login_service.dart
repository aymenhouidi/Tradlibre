import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/login.dart';

class LoginService {
  Future<Login> connect(String username, String password) async {
    final response = await http.post(
      Uri.parse("https://preprod.tradlibre.fr/api/user/connect"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({"_username": username, "_password": password}),
    );

    if (response.statusCode == 200) {
      {return Login.fromJson(jsonDecode(response.body));}
    } else {
      throw Exception('Failed to connect!');
    }
  }
}
