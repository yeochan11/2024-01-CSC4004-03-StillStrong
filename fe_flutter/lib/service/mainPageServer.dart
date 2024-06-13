import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String,dynamic>> fetchMainPageData() async {
  String uri = 'http://3.35.140.200:8080/recommend/mainPage';
  final response = await http.get(Uri.parse(uri));
  if (response.statusCode == 200) {
    final decodeData = utf8.decode(response.bodyBytes);
    final Map<String,dynamic> data = json.decode(decodeData);
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}