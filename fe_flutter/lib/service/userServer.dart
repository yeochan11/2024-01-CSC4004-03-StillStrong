import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fe_flutter/model/userModel.dart';

// 로그인
Future<void> login(User user) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:8080/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body); // response body JSON으로 디코딩

      // 받은 데이터 저장
      int userId = responseData['userId'];
      String cookieValue = responseData['cookieValue'];

      print('Received userId: $userId');
      print('Received cookieValue: $cookieValue');
    } else {
      throw Exception("Failed to send data");
    }
  } catch(e) {
    print("Failed to send user data: $e");
  }
}

// 회원가입
Future<void> join(User user) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:8080/join'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body); // response body JSON으로 디코딩

      // 받은 데이터 저장
      int userId = responseData['userId'];
      String userNickname = responseData['userNickname'];
      String cookieValue = responseData['cookieValue'];

      print('Received userId: $userId');
      print('Received userNickname: $userNickname');
      print('Received cookieValue: $cookieValue');
    } else {
      throw Exception("Failed to send data");
    }
  } catch(e) {
    print("Failed to send user data: $e");
  }
}

// 취향 등록
Future<void> registerFavorites(User user, String cookievalue) async {
  try {
    final response = await http.patch(
      Uri.parse('http://localhost:8080/user/register/favorite'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'cookievalue': cookievalue,
      },
      body: jsonEncode({user.toJson()}),
    );

    if (response.statusCode == 200) {
      print('Favorites updated successfully.');
    } else {
      print('Failed to update favorites: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Failed to update favorites: $e');
  }
}


