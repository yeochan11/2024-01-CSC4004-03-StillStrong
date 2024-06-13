import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fe_flutter/model/ingredRegModel.dart';

Future<List<String>> getIngredientList() async {
  try {
    final response = await http.get(
        Uri.parse('http://3.35.140.200:8080/refrige/ingredient/register'));
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

Future<String> registerIngredient(IngredReg ingredReg, int refrigeId) async {
  Map<String, dynamic> jsonData = ingredReg.toJson();
  final SharedPreferences pref = await SharedPreferences.getInstance();
  int? userId = pref.getInt("userId");
  try {
    var response = await http.post(
      Uri.parse('http://3.35.140.200:8080/refrige/ingredient/register/$refrigeId?userId=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(jsonData),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['message'];
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}