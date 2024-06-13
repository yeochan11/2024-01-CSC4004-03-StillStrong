import 'package:fe_flutter/model/ingredientMoreInfoModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> fetchIngredientsInfo(int refrigeId, String ingredientName) async {
  String uri = 'http://3.35.140.200:8080/refrige/ingredient/$refrigeId?ingredientName=$ingredientName';
  final response = await http.get(Uri.parse(uri));
  print(response.body);
  if (response.statusCode == 200) {
    final decodeData = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> data = json.decode(decodeData);
    return data;
  } else {
    throw Exception('Failed to load data: ${response.statusCode}');
  }
}

Future<void> deleteIngredientInfo(int refrigeId, int ingredientId) async {
  String uri = 'http://3.35.140.200:8080/refrige/ingredient/delete/${refrigeId}/${ingredientId}';
  final response = await http.delete(Uri.parse(uri));
  if (response.statusCode == 200) {
    print('Delect Sucessful');
  } else {
    throw Exception('Failed to delete data');
  }
}

Future<void> patchIngredient(IngredientMoreInfoModel info, int refrigeId) async {
  print('${info.ingredientId}        ${refrigeId}');
  String uri = 'http://3.35.140.200:8080/refrige/ingredient/$refrigeId/${info.ingredientId}/edit';
  print(uri);

  final request = await http.patch(
    Uri.parse(uri),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
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