import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fe_flutter/model/ingredRegModel.dart';

// 재료 목록 get
Future<List<String>> getIngredientList() async {
  try {
    final response = await http.get(
      Uri.parse('http://localhost:8080/refrige/ingredient/register'));
    if (response.statusCode == 200) {
      final decodeData = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> data = jsonDecode(decodeData);
      final List<String> ingredientList = List<String>.from(
          data['ingredientList']);
      return ingredientList;
    } else {
      throw Exception('Failed to get ingredient list : ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to get ingredient list: $e');
  }
}

// 재료 등록
Future<String> registerIngredient(IngredReg ingredReg) async {
    Map<String, dynamic> jsonData = ingredReg.toJson();
    final int refrigeId = 1; // TODO: refrigeId 설정
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt("userId");
    try {
      var response = await http.post(
        Uri.parse('/refrige/ingredient/register/$refrigeId?userId=$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body)['message']; // 응답 메시지 반환
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
