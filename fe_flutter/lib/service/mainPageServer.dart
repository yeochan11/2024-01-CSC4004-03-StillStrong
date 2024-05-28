import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String,dynamic>> fetchMainPageData() async {
  String uri = 'https://jsonplaceholder.typicode.com/posts/1'; // 테스트 주소
  //String uri = 'http//~~/mainpage' //TODO: API 테스트시 이 주소를 이용해주세요.
  final response = await http.get(Uri.parse(uri));
  if (response.statusCode == 200) {
    final Map<String,dynamic> data = json.decode(response.body);
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}