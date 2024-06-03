import 'dart:convert';
import 'package:http/http.dart' as http;

// 사용자 검색
Future<Map<String, dynamic>> searchUser(String searchName) async {
  Map<String, dynamic> requestBody = {
    "serachName": searchName,
  };
  try {
    final response = await http.post(
      Uri.parse('http://localhost:8080/share/invite/search'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      // 받은 데이터 저장
      String searchUserImage = responseData['searchUserImage'];
      List<String> refrigeNames = responseData['refrigeNames'];
      List<int> refrigeIds = responseData['refrigeIds'];

      print('searchUserImage : ${searchUserImage}');
      print('refrigeNames : ${refrigeNames}');
      print('refrigeIds : ${refrigeIds}');

      return {
        'searchUserImage': searchUserImage,
        'refrigeNames': refrigeNames,
        'refrigeIds': refrigeIds,
      };

    } else {
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