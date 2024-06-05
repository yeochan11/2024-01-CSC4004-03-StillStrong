import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fe_flutter/screens/ingredientRegister/ingredTextFormField.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fe_flutter/service/ingredRegServer.dart';
import 'package:fe_flutter/model/ingredRegModel.dart';

class IngredRegPage extends StatefulWidget {
  final int currentRefrigeId;

  IngredRegPage({required this.currentRefrigeId});

  @override
  _IngredRegPageState createState() => _IngredRegPageState();
}

class _IngredRegPageState extends State<IngredRegPage> {
  static List<String> _ingredients = [];
  int selectedButtonIndex = 0;
  String _ingredPlace = '냉장';
  final _formKey = GlobalKey<FormState>();
  final _ingredNameController = TextEditingController();
  final _ingredNumController = TextEditingController();
  final _ingredCreateDateController = TextEditingController();
  final _ingredExpDateController = TextEditingController();
  final _ingredMemoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    IngredientList();
  }

  // 재료 목록 가져오는 함수
  void IngredientList() async {
    List<String> ingredients = await getIngredientList();
    print('Ingredient list : $ingredients');
    setState(() {
      _ingredients = ingredients;
    });
  }

  @override
  void dispose() {
    _ingredNameController.dispose();
    _ingredNumController.dispose();
    _ingredCreateDateController.dispose();
    _ingredExpDateController.dispose();
    _ingredMemoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFC94A),
        title: Text(
          '재료 등록',
          style: TextStyle(
            fontFamily: 'NotoSans',
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 32),
            SizedBox(height: 55),
            Container(
              width: 312,
              height: 365,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffEEEEEE), width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // 재료 사진
                        width: 72,
                        height: 72,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 110),
                      Row(
                        children: [
                          buildTextButton(0, '냉장'),
                          SizedBox(width: 8),
                          buildTextButton(1, '냉동'),
                          SizedBox(width: 8),
                          buildTextButton(2, '실온'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 18),
                  SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            width: 280.0,
                            height: 36.0,
                            child: DropdownSearch<String>(
                              validator: (String? selectedItem) {
                                if (selectedItem == null || selectedItem.isEmpty) {
                                  return '상품명을 입력해주세요.';
                                }
                              },
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                showSelectedItems: true,
                                searchDelay: const Duration(seconds: 0),
                                searchFieldProps: TextFieldProps(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff98A3B3),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: '상품명 검색',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff98A3B3),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      borderSide: BorderSide(
                                          color: const Color(0xffEEEEEE), width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      borderSide: BorderSide(
                                          color: const Color(0xffEEEEEE), width: 2),
                                    ),
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 19.0),
                                  ),
                                ),
                              ),
                              items: _ingredients,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "상품명",
                                  labelStyle: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff98A3B3),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    borderSide: BorderSide(
                                        color: const Color(0xffEEEEEE), width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    borderSide: BorderSide(
                                        color: const Color(0xffEEEEEE), width: 2),
                                  ),
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 19.0),
                                ),
                              ),
                              onChanged: (String? selectedItem) {
                                _ingredNameController.text = selectedItem ?? '';
                              },
                            ),
                          ),
                          SizedBox(height: 12),
                          ingredTextFormField(
                            controller: _ingredNumController,
                            labelText: '수량',
                            hintText: '수량 입력',
                            inputType: InputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '수량을 입력해주세요.';
                              } else {
                                try {
                                  int.parse(value);
                                  return null;
                                } catch (e) {
                                  return '숫자 형식으로 입력해주세요.';
                                }
                              }
                            },
                          ),
                          SizedBox(height: 12),
                          ingredTextFormField(
                            controller: _ingredCreateDateController,
                            labelText: '구매일',
                            hintText: '구매일 입력',
                            inputType: InputType.date,
                            readOnly: true,
                            onTap: () async {
                              final DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime.now());
                              if (selectedDate != null) {
                                final formatter = DateFormat('yyyy-MM-dd');
                                final formattedDate = formatter.format(selectedDate);
                                setState(() {
                                  _ingredCreateDateController.text = formattedDate;
                                });
                              }
                            },
                          ),
                          SizedBox(height: 12),
                          ingredTextFormField(
                            controller: _ingredExpDateController,
                            labelText: '유통기한',
                            hintText: '유통기한 입력',
                            inputType: InputType.date,
                            readOnly: true,
                            onTap: () async {
                              final DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2025));
                              if (selectedDate != null) {
                                final formatter = DateFormat('yyyy-MM-dd');
                                final formattedDate = formatter.format(selectedDate);
                                setState(() {
                                  _ingredExpDateController.text = formattedDate;
                                });
                              }
                            },
                          ),
                          SizedBox(height: 12),
                          ingredTextFormField(
                            controller: _ingredMemoController,
                            labelText: '메모',
                            hintText: '메모 입력',
                            inputType: InputType.text,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: 312,
              height: 36,
              child: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save(); // 입력값 가져오기
                    // 재료 인스턴스 생성
                    IngredReg ingredReg = IngredReg(
                      ingredientName: _ingredNameController.text,
                      ingredientNum: int.parse(_ingredNumController.text),
                      createdDate: _ingredCreateDateController.text,
                      ingredientDeadLine: _ingredExpDateController.text,
                      ingredientMemo: _ingredMemoController.text,
                      ingredientPlace: _ingredPlace,
                    );
                    registerIngredient(ingredReg, widget.currentRefrigeId); // 재료 등록 api 호출
                    // 콘솔 출력(확인용)
                    print('name : ${ingredReg.ingredientName}\n'
                        'num : ${ingredReg.ingredientNum}\n'
                        'createDate : ${ingredReg.createdDate}\n'
                        'ExpDate : ${ingredReg.ingredientDeadLine}\n'
                        'memo : ${ingredReg.ingredientMemo}\n'
                        'place : ${ingredReg.ingredientPlace}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xffF6A90A),
                        content: Text(
                          '재료 등록이 완료되었습니다.',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 13.0,
                          ),
                        ),
                        duration: Duration(milliseconds: 2000),
                      ),
                    );
                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.pop(context);
                    });
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xffFFBC3B),
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                child: Text(
                  '재료 등록',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Pretendard',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextButton(int index, String text) {
    return Container(
      width: 26,
      child: TextButton(
        onPressed: () {
          setState(() {
            selectedButtonIndex = index;
          });
          switch (selectedButtonIndex) {
            case 0:
              _ingredPlace = '냉장';
              break;
            case 1:
              _ingredPlace = '냉동';
              break;
            case 2:
              _ingredPlace = '실온';
              break;
          }
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          fixedSize: Size.fromWidth(26),
          splashFactory: NoSplash.splashFactory,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selectedButtonIndex == index
                ? const Color(0xffF7BF54)
                : const Color(0xffC4C4C4),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
