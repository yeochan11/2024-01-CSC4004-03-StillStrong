import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fe_flutter/screens/login/buildTextFormField.dart';
import 'package:fe_flutter/service/userServer.dart';
import 'package:fe_flutter/model/userModel.dart';
import 'package:fe_flutter/provider/userProvider.dart';

class JoinPage extends StatefulWidget {
  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  bool? _selectedSex;
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordcheckController = TextEditingController();
  String password = "";
  String password_check = "";

  @override
  Widget build(BuildContext context) {
    return TextButtonTheme(
      data: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xffF6A90A),
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/yorijori.png',
            height: 30.0,
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children : <Widget>[
                    Text(
                      "회원가입",
                      style: TextStyle(
                        fontFamily: 'NotoSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                    SizedBox(height: 30.0,),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          buildTextFormField(
                            controller: _nicknameController,
                            keyboardType: TextInputType.text,
                            labelText: '닉네임',
                            hintText: '닉네임을 입력하세요'
                          ),
                          SizedBox(height: 10.0,),
                          Container(
                            width: 300.0,
                            height: 53.0,
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              isDense: true,
                              value: _selectedSex,
                              items: ['남자', '여자']
                                .map((e) => DropdownMenuItem(
                                value: e == '남자',
                                child: SizedBox(
                                  width: 300.0,
                                  //height: 46.0,
                                  child : Text(e),
                                  ),
                                  ))
                                .toList(),
                              hint: Text('성별', style:
                              TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff98A3B3),
                                ),
                              ),
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff98A3B3),
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xffF2F4F7),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                    color: const Color(0xffFFC94A),
                                  ),
                                ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 19.0)
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _selectedSex = value!;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return '성별을 선택해주세요.';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          buildTextFormField(
                              controller: _ageController,
                              keyboardType: TextInputType.number,
                              labelText: '나이',
                              hintText: '나이를 입력하세요',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '나이를 입력해주세요.';
                                }
                                else {
                                  try {
                                    int.parse(value);
                                    return null;
                                  } catch (e) {
                                    return '숫자 형식으로 입력해주세요.';
                                  }
                                }
                              },
                          ),
                          SizedBox(height: 10.0,),
                          buildTextFormField(
                              controller: _emailController,
                              labelText: '이메일',
                              hintText: '이메일을 입력하세요'
                          ),
                          SizedBox(height: 10.0,),
                          buildTextFormField(
                            controller: _passwordController,
                            labelText: '비밀번호',
                            hintText: '비밀번호를 입력하세요',
                            isPassword: true,
                          ),
                          SizedBox(height: 10.0,),
                          buildTextFormField(
                            controller: _passwordcheckController,
                            labelText: '비밀번호 확인',
                            hintText: '비밀번호를 한 번 더 입력하세요',
                            isPassword: true,
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return '비밀번호가 일치하지 않습니다.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 17.0,),
                          Container(
                            width: 300.0,
                            height: 30.0,
                            child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save(); // 입력값 가져오기
                                  int userAge = int.parse(_ageController.text); // 나이값 int로 변환
                                  // 유저 인스턴스 생성
                                  User user = User(
                                    secretEmail: _emailController.text,
                                    gender: _selectedSex,
                                    userNickname: _nicknameController.text,
                                    secretPassword: _passwordController.text,
                                    userAge: userAge,
                                  );
                                  join(user); // 회원가입 api 호출
                                  Provider.of<UserProvider>(context, listen: false).setUser(user); // 유저 정보 provider에 설정 (자동로그인)
                                  print('id : ${user.secretEmail}\npw : ${user.secretPassword}'); // 유저 정보 콘솔 출력 (확인용)
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: const Color(0xffF6A90A),
                                      content: Text('회원가입이 완료되었습니다. 자동 로그인됩니다.',
                                      style: TextStyle(
                                        fontFamily: 'Pretendard',
                                        fontSize: 13.0,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 2000),
                                    ),
                                  );
                                  Future.delayed(Duration(seconds: 1), () {
                                    Navigator.pushReplacementNamed(context, '/category');
                                  });
                                }
                              },
                              child: Text(
                                '가입하기',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Pretendard',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
              ),
              ),
            ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordcheckController.dispose();
    super.dispose();
  }
}