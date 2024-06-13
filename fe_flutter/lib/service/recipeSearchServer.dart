import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String,dynamic>> fetchRecipeSearchData(String searching) async {
  String uri = 'http://3.35.140.200:8080/recommend/recipe/search?searching=${searching}';
  final response = await http.get(Uri.parse(uri));
  if (response.statusCode == 200) {
    final decodeData = utf8.decode(response.bodyBytes);
    final Map<String,dynamic> data = json.decode(decodeData);
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<Map<String,dynamic>> postRecipeFromIngredient(int userId, List<String> ingredientList) async {
  Map<String, dynamic> data = {};
  data['ingredientList'] = ingredientList;
  String uri = 'http://3.35.140.200:8080/recommend/recipe/ingredient';
  final response = await http.post(Uri.parse(uri),
    headers: <String, String>{
    'Content-Type': 'application/json; charset=utf-8',
  },
    body: jsonEncode(data),
  );
  if (response.statusCode == 200 || response.statusCode == 201) {
    final decodeData = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> data = json.decode(decodeData);
    return data;
  } else {
    throw Exception('Failed to post data');
  }
}