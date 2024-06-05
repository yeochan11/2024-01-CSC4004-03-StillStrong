import 'package:fe_flutter/screens/MyRefrigerator/myRefrig.dart';
import 'package:fe_flutter/service/refrigeServer.dart';
import 'package:flutter/material.dart';
import 'package:fe_flutter/model/refrigeModel.dart';
class DropdownRefrige extends StatefulWidget {
  final Future<Map<String, dynamic>> itemsFuture;
  final Function(String, int) onChanged;

  DropdownRefrige({required this.itemsFuture, required this.onChanged});

  @override
  DropdownRefrigeState createState() => DropdownRefrigeState();
}

class DropdownRefrigeState extends State<DropdownRefrige> {
  late Future<Map<String, dynamic>> itemsFuture;
  String selectedItem = '기본 냉장고';
  int selectedRefrigeId = -1;
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    itemsFuture = widget.itemsFuture;
    itemsFuture.then((data) {
      RefrigeData refrigeData = RefrigeData.fromJson(data);
      setState(() {
        items = refrigeData.refrigeList.map((refrige) => refrige.refrigeName).toList();
        selectedItem = refrigeData.currentRefrigeName;
        selectedRefrigeId = refrigeData.refrigeList.firstWhere((refrige) => refrige.refrigeName == selectedItem).refrigeId;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: itemsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Text('냉장고 목록을 불러오지 못했습니다.');
        } else if (snapshot.hasData) {
          RefrigeData refrigeData = RefrigeData.fromJson(snapshot.data!);
          List<String> refrigeNames = refrigeData.refrigeList.map((refrige) => refrige.refrigeName).toList();

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
                    onTap: () {
                      _displayTextInputDialog(context);
                    },
                    child: Icon(Icons.note_alt_outlined),
                  )
                ],
              ),
              DecoratedBox(
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
                      } else if (newValue != null) {
                        setState(() {
                          selectedItem = newValue;
                          selectedRefrigeId = refrigeData.refrigeList.firstWhere((refrige) => refrige.refrigeName == selectedItem).refrigeId;
                        });
                        widget.onChanged(selectedItem, selectedRefrigeId);
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
              ),
            ],
          );
        } else {
          return const Text('데이터가 없습니다.');
        }
      },
    );
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
                  refrigeId: 0, // 임시 ID, 실제로는 서버에서 생성된 ID를 사용해야 합니다.
                  share: false,
                  ingredientNames: [], ingredientDeadlines: [],
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

    await showDialog(
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
                  refrigeId: selectedRefrigeId, // 실제 ID를 사용
                  share: false,
                  ingredientNames: [], ingredientDeadlines: [],
                );
                updateRefrigeName(refrige, selectedRefrigeId);
                setState(() {
                  selectedItem = _textFieldController.text;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}