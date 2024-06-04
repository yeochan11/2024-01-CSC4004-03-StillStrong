import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// 사용자 검색
Future<Map<String, dynamic>> searchUser(String searchName) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  int? userId = pref.getInt("userId");
  Map<String, dynamic> requestBody = {
    "searchName": searchName,
  };
  try {
    final response = await http.post(
      Uri.parse('http://localhost:8080/share/invite/search?userId=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      print(responseData);
      // 받은 데이터 저장
      String searchUserImage = responseData['searchedUserImage']??'https://lh4.googleusercontent.com/proxy/bQv_EtcQG0meeYE0BAKd83kzayElQTnqCxfAp0BRZef5NFYq9EhZdRlClAg0Myr-FVEdwQL3x4eNtvnRJoU7Suk2SuHLiGc_bhNCF2OrkBQ-Mu78ggZfvdxarEjxnnziV3bHCUq_13FG9uGooD5RX8UBEfAAElV8vr5OI958-5bOVQ';
      List<String> refrigeNames = responseData['refrigeNames'];
      List<int> refrigeIds = responseData['refrigeIds'];

      print('searchUserImage : ${searchUserImage}?');
      print('refrigeNames : ${refrigeNames}');
      print('refrigeIds : ${refrigeIds}');

      return {
        'searchUserImage': searchUserImage,
        'refrigeNames': refrigeNames.cast<List<String>>(),
        'refrigeIds': refrigeIds.cast<List<int>>(),
      };

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