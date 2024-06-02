import 'package:fe_flutter/service/refrigeServer.dart';
import 'package:flutter/material.dart';
import '../../model/refrigeModel.dart';
import 'myRefrigeratorDropdown.dart';
import 'ingredientSearch.dart';
import 'ingredientSelect.dart';
import '../ingredientMoreInfo/ingredientMoreInfo.dart';

class MyRefrigPage extends StatefulWidget {
  @override
  MyRefrigPageState createState() => MyRefrigPageState();
}

class MyRefrigPageState extends State<MyRefrigPage> {
  late Future<Map<String, dynamic>> itemsFuture;
  int currentRefrigeId = 7;
  List<String> newItems = ["기본 냉장고"]; // 기본값으로 초기화합니다.
  List<String> ingredients = [];
  List<Refrige> refrigeList = [];

  @override
  void initState() {
    super.initState();
    itemsFuture = getRefrigeList();
    itemsFuture.then((data) {
      RefrigeData refrigeData = RefrigeData.fromJson(data);
      setState(() {
        newItems = refrigeData.refrigeList.map((refrige) => refrige.refrigeName).toList();
        currentRefrigeId = refrigeData.refrigeList.first.refrigeId;
        ingredients = refrigeData.refrigeList
            .firstWhere((refrige) => refrige.refrigeId == currentRefrigeId)
            .ingredientNames;
      });
    });
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
        body: Container(
          child: Column(
            children: [
              DropdownRefrige(
                itemsFuture: itemsFuture,
                onChanged: (String selectedName, int selectedId) {
                  setState(() {
                    currentRefrigeId = selectedId;
                    ingredients = refrigeList
                        .firstWhere((refrige) => refrige.refrigeId == currentRefrigeId)
                        .ingredientNames;
                  });
                },
              ),
              IngredientSearch(),
              IngredientSelect(),
              Container(
                alignment: Alignment.center,
                width: 340,
                child: Column(
                  children: [
                    Wrap(
                      spacing: 4.0,
                      runSpacing: 4.0,
                      children: ingredients.map<Widget>((ingredient) {
                        return IngredIconButton(
                          buttonText: ingredient,
                          expDate: 16,
                          icon: Image.asset('assets/images/ingredient.png'),
                          onPressed: (isIngredientSelect, isPressed, buttonText) {
                            if (!isIngredientSelect) {
                              showInfo(currentRefrigeId, buttonText);
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
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
