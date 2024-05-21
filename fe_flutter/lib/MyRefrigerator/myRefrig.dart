import 'package:flutter/material.dart';
import 'myRefrigeratorDropdown.dart';
import 'ingredientSearch.dart';
import 'ingredientSelect.dart';

class MyRefrigPage extends StatefulWidget {
  @override
  _MyRefrigPageState createState() => _MyRefrigPageState();
}

class _MyRefrigPageState extends State<MyRefrigPage> {
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
                        Row(
                          children: [
                            IngredIconButton(
                                buttonText: '식빵',
                                expDate: 16,
                                icon: Image.asset('assets/images/ingredient.png'),
                                onPressed: (isPressed, buttonText) {},
                            ),
                            IngredIconButton(
                              buttonText: '식빵',
                              expDate: 16,
                              icon: Image.asset('assets/images/ingredient.png'),
                              onPressed: (isPressed, buttonText) {},
                            ),
                            IngredIconButton(
                              buttonText: '식빵',
                              expDate: 16,
                              icon: Image.asset('assets/images/ingredient.png'),
                              onPressed: (isPressed, buttonText) {},
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
 }