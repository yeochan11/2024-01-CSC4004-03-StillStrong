import 'package:http/http.dart' as http;
import 'dart:convert';

// 로그인 API 요청
Future<void> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/api/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
    },
    body: jsonEncode({
      'secretEmail': email,
      'secretPassword': password,
    }),
  );

  if (response.statusCode == 200) { // 서버로부터 데이터를 성공적으로 받았을 때의 처리
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    final userId = responseData['userId'] as int;
    final cookieValue = responseData['cookieValue'] as String;

    // 로그인 성공 처리
    print('로그인 성공! 사용자 ID: $userId, 쿠키 값: $cookieValue');
  } else {
    // 로그인 실패 처리
    print('로그인 실패: ${response.statusCode}');
  }
}
