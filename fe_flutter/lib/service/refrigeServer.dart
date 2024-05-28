import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fe_flutter/model/refrigeModel.dart';

Future<RefrigeList> getRefrigeList() async {
  try {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8080/refrige/get/refrigeList'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to send data");
    } else {
      return RefrigeList.fromJson(json.decode(response.body)['refrigeList']);
    }
  } catch(e, stackTrace) {
    print("Failed to send user data: $e");
    print(stackTrace);
    throw Exception('Failed to load refrige list');
  }
}

Future<void> createRefrige(Refrige refrige) async {
  try{
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8088/refrige/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(refrige.toJson()),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);

      int refrigeId = responseData['refrigeId'];
      String refrigeName = responseData['refrigeName'];
      print("regrigeId : $refrigeId");
      print("regrigeName : $refrigeName");
    } else {
      throw Exception("Failed to send data");
    }
  } catch(e) {
    print("Failed to send user data: $e");
  }
}

Future<void> updateRefrigeName(Refrige refrige) async {
  try{
    final response = await http.patch(
        Uri.parse('http://127.0.0.1:8088/refrige/update/${refrige.refrigeId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode(refrige.toJson()),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);

      int refrigeId = responseData['refrigeId'];
      String refrigeName = responseData['refrigeName'];
      print("regrigeId : $refrigeId");
      print("regrigeName : $refrigeName");
    } else {
      throw Exception("Failed to send data");
    }
  } catch(e) {
    print("Failed to send user data: $e");
  }
}
