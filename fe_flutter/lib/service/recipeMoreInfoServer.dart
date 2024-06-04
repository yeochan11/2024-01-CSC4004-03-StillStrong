import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String,dynamic>> fetchRecipeMoreInfo(String recipeName) async {
   String uri = 'https://jsonplaceholder.typicode.com/posts/1'; // 테스트 주소
  //String uri = 'http://localhost:8080/recommend/recipe/get/detail?recipeName=${recipeName}'; //TODO: API 테스트시 이 주소를 이용해주세요.
  final response = await http.get(Uri.parse(uri));
  if (response.statusCode == 200) {
    final decodeData = utf8.decode(response.bodyBytes);
    final Map<String,dynamic> data = json.decode(decodeData);
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<Map<String,dynamic>> postRecipeFeedback(bool satisfied) async {
  Map<String,dynamic> data = {};
  data['feedback'] = satisfied;
  print(data);
  //String uri = 'https://jsonplaceholder.typicode.com/posts/';
  String uri = 'http://localhost:8080/recommend/recipe/feedback';
  final response = await http.post(Uri.parse(uri),
    headers: <String, String>{
    'Content-Type': 'application/json',
    },
    body: jsonEncode(data),
  );
  print(response.statusCode);
  if (response.statusCode == 200 || response.statusCode == 201) {
    final decodeData = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> data = json.decode(decodeData);
    return data;
  } else {
    throw Exception('Failed to post data');
  }
}