import 'package:fe_flutter/service/refrigeServer.dart';
import 'package:flutter/material.dart';
import 'package:fe_flutter/model/refrigeModel.dart';

class DropdownRefrige extends StatefulWidget {
  @override
  DropdownRefrigeState createState() => DropdownRefrigeState();
}

class DropdownRefrigeState extends State<DropdownRefrige> {
  // 드랍다운 리스트에 들어갈 항목들
  static Future<RefrigeList> item = getRefrigeList();
  static List<String> items = ["기본 냉장고", "삼성"];
  // 선택된 항목을 저장할 변수 (기본값으로 '기본 냉장고'를 설정합니다)
  static String selectedItem = '기본 냉장고';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedItem,
              style: TextStyle(fontSize: 20),
            ),
            GestureDetector(
              onTap: (){
                _displayTextInputDialog(context);
              },
              child: Icon(Icons.note_alt_outlined),
            )

          ],
        ),
        DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(color: Color(0Xffffbc38), width: 1),
              borderRadius: BorderRadius.circular(10.0)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: DropdownButton<String>(
              value: selectedItem,
              onChanged: (String? newValue) {
                if(newValue == 'addRefrige'){
                  _showAddRefrigeDialog(context);
                }else {
                  setState(() {
                    selectedItem = newValue!;
                  });
                }

              },
                isExpanded: true,
                underline: SizedBox(),
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList()
                ..add(
                  DropdownMenuItem<String>(
                    value: 'addRefrige',
                    child: Text('+ 냉장고 추가'),
                  )
                )
            ),
          ),
        ),
      ],
    );
  }
}

void _showAddRefrigeDialog(BuildContext context) {
  TextEditingController _newRefrigeController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('냉장고 추가'),
        content: TextField(
          controller: _newRefrigeController,
          decoration: InputDecoration(hintText: '새로운 냉장고의 이름을 입력해주세요'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('취소'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('확인'),
            onPressed: () {
              Refrige refrige = Refrige(
                refrigeName: _newRefrigeController.text,
              );
              //print("$_newRefrigeController");
              createRefrige(refrige);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _displayTextInputDialog(BuildContext context) async {
  TextEditingController _textFieldController = TextEditingController();

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('냉장고 이름을 입력해주세요'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "여기에 텍스트를 입력하세요"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Refrige refrige = Refrige(
                  refrigeName: _textFieldController.text,
                );
                updateRefrigeName(refrige, 1);
                print('입력한 텍스트: ${_textFieldController.text}');
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
