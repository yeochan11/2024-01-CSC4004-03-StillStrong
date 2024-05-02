import 'package:flutter/material.dart';
import 'package:fe_flutter/login/buildTextFormField.dart';

class JoinPage extends StatefulWidget {
  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _sex = ['남자', '여자'];
  String? _selectedSex;
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordcheckController = TextEditingController();
  String password = "";
  String password_check = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedSex = null;
    });
  }

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
              padding: EdgeInsets.only(top: 125.0),
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
                        SizedBox(height: 12.0,),
                        Container(
                          width: 300.0,
                          height: 55.0,
                          child: DropdownButtonFormField(
                            isExpanded: true,
                            isDense: true,
                            value: _selectedSex,
                            items: _sex
                              .map((e) => DropdownMenuItem(
                              value: e,
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
                            ),
                            onChanged: (value) {
                              setState(() {
                                _selectedSex = value!;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '성별을 선택해주세요';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 12.0,),
                        buildTextFormField(
                            controller: _ageController,
                            keyboardType: TextInputType.number,
                            labelText: '나이',
                            hintText: '나이를 입력하세요',
                            validator: (value) {
                              if (int.tryParse(value) == null) {
                                return '숫자 형식으로 입력해주세요.';
                              }
                              return null;
                            },
                        ),
                        SizedBox(height: 12.0,),
                        buildTextFormField(
                            controller: _emailController,
                            labelText: '이메일',
                            hintText: '이메일을 입력하세요'
                        ),
                        SizedBox(height: 12.0,),
                        buildTextFormField(
                          controller: _passwordController,
                          labelText: '비밀번호',
                          hintText: '비밀번호를 입력하세요',
                          isPassword: true,
                        ),
                        SizedBox(height: 12.0,),
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
                        SizedBox(height: 21.0,),
                        Container(
                          width: 300.0,
                          height: 30.0,
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: const Color(0xffF6A90A),
                                    content: Text('회원가입이 완료되었습니다.',
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 13.0,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 3000),
                                  ),
                                );
                                Future.delayed(Duration(seconds: 2), () {
                                  Navigator.pushReplacementNamed(context, '/register/category');
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