import 'package:fe_flutter/model/ingredientMoreInfoModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


Future<Map<String, dynamic>> fetchIngredientsInfo(int refrigeId, String ingredientName) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  var userId = pref.getInt("userId") ?? 0; // 기본값을 설정

  String uri = 'http://localhost:8080/refrige/ingredient/$refrigeId?ingredientName=콩나물&userId=$userId';
  print(userId);

  final response = await http.get(Uri.parse(uri));
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    // ingredientNum 값이 null이 아닌 경우에만 사용
    int ingredientNum = data['ingredientNum'] ?? 0; // 기본값 0 설정
    data['ingredientNum'] = ingredientNum;
    return data;
  } else {
    throw Exception('Failed to load data: ${response.statusCode}');
  }
}


Future<void> deleteIngredientInfo(int refrigeId, int ingredientId) async {
  String uri = 'https://jsonplaceholder.typicode.com/posts/1'; // 테스트 주소
  //String uri = 'https://~~/refrige/ingredient/delete/{refrigeId}/{ingredientId}' //TODO: API 테스트시 이 주소를 이용해주세요.
  final response = await http.delete(Uri.parse(uri));
  if (response.statusCode == 200) {
    print('Delect Sucessful');
  } else {
    throw Exception('Failed to delete data');
  }
}

Future<void> patchIngredient(IngredientMoreInfoModel info, int refrigeId) async {
  String uri = 'https://jsonplaceholder.typicode.com/posts/1'; // 테스트 주소
  print('${info.ingredientId}        ${refrigeId}');
  //String uri = 'https://~~/refrige/ingredient/{info.refrigeId}/{info.ingredientId}/edit'; //TODO: API 테스트시 이 주소를 이용해주세요.
  final response = await http.patch(Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(info.toJson())
  );
  print('statusCode : ${response.statusCode}');
  if (response.statusCode == 200) {
    print('Patch successful');
  } else {
    throw Exception('Failed to patch data');
  }
}
