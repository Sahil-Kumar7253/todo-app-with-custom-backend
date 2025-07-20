import 'dart:convert';

import 'package:http/http.dart' as http;
import 'url.dart';

class ApiService{

  static Future<String> loginId(email,password) async {
    final res = await http.post(
      Uri.parse(login),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
    if(res.statusCode == 200){
      return jsonDecode(res.body)["token"];
    }
    return "";
  }
}