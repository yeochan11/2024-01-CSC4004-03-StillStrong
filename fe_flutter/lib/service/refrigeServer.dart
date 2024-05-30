import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fe_flutter/model/refrigeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Map<String, dynamic>> refrigeList = [];
// int currentRefrigeId = 1;
// List<String> newItems = ["기본 냉장고"]; // 기본값으로 초기화합니다.

Future<RefrigeData> getRefrigeList() async {
  try {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt("userId");
    final response = await http.get(
        Uri.parse('http://localhost:8080/refrige/get/refrigeWithIngredients?userId=$userId'),
        headers: {"Accept": "application/json; charset=utf-8"});
    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final data = json.decode(responseBody);
      RefrigeData refrigeData = RefrigeData.fromJson(data);
      return refrigeData;
    } else {
      print('냉장고 목록을 불러오는 데 실패했습니다');
      throw Exception("Failed to send data");
    }
  } catch (e, stackTrace) {
    print("Failed to send user data: $e");
    print(stackTrace);
    throw Exception('Failed to load refrige list');
  }
}


Future<void> createRefrige(Refrige refrige) async {
  try{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt("userId");
    final response = await http.post(
      Uri.parse('http://localhost:8080/refrige/create?userId=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(refrige.toJson()),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      int refrigeId = responseData['refrigeId'];
      String refrigeName = responseData['refrigeName'];
      print("regrigeId : $refrigeId");
      print("regrigeName : $refrigeName");
    } else {
      throw Exception("Failed to send data");
    }
  } catch(e) {
    print("Failed to send user data: $e");
  }
}

Future<void> updateRefrigeName(Refrige refrige, int refrigeId) async {
  try{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt("userId");
    final response = await http.patch(
        Uri.parse('http://localhost:8080/refrige/update/$refrigeId?userId=$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode(refrige.toJson()),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);

      int refrigeId = responseData['refrigeId'];
      String refrigeName = responseData['refrigeName'];
      print("regrigeId : $refrigeId");
      print("regrigeName : $refrigeName");
    } else {
      throw Exception("Failed to send data");
    }
  } catch(e) {
    print("Failed to send user data: $e");
  }
}
