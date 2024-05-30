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
        FutureBuilder<RefrigeData>(
          future: itemsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('냉장고 목록을 불러오지 못했습니다.');
            } else if (snapshot.hasData) {
              List<String> refrigeNames = snapshot.data!.refrigeList!.map((refrige) => refrige.refrigeName!).toList();

              return DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0Xffffbc38), width: 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: DropdownButton<String>(
                    value: selectedItem,
                    onChanged: (String? newValue) {
                      if (newValue == 'addRefrige') {
                        _showAddRefrigeDialog(context);
                      } else {
                        setState(() {
                          selectedItem = newValue!;
                        });
                      }
                    },
                    isExpanded: true,
                    underline: SizedBox(),
                    items: refrigeNames.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()
                      ..add(
                        DropdownMenuItem<String>(
                          value: 'addRefrige',
                          child: Text('+ 냉장고 추가'),
                        ),
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
