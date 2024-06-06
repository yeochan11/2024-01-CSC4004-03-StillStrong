import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fe_flutter/model/searchedUserModel.dart';
import 'package:fe_flutter/model/shareRefrigeModel.dart';

// 사용자 검색
Future<SearchedUser> searchUser(String searchName) async {
  Map<String, String> requestBody = {
    "searchName": searchName,
  };
  try {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt("userId");
    final response = await http.post(
      Uri.parse('http://localhost:8080/share/invite/search?userId=${userId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 200) {
      final decodeData = utf8.decode(response.bodyBytes);
      Map<String, dynamic> data = jsonDecode(decodeData);
      return SearchedUser.fromJson(data);
    } else {
      print(response.statusCode);
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

// 공유 요청하기
Future<void> sharePost(int refrigeId, int createUserId, String requestUserNickname) async {
  Map<String, dynamic> requestBody = {
    "createUserId": createUserId,
    "requestUserNickname": requestUserNickname
  };

  try {
    final response = await http.post(
      Uri.parse('http://localhost:8080/share/invite/${refrigeId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print('냉장고 공유 요청 성공');
    } else {
      throw Exception('냉장고 공유 요청 실패 : $response.statusCode');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

// 공유 목록 get
Future<SharedList?> getSharedList() async {
  try {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt("userId");
    final response = await http.get(Uri.parse('http://localhost:8080/share/get/shareList?userId=${userId}'));

    if (response.statusCode == 200) {
      final decodeData = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> json = jsonDecode(decodeData);
      return SharedList.fromJson(json);
    } else {
      print('Failed to get shared list: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error get shared list: $e');
    return null;
  }
}

// 요청 취소
Future<void> cancelShare(SharedData data) async {
  try {
    int refrigeId = data.refrigeId;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt("userId");
    Map<String, dynamic> requestBody = {
      "createUserId": userId,
      "requestUserNickname": data.requestUserNickname,
    };
    http.Response response = await http.delete(
      Uri.parse('http://localhost:8080/share/cancel/${refrigeId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print("요청 취소 성공");
    } else {
      print("요청 취소 실패 : ${response.statusCode}");
    }
  } catch (e) {
    print('Error : $e');
  }
}

// 요청 수락 및 거절
Future<void> patchRequest(SharedData data, bool accept) async {
  try {
    int refrigeId = data.refrigeId;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt("userId");
    Map<String, dynamic> requestBody = {
      "requestUserId": userId,
      "accept": accept,
    };
    final response = await http.patch(
      Uri.parse('http://localhost:8080/share/accept/${refrigeId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: json.encode(requestBody),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('요청 처리 성공');
    } else {
      print('요청 처리 실패: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('error: $e');
  }
}