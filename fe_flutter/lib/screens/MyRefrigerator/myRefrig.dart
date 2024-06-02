import 'package:fe_flutter/service/refrigeServer.dart';
import 'package:flutter/material.dart';
import 'myRefrigeratorDropdown.dart';
import 'ingredientSearch.dart';
import 'ingredientSelect.dart';
import '../ingredientMoreInfo/ingredientMoreInfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MyRefrigPage extends StatefulWidget {
  @override
  MyRefrigPageState createState() => MyRefrigPageState();
}

class MyRefrigPageState extends State<MyRefrigPage> {
  List<Map<String, dynamic>> refrigeList = [];
  int currentRefrigeId = 1;
  List<String> newItems = ["기본 냉장고"]; // 기본값으로 초기화합니다.

  @override
  void initState() {
    super.initState();
    //fetchRefrigeList();
  }

  // Future<void> fetchRefrigeList() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   int? userId = pref.getInt("userId");
  //   final url =
  //       'http://localhost:8080/refrige/get/refrigeWithIngredients?userId=$userId';
  //   try {
  //     final response = await http.get(Uri.parse(url),
  //         headers: {"Accept": "application/json; charset=utf-8"});
  //     if (response.statusCode == 200) {
  //       final responseBody = utf8.decode(response.bodyBytes);
  //       final data = json.decode(responseBody);
  //       setState(() {
  //         refrigeList = List<Map<String, dynamic>>.from(
  //             data['refrigeList'].map((item) => Map<String, dynamic>.from(item)));
  //         currentRefrigeId = data['currentRefrigeId'];
  //         // 냉장고 이름으로 드롭다운 목록 항목을 채웁니다.
  //         newItems = refrigeList.map<String>((refrige) => refrige['refrigeName'] as String).toList();
  //         // DropdownRefrigeState의 인스턴스를 얻어와서 items를 업데이트합니다.
  //         DropdownRefrigeState dropdownRefrigeState = context.findAncestorStateOfType<DropdownRefrigeState>()!;
  //         dropdownRefrigeState.updateItems(newItems);
  //         print(newItems);
  //       });
  //       print(refrigeList);
  //       print(currentRefrigeId);
  //     } else {
  //       print('냉장고 목록을 불러오는 데 실패했습니다');
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    List<dynamic> ingredients = refrigeList.map<String>((refrige) => refrige['ingredientNames'] as String).toList();

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
                      children:
                        ingredients.map((ingredient){
                          return IngredIconButton(
                              buttonText: ingredient['ingredientNames'],
                              expDate: 16,
                              icon: Image.asset('assets/images/ingredient.png'),
                              onPressed: (isIngredientSelect, isPressed, buttonText) {
                                if (!isIngredientSelect) {
                                  showInfo(currentRefrigeId, buttonText);
                                }
                              },
                            );
                          }).toList(),
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
                    child: Text('영수증 인식하기'),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
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