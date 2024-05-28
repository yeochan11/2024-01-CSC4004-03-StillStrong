import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fe_flutter/model/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      final SharedPreferences pref = await SharedPreferences.getInstance();
      Map<String, dynamic> responseData = jsonDecode(response.body); // response body JSON으로 디코딩

      // 받은 데이터 저장
      int userId = responseData['userId'];
      String cookieValue = responseData['cookieValue'];
      pref.setInt("userId", userId);

      var object = pref.get("userId");

      print('Received userId: $object');
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
Future<void> patchFavorites(User user) async {
  try {
    final response = await http.patch(
      Uri.parse('http://localhost:8080/user/register/favorite'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
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

// 알러지 목록 get
Future<List<String>> getAllergies() async {
  try {
    final response = await http.get(Uri.parse('http://localhost:8080/user/register/favorite'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<String> allergies = List<String>.from(data['allergies']);
      return allergies;
    } else {
      throw Exception('Failed to get allergies : ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to get allergies: $e');
  }
}

// 알러지 등록
Future<void> patchAllergies(User user) async {
  try {
    final response = await http.patch(
      Uri.parse('http://localhost:8080/user/register/allergy'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode({user.toJson()}),
    );

    if (response.statusCode == 200) {
      print('Allergies updated successfully.');
    } else {
      print('Failed to update allergies: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Failed to update allergies: $e');
  }
}