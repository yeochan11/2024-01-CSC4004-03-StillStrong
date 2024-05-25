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

Future<Map<String,dynamic>> fetchIngredientsInfo() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1')); //테스트 주소

  if (response.statusCode == 200) {
    final Map<String,dynamic> data = json.decode(response.body);
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<void> deleteIngredientInfo() async {
  final response = await http.delete(Uri.parse('https://jsonplaceholder.typicode.com/posts/1')); // 테스트 주소
  if (response.statusCode == 200) {
    print('Delect Sucessful');
  } else {
    throw Exception('Failed to delete data');
  }
}

Future<void> patchIngredient(IngredientMoreInfoModel info) async {
  final response = await http.patch(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'), //테스트 주소
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, // TODO: API 주소 연결했으면 밑에 주석 해제,
      // body: jsonEncode(<String, dynamic>{
      //   // 'ingredientPlace' : ingredientPlace,
      //   // 'ingredientName' : ingredientName,
      //   // 'createDate' : createdDate,
      //   // 'ingredientDeadline' : ingredientDeadLine,
      //   // 'ingredientNum' : ingredientNum,
      //   'userId' : 5
      // })
      // TODO: 이건 주석 처리해주세요.
    body: jsonEncode(info.toJson())
  );
  print('statusCode : ${response.statusCode}');
  if (response.statusCode == 200) {
    print('Patch successful');
  } else {
    throw Exception('Failed to patch data');
  }
}