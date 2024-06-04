import 'package:flutter/material.dart';
import 'package:fe_flutter/screens/ingredientRegister/ingredientRegister.dart';
import 'package:fe_flutter/service/refrigeServer.dart';
import 'package:fe_flutter/model/refrigeModel.dart';
import '../ingredientMoreInfo/ingredientMoreInfo.dart';
import '../ingredientRegister/ingredientRegister.dart';
import 'myRefrigeratorDropdown.dart';
import 'ingredientSearch.dart';
import 'ingredientSelect.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MyRefrigPage extends StatefulWidget {
  @override
  MyRefrigPageState createState() => MyRefrigPageState();
}

class MyRefrigPageState extends State<MyRefrigPage> {

  late Future<Map<String, dynamic>> itemsFuture;
  static int currentRefrigeId = 7;
  List<String> newItems = ["기본 냉장고"]; // 기본값으로 초기화합니다.
  List<String> ingredients = [];
  static List<int> ingredientDeadlines = [];
  static List<Refrige> refrigeList = [];

  @override
  void initState() {
    super.initState();
    itemsFuture = getRefrigeList();
    itemsFuture.then((data) {
      RefrigeData refrigeData = RefrigeData.fromJson(data);
      setState(() {
        refrigeList = refrigeData.refrigeList;
        newItems = refrigeData.refrigeList.map((refrige) => refrige.refrigeName).toList();
        currentRefrigeId = refrigeData.refrigeList.first.refrigeId;
        var currentRefrige = refrigeData.refrigeList.firstWhere((refrige) => refrige.refrigeId == currentRefrigeId);
        ingredients = currentRefrige.ingredientNames;
        ingredientDeadlines = currentRefrige.ingredientDeadlines;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
/*
    <<<<<<< HEAD
    //List<dynamic> ingredients = refrigeList.map<String>((refrige) => refrige['ingredientNames'] as String).toList();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('MY 냉장고',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 20,
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
              IngredientWidget(),
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
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('재료 등록',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ),
                    enabled: false,
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            SizedBox(height: 8),
                            Text('영수증 인식하기',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )),
                  ),
                  PopupMenuItem<int>(
                    value: 3,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          SizedBox(height: 8,),
                          Text('직접 입력하기',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
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
=======*/
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: 30,
        ),
        title: Text(
          'MY 냉장고',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0Xffffc94a),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DropdownRefrige(
              itemsFuture: itemsFuture,
              onChanged: (String selectedName, int selectedId) {
                setState(() {
                  currentRefrigeId = selectedId;
                  var currentRefrige = refrigeList.firstWhere((refrige) => refrige.refrigeId == currentRefrigeId);
                  ingredients = currentRefrige.ingredientNames;
                  ingredientDeadlines = currentRefrige.ingredientDeadlines;
                  // 콘솔에 출력하여 확인
                  print('Selected Refrigerator ID: $currentRefrigeId');
                  print('Selected Refrigerator Name: $selectedName');
                  print('Ingredients: $ingredients');
                });
              },
            ),
            IngredientSearch(),
            IngredientWidget(),
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

            if (selectedValue != null) {
              switch (selectedValue) {
                case 1:
                  break;
                case 2:
                  break;
                case 3:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IngredRegPage(currentRefrigeId: currentRefrigeId),
                    ),
                  );
                  break;
              }
            }
          },
          shape: CircleBorder(),
          child: Icon(Icons.add),
          backgroundColor: Color(0Xffffc94a),
        ),
      ),
    );
  }

  void showPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('재료 등록'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text('영수증 인식'),
                  onTap: () {
                    // '영수증 인식'을 선택하면 다음 페이지로 이동
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('직접 입력하기'),
                  onTap: () {
                    // '직접 입력하기'를 선택하면 다음 페이지로 이동
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/IngredReg'
                    );
                  },
                ),
              ],
            ),
          );
        });
  }

  void showInfo(int refrigeId, String ingredientName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IngredientMoreInformation(
          refrigeId: refrigeId,
          ingredientName: ingredientName,
        ),
      ),
    );
  }
}

class IngredientWidget extends StatefulWidget {
  const IngredientWidget({super.key});

  @override
  State<IngredientWidget> createState() => _IngredientWidgetState();
}

class _IngredientWidgetState extends State<IngredientWidget> {
  bool isIngredientSelect = false;
  List<dynamic> ingredients = MyRefrigPageState.refrigeList.map<String>((refrige) => refrige.ingredientNames as String).toList();
  void toggleIngredientSelect() {
    setState(() {
      isIngredientSelect = !isIngredientSelect;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        IngredientSelect(onToggle: toggleIngredientSelect,),
        Container(
          alignment: Alignment.center,
          width: 340,
          child: Column(
            children: [
              Wrap(
                spacing: 4.0,
                runSpacing: 4.0,
                children: List.generate(ingredients.length, (index) {
                  // ingredientDeadlines와 길이가 같지 않은 경우에 대한 안전한 접근
                  int expDate = index < MyRefrigPageState.ingredientDeadlines.length ? MyRefrigPageState.ingredientDeadlines[index] : 0;
                  return IngredIconButton(
                    buttonText: ingredients[index],
                    expDate: expDate,
                    icon: Image.asset('assets/images/ingredient.png'),
                    onPressed: (isIngredientSelect, isPressed, buttonText) {
                      if (!isIngredientSelect) {
                        MyRefrigPageState instance = MyRefrigPageState();
                        instance.showInfo(MyRefrigPageState.currentRefrigeId, buttonText);
                      }
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        if(isIngredientSelect) RecommendRecipeButton(),
      ],
    );
  }
}