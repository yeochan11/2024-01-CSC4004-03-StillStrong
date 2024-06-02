import 'package:fe_flutter/screens/MyRefrigerator/myRefrig.dart';
import 'package:fe_flutter/service/refrigeServer.dart';
import 'package:flutter/material.dart';
import 'package:fe_flutter/model/refrigeModel.dart';

class DropdownRefrige extends StatefulWidget {
  @override
  DropdownRefrigeState createState() => DropdownRefrigeState();
}

class DropdownRefrigeState extends State<DropdownRefrige> {
  late Future<RefrigeData> itemsFuture;
  String selectedItem = '기본 냉장고';

  @override
  void initState() {
    super.initState();
    itemsFuture = getRefrigeList();
    itemsFuture.then((data) {
      setState(() {
        selectedItem = data.currentRefrigeName;
      });
    });
  }
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
                  fontWeight: FontWeight.w600
              ),
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
        FutureBuilder<RefrigeData>(
          future: itemsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('냉장고 목록을 불러오지 못했습니다.');
            } else if (snapshot.hasData) {
              List<String> refrigeNames = snapshot.data!.refrigeList!.map((refrige) => refrige.refrigeName!).toList();

              return Container(
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
                      items: refrigeNames.map<DropdownMenuItem<String>>((String value) {
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
              );
            } else {
            return Text('데이터가 없습니다.');
            }
          },
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
      });
}
