import 'package:flutter/material.dart';
import 'package:fe_flutter/login/buildTextFormField.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nicknameController = TextEditingController();
  final _sex = ['남자', '여자'];
  String? _selectedSex;
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordcheckController = TextEditingController();

  @override
  void dispose() {
  _nicknameController.dispose();
  _ageController.dispose();
  _emailController.dispose();
  _passwordcheckController.dispose();
  super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedSex = null;
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
        child: Padding(
          padding: EdgeInsets.only(top: 125),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children : <Widget>[
            Text(
              "회원가입",
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 30.0,
              ),
            ),
            SizedBox(height: 30.0,),
            Form(
                child: Column(
                  children: [
                    buildTextFormField(
                        controller: _nicknameController,
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
                        labelText: '나이',
                        hintText: '나이를 입력하세요'
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
                        hintText: '비밀번호를 입력하세요'
                    ),
                    SizedBox(height: 12.0,),
                    buildTextFormField(
                        controller: _passwordcheckController,
                        labelText: '비밀번호 확인',
                        hintText: '비밀번호를 한 번 더 입력하세요'),
                    SizedBox(height: 21.0,),
                    Container(
                      width: 300.0,
                      height: 30.0,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
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
    );
  }
}