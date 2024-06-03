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
      final SharedPreferences pref = await SharedPreferences.getInstance();
      // 받은 데이터 저장
      int userId = responseData['userId'];
      String userNickname = responseData['userNickname'];
      String cookieValue = responseData['cookieValue'];
      pref.setInt("userId", userId);

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
Future<void> patchFavorites(Map<String, dynamic> favorite) async {
  try {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt("userId");
    final response = await http.patch(
      Uri.parse('http://localhost:8080/user/register/favorite?userId=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: json.encode(favorite),
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
    final response = await http.get(Uri.parse('http://localhost:8080/user/get/allergyList'));
    if (response.statusCode == 200) {
      final decodeData = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> data = jsonDecode(decodeData);
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
Future<void> patchAllergies(Map<String, dynamic> allergy) async {
  try {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt("userId");
    final response = await http.patch(
      Uri.parse('http://localhost:8080/user/register/allergy?userId=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: json.encode(allergy),
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

// 비밀번호 찾기
Future<void> findPw(User user) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:8080/find-pw'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      print('Data posted successfully');
    } else {
      print('Failed to post data: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Failed to post data: $e');
  }
}

// 비밀번호 재설정
Future<void> updatePw(String updatePassword, String confirmPassword) async {
  try {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt("userId");
    final Map<String, String> requestBody = {
      'updatePassword': updatePassword,
      'confirmPassword': confirmPassword,
    };

    final response = await http.post(
      Uri.parse('http://localhost:8080/update-pw?userId=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 200) {
      print('Password updated successfully.');
    } else {
      print('Failed to update password: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Failed to update password: $e');
  }
}

// 마이페이지 유저 정보 get
Future<User> getUserInfo() async {
  try {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt("userId");

    final response = await http.get(
      Uri.parse('http://localhost:8080/user/get/detail?userId=$userId'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return User.fromJson(jsonData);
    } else {
      throw Exception('Failed to get userinfo : ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to get userinfo: $e');
  }
}

Future<void> patchUser(User user) async {
  String uri = 'http://localhost:8080/user/update?userId=${user.userId}';
  print(uri);

  final request = await http.patch(
    Uri.parse(uri),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(user.toJsonForEdit()),
  );
  print('statusCode : ${request.statusCode}');
  if (request.statusCode == 200) {
    print('Patch successful');
  } else {
    throw Exception('Failed to patch data');
  }
}