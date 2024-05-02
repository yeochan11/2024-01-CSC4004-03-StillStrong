import 'package:flutter/material.dart';

class DropdownRefrige extends StatefulWidget {
  @override
  DropdownRefrigeState createState() => DropdownRefrigeState();
}

class DropdownRefrigeState extends State<DropdownRefrige> {
  // 드랍다운 리스트에 들어갈 항목들
  List<String> items = ['기본 냉장고', '스마트 냉장고', '미니 냉장고', '양문형 냉장고', '상업용 냉장고'];
  // 선택된 항목을 저장할 변수 (기본값으로 '기본 냉장고'를 설정합니다)
  String selectedItem = '기본 냉장고';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          selectedItem,
          style: TextStyle(fontSize: 20),
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
            ),
          ),
        ),
      ],
    );
  }
}