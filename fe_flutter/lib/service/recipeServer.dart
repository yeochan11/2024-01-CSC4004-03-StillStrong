import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fe_flutter/model/recipeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<RecommendedRecipe> recommendByIngredient(List<String> ingredientList) async {
  try{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt("userId");
    var data = {
      'userId': userId,
      'ingredientList': ingredientList
    };
    final response = await http.post(
     Uri.parse('http://3.35.140.200:8080/recommend/recipe/ingredient'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(data),
    );

    if(response.statusCode == 200) {
      final decodeData = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseData= json.decode(decodeData);
      RecommendedRecipe recipe = RecommendedRecipe(
        recipeNames: List<String>.from(responseData['recipeNames']),
        recipeMainImages: List<String>.from(responseData['recipeMainImages']),
          recipeIngredients: (responseData['recipeIngredients'] as List)
              .map((item) => List<String>.from(item))
              .toList()
      );

      return recipe;
    } else {
      throw Exception("Failed to send data");
    }
  } catch(e) {
    print("Failed to send ingredient data: $e");
    RecommendedRecipe recipe = RecommendedRecipe();
    return recipe;
  }
}