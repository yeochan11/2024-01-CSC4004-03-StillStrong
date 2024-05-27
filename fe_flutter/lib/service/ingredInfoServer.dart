import 'package:fe_flutter/model/ingredientMoreInfoModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> fetchIngredientsInfo(int refrigeId, String ingredientName) async {
  String uri = 'http://localhost:8080/refrige/ingredient/$refrigeId?ingredientName=콩나물';

  final response = await http.get(Uri.parse(uri));
  if (response.statusCode == 200) {
    final decodeData = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> data = json.decode(decodeData);
    return data;
  } else {
    throw Exception('Failed to load data: ${response.statusCode}');
  }
}

Future<void> deleteIngredientInfo(int refrigeId, int ingredientId) async {
  String uri = 'http://localhost:8080/refrige/ingredient/delete/${refrigeId}/${ingredientId}'; //TODO: API 테스트시 이 주소를 이용해주세요.
  final response = await http.delete(Uri.parse(uri));
  if (response.statusCode == 200) {
    print('Delect Sucessful');
  } else {
    throw Exception('Failed to delete data');
  }
}

Future<void> patchIngredient(IngredientMoreInfoModel info, int refrigeId) async {
  print('${info.ingredientId}        ${refrigeId}');
  String uri = 'http://localhost:8080/refrige/ingredient/$refrigeId/${info.ingredientId}/edit'; //TODO: API 테스트시 이 주소를 이용해주세요.
  print(uri);

  final request = await http.patch(
    Uri.parse(uri),
    headers: <String, String>{
      'Content-Type': 'application/json'
    },
    body: jsonEncode(info.toJson()),
  );
  print('statusCode : ${request.statusCode}');
  if (request.statusCode == 200) {
    print('Patch successful');
  } else {
    throw Exception('Failed to patch data');
  }
}
