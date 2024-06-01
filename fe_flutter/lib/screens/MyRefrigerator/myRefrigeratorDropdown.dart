import 'package:flutter/material.dart';

class DropdownRefrige extends StatefulWidget {
  @override
  DropdownRefrigeState createState() => DropdownRefrigeState();
}

class DropdownRefrigeState extends State<DropdownRefrige> {
  // 드랍다운 리스트에 들어갈 항목들
  static List<String> items = ['기본 냉장고', '스마트 냉장고', '미니 냉장고', '양문형 냉장고', '상업용 냉장고'];
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
              style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(width: 8),
            GestureDetector(
              onTap: (){
                _displayTextInputDialog(context);
              },
              child: Icon(Icons.note_alt_outlined),
            )
          ],
        ),
        SizedBox(height: 20,),
        Container(
          width: 350,
          height: 40,
          child: DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0Xffffbc38), width: 1),
                borderRadius: BorderRadius.circular(10.0)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: DropdownButton<String>(
                value: selectedItem,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem = newValue!;
                  });
                },
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                isExpanded: true,
                underline: SizedBox(),
                iconEnabledColor: Color(0xffFFBC3B),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void _displayTextInputDialog(BuildContext context) async {
  TextEditingController _textFieldController = TextEditingController();

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('냉장고 이름을 입력해주세요',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          content: Container(
            width: 232,
            height: 35,
            padding: EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffC4C4C4), width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(
                hintText: "기본 냉장고",
                hintStyle: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffC4C4C4),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('확인',
                style: TextStyle(
                  color: Color(0xffF7BF54),
                  fontFamily: 'Pretendard',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                // DropdownRefrigeState.items[ = _textFieldController.text;
                print('입력한 텍스트: ${_textFieldController.text}');
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('취소',
                style: TextStyle(
                  color: Color(0xffF7BF54),
                  fontFamily: 'Pretendard',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  ),
                ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
}