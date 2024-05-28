import 'package:flutter/material.dart';
import '../ingredientMoreInfo/ingredientMoreInfo.dart';
import 'myRefrigeratorDropdown.dart';
import 'ingredientSearch.dart';
import 'ingredientSelect.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MyRefrigPage extends StatefulWidget {
  @override
  _MyRefrigPageState createState() => _MyRefrigPageState();
}

class _MyRefrigPageState extends State<MyRefrigPage> {

  List<Map<String, dynamic>> refrigeList = [];
//TODO: 현재 선택 중인 냉장고 인덱스, 냉장고 드롭다운이랑 연결해서 값을 받을 수 있도록 수정 부탁드립니다.
  int currentRefrigeId = 1;
  @override
  void initState() {
    super.initState();
    fetchRefrigeList();
  }

  Future<void> fetchRefrigeList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt("userId");
    final url = 'http://localhost:8080/refrige/get/refrigeWithIngredients?userId=$userId';
    try {
      final response = await http.get(Uri.parse(url), headers: {"Accept": "application/json; charset=utf-8"});
      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        final data = json.decode(responseBody);
        setState(() {
          refrigeList = List<Map<String, dynamic>>.from(data['refrigeList'].map((item) => Map<String, dynamic>.from(item)));
          currentRefrigeId = data['currentRefrigeId'];
        });
        print(refrigeList);
        print(currentRefrigeId);
      } else {
        print('Failed to load refrige list');
      }
    } catch (e) {
      print(e.toString());
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: 30,
          ),
          title: Text('MY 냉장고',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0Xffffc94a),
        ),
        body: Container(
          child: Column(
            children: [
              DropdownRefrige(),
              IngredientSearch(),
              IngredientSelect(),
              Container(
                alignment: Alignment.center,
                width: 340,
                child: Column(
                  children: [
                    Row( //TODO: API로 냉장고 리스트 받아오면 currentRefrigeId를 읽고 재료만큼 버튼이 생성되게 수정 부탁드립니다.
                      children: [
                        IngredIconButton(
                          buttonText: '간장',
                          expDate: 16,
                          icon: Image.asset('assets/images/ingredient.png'),
                          //재료 상세 정보 페이지로 넘어가기.
                          onPressed: (isIngredientSelect, isPressed, buttonText) {
                            if (!isIngredientSelect) {
                              showInfo(1, buttonText);
                            }
                          },
                        ),
                        IngredIconButton(
                          buttonText: '사과',
                          expDate: 16,
                          icon: Image.asset('assets/images/ingredient.png'),
                          onPressed: (isIngredientSelect, isPressed, buttonText) {
                            if (!isIngredientSelect) {
                              showInfo(currentRefrigeId, buttonText);
                            }
                          },
                        ),
                        IngredIconButton(
                          buttonText: '오이',
                          expDate: 16,
                          icon: Image.asset('assets/images/ingredient.png'),
                          onPressed: (isIngredientSelect, isPressed, buttonText) {
                            if (!isIngredientSelect) {
                              showInfo(currentRefrigeId, buttonText);
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () async {
              final RenderBox button = context.findRenderObject() as RenderBox;
              final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
              final RelativeRect position = RelativeRect.fromRect(
                Rect.fromPoints(
                  button.localToGlobal(Offset.zero, ancestor: overlay),
                  button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
                ),
                Offset.zero & overlay.size,
              );
              final selectedValue = await showMenu<int>(
                context: context,
                position: position,
                items: [
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text('재료 등록'),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: Text('영수증 인식하기'),
                  ),
                  PopupMenuItem<int>(
                    value: 3,
                    child: Text('직접 입력하기'),
                  ),
                ],
              );

              if(selectedValue != null){
                switch (selectedValue){
                  case 1:
                    break;
                  case 2:
                    break;
                  case 3:
                    break;
                }
              }
            },
            shape: CircleBorder(),
            child: Icon(Icons.add),
            backgroundColor: Color(0Xffffc94a),
          ),
        ),

      ),
    );
  }
  void showInfo(int refrigeId, String ingredientName) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => IngredientMoreInformation(
          refrigeId: refrigeId,
          ingredientName: ingredientName,
        ))
    );
  }
}