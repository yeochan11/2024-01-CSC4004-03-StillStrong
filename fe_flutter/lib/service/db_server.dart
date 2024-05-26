import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fe_flutter/model/user_model.dart';

// 로그인 API 요청
Future<void> login(User user) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception("Failed to send data");
    } else {
      print("User Data sent successfully");
    }
  } catch(e) {
    print("Failed to send user data: &{e}");
  }
}