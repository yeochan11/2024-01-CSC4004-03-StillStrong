import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fe_flutter/model/ingredientMoreInfoModel.dart';

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
Future<void> registerIngredient(IngredientMoreInfoModel ingredInfo) async {
  try {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt("userId");
    final response = await http.post(
      Uri.parse('http://localhost:8080//refrige/ingredient/register/{refrigeId}?userId=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(ingredInfo.toJson()),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body); // response body JSON으로 디코딩

      String ingredientName = responseData['ingredientName'];
      String ingredientNum = responseData['ingredientNum'];
      String createdDate = responseData['createdDate'];
      String ingredientMemo = responseData['ingredientMemo'];
      String ingredientPlace = responseData['ingredientPlace'];

    } else {
      print('Failed to register ingredient');
    }
  } catch (e) {
    print('Failed to register ingredient: $e');
  }
}