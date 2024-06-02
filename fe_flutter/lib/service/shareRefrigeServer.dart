import 'dart:convert';
import 'package:http/http.dart' as http;

// 사용자 검색
Future<void> searchUser(String searchName) async {
  final Uri url = Uri.parse('http://localhost:8080/share/invite/search');

  Map<String, dynamic> requestBody = {
    "serachName": searchName,
  };

  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);

      String searchUserImage = responseData['searchUserImage'];
      List<String> refrigeNames = responseData['refrigeNames'];
      List<int> refrigeIds = responseData['refrigeIds'];

    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
