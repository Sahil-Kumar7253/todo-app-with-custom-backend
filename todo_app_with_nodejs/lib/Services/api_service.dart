import 'dart:convert';

import 'package:http/http.dart' as http;
import '../url.dart';

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

  static Future<List<dynamic>> getTodo(token) async {
    final res = await http.get(
      Uri.parse(listTodo),
      headers: {
        "Content-Type": "application/json",
        "authorization": "Bearer $token",
      },
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data['todo'];
    } else {
      throw Exception('Failed to load todos');
    }
  }

  static Future<void> addInTodoList(String token, String title) async {
    await http.post(
      Uri.parse(addTodo),
      headers: {
        'Content-Type': 'application/json',
        "authorization": "Bearer $token",
      },
      body: jsonEncode({'title': title}),
    );
  }

  static Future<void> deleteTodo(String token, String id) async {
    await http.delete(
      Uri.parse(deleteTodoList + id),
      headers: {"authorization": "Bearer $token"},
    );
  }

  static Future<void> toggleTodo(String token, String id,bool completed) async {
    await http.patch(
      Uri.parse(updateTodoList + id),
      headers: {
        'Content-Type': 'application/json',
        "authorization": "Bearer $token",
      },
      body: jsonEncode({
        "completed": completed
      }),
    );
  }
}