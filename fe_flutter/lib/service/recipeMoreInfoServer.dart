import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String,dynamic>> fetchRecipeMoreInfo(String recipeName) async {
  String uri = 'http://3.35.140.200:8080/recommend/recipe/get/detail?recipeName=${recipeName}';
  final response = await http.get(Uri.parse(uri));
  if (response.statusCode == 200) {
    final decodeData = utf8.decode(response.bodyBytes);
    final Map<String,dynamic> data = json.decode(decodeData);
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<void> postRecipeFeedback(bool satisfied) async {
  Map<String,dynamic> data = {};
  data['feedback'] = satisfied;
  print(data);
  String uri = 'http://3.35.140.200:8080/recommend/recipe/feedback';
  final response = await http.post(Uri.parse(uri),
    headers: <String, String>{
    'Content-Type': 'application/json',
    },
    body: jsonEncode(data),
  );
  print(response.statusCode);
  if (response.statusCode == 200 || response.statusCode == 201) {
    print('Post completed');
  } else {
    throw Exception('Failed to post data');
  }
}