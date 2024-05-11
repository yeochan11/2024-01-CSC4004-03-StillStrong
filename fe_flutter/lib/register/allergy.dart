import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AllergyPage extends StatefulWidget {
  @override
  _AllergyPageState createState() => _AllergyPageState();
}

class Allergy {
  final int id;
  final String name;

  Allergy({
    this.id = 0,
    this.name = '',
  });
}

class _AllergyPageState extends State<AllergyPage> {
  static List<Allergy> _allergy = [
    Allergy(id: 1, name: "난류"),
    Allergy(id: 2, name: "갑각류"),
    Allergy(id: 3, name: "돼지고기"),
    Allergy(id: 4, name: "땅콩"),
  ];
  final _items = _allergy
      .map((allergy) => MultiSelectItem<Allergy>(allergy, allergy.name))
      .toList();
  List<Allergy> _selectedAllergy = [];
  String? _currentItem;
  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    _selectedAllergy = _allergy;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/yorijori.png',
          height: 30.0,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 103.0),
            Text(
              '알러지가 있으신가요?',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '모두 선택해주세요!',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 46.0),
            Container(
              alignment: Alignment.center,
              width: 312.0,
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: MultiSelectDialogField(
                      items: _items,
                      itemsTextStyle: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 14,
                      ),
                      title: Text(
                        "알러지 선택",
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      selectedItemsTextStyle: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 14,
                      ),
                      searchable: true,
                      searchHint: '알러지 유발식품 검색',
                      searchHintStyle: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 14,
                      ),
                      chipDisplay: MultiSelectChipDisplay(
                        chipColor: const Color(0xffF2F4F7),
                        textStyle: TextStyle(color: Colors.white),
                        onTap: (value) {
                          setState(() {
                            _selectedAllergy.remove(value);
                          });
                        },
                      ),
                      selectedColor: const Color(0xffF6A90A),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        border: Border.all(
                          color: const Color(0xffF6A90A),
                          width: 1,
                        ),
                      ),
                      buttonIcon: Icon(
                        Icons.arrow_drop_down,
                        color: const Color(0xffF6A90A),
                      ),
                      buttonText: Text(
                        "알러지 유발식품 검색",
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          color: const Color(0xffC4C4C4),
                          fontSize: 14,
                        ),
                      ),
                      onConfirm: (results) {
                        _selectedAllergy = results.cast<Allergy>();
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 300.0,
                    height: 30.0,
                    child: TextButton(
                      onPressed: () {
                        if (_selectedAllergy.isNotEmpty) {
                          Navigator.pushReplacementNamed(context, '/main');
                        } else {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('알림'),
                              content: Text('알러지를 선택해주세요!'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('확인'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xffF6A90A),
                        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        '확인',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Pretendard',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 90,
                      height: 40,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedAllergy.clear();
                          });
                        },
                        style: ButtonStyle(
                          // add your custom style here
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/images/noselection.png'),
                            SizedBox(width: 3),
                            Text(
                              '없어요',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Pretendard',
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
