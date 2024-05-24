import 'package:flutter/material.dart';
import 'package:fe_flutter/screens/ingredientRegister/ingredTextFormField.dart';

class IngredRegPage extends StatefulWidget {
  @override
  _IngredRegPageState createState() => _IngredRegPageState();
}

class _IngredRegPageState extends State<IngredRegPage> {
  int selectedButtonIndex = 0;
  final _formKey = GlobalKey<FormState>();
  final _ingredNameController = TextEditingController();
  final _ingredNumController = TextEditingController();
  final _ingredCreateDateController = TextEditingController();
  final _ingredExpDateController = TextEditingController();
  final _ingredMemoController = TextEditingController();
  String? _ingredName;

  List <String> _items = [
    '돼지고기', '양파', '계란', '사과'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('재료 등록',
            style: TextStyle(
              fontFamily: 'NotoSans',
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
              child: Column(
                children: <Widget> [
                  SizedBox(height: 32,),
                  Container(
                    child: Text('기본 냉장고',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    // 드롭다운 생략
                  ),
                  SizedBox(height: 80,),
                  Container(
                    width: 312,
                    height: 365,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffEEEEEE), width:2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container( // 재료 사진
                              width: 72,
                              height: 72,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 110,),
                            Row(
                              children: [
                                buildTextButton(0, '냉장'),
                                SizedBox(width: 8,),
                                buildTextButton(1, '냉동'),
                                SizedBox(width: 8,),
                                buildTextButton(2, '실온'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 18,),
                        /*SearchableListView(
                          items: _items,
                        ),*/
                        Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ingredTextFormField(
                                    controller: _ingredNameController,
                                    labelText: '상품명',
                                    hintText: '상품명 입력',
                                    inputType: InputType.text,
                                ),
                                SizedBox(height: 12,),
                                ingredTextFormField(
                                    controller: _ingredNumController,
                                    labelText: '수량',
                                    hintText: '수량 입력',
                                    inputType: InputType.number,
                                ),
                                SizedBox(height: 12,),
                                ingredTextFormField(
                                    controller: _ingredCreateDateController,
                                    labelText: '구매일',
                                    hintText: '구매일 입력',
                                    inputType: InputType.date,
                                ),
                                SizedBox(height: 12,),
                                ingredTextFormField(
                                    controller: _ingredExpDateController,
                                    labelText: '유통기한',
                                    hintText: '유통기한 입력',
                                    inputType: InputType.date,
                                ),
                                SizedBox(height: 12,),
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
                  SizedBox(height: 32,),
                  Container(
                    width: 312,
                    height: 36,
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: const Color(0xffF6A90A),
                              content: Text('재료 등록이 완료되었습니다.',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 13.0,
                                ),
                              ),
                              duration: Duration(milliseconds: 2000),
                            ),
                          );
                          Future.delayed(Duration(seconds: 1), () {
                            Navigator.pushReplacementNamed(context, '/myRefrig');
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
                      child: Text('재료 등록',
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
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          fixedSize: Size.fromWidth(26),
          splashFactory: NoSplash.splashFactory,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selectedButtonIndex == index ? const Color(0xffF7BF54) : const Color(0xffC4C4C4),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}