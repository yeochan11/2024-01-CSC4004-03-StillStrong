import 'package:fe_flutter/model/ingredientMoreInfoModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fe_flutter/model/user_model.dart';

// 로그인 API 요청
Future<void> login(User user) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception("Failed to send data");
    } else {
      print("User Data sent successfully");
    }
  } catch(e) {
    print("Failed to send user data: &{e}");
  }
}

Future<Map<String,dynamic>> fetchIngredientsInfo(int refrigeId, String ingredientName) async {
  String uri = 'https://jsonplaceholder.typicode.com/posts/1'; // 테스트 주소
  //String uri = 'https://~~/refrige/ingredient/{refrigeId}?ingredientName={ingredientName}' //TODO: API 테스트시 이 주소를 이용해주세요.
  final response = await http.get(Uri.parse(uri));
  if (response.statusCode == 200) {
    final Map<String,dynamic> data = json.decode(response.body);
    return data;
  } else {
    throw Exception('Failed to load data');
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