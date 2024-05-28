import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:fe_flutter/service/userServer.dart';
import 'package:fe_flutter/provider/userProvider.dart';

List<String> _selectedAllergy = [];

class AllergyPage extends StatefulWidget {
  @override
  _AllergyPageState createState() => _AllergyPageState();
}

class _AllergyPageState extends State<AllergyPage> {
  static List<String> _allergies = [];
  final List<MultiSelectItem<String>> _items = _allergies.map((String item) => MultiSelectItem(item, item)).toList();


  @override
  void initState() {
    super.initState();
    getAllergyList();
  }

  // 알러지 목록 가져오는 함수
  void getAllergyList() async {
      List<String> allergies = await getAllergies();
      setState(() {
        _allergies = allergies;
      });
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
                      onConfirm: (results) {
                        _selectedAllergy = results.cast<String>();
                      },
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
                        textStyle: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                        ),
                        onTap: (value) {
                          setState(() {
                            _selectedAllergy.remove(value);
                          });
                          //print(_selectedAllergy.map((allergy) => allergy.name).join(', '));
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
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 300.0,
                    height: 30.0,
                    child: TextButton(
                      onPressed: () {
                        if (_selectedAllergy.isNotEmpty) {
                          final user = Provider.of<UserProvider>(context, listen: false).user!; // user 정보 불러오기
                          patchAllergies(user); // 취향 등록 api
                          user.userFavorites = _selectedAllergy; // 선택한 취향 유저 정보에 삽입
                          print('userAllergies : ${user.userAllergies}'); // 선택한 취향 콘솔 출력 (확인용)
                          Navigator.pushReplacementNamed(context, '/BottomMenu');
                        } else {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('알림',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text('알러지를 선택해주세요!',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              backgroundColor: Colors.white,
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('확인',
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 15.0,
                                      color: const Color(0xffF6A90A),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
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
                            Navigator.pushReplacementNamed(context, '/BottomMenu');
                          });
                        },
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
