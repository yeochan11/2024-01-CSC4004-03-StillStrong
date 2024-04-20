import 'package:fe_flutter/login/buildTextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 115),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/yorijori_black.png',
                    height: 40.0,
                  ),
                  Text(
                    " 에 오신 것을",
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 20.0,
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  "환영합니다!",
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  buildTextFormField(
                    controller: _emailController,
                    labelText: '이메일',
                    hintText: '이메일을 입력하세요',
                  ),
                  SizedBox(height: 12.0),
                  buildTextFormField(
                    controller: _passwordController,
                    labelText: '비밀번호',
                    hintText: '비밀번호를 입력하세요',
                    isPassword: true,
                  ),
                  SizedBox(height: 23.0),
                  Container(
                    width: 300.0,
                    height: 30.0,
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('로그인 중...'),
                            ),
                          );
                        }
                        // 회원가입 처리
                      },
                      child: Text(
                        '로그인',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Pretendard',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        height: 30.0,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/findpw');
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xffF6A90A),
                            backgroundColor: Colors.transparent,
                          ),
                          child: Text(
                            '비밀번호 찾기',
                            style: TextStyle(
                              color: const Color(0xffF6A90A),
                              fontFamily: 'Pretendard',
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ),
                      SizedBox(width: 58.0,),
                      Container(
                        width: 100.0,
                        height: 30.0,
                        child: TextButton(
                          onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xffF6A90A),
                            backgroundColor: Colors.transparent,
                          ),
                          child: Text(
                              '회원가입',
                              style: TextStyle(
                                color: const Color(0xffF6A90A),
                                fontFamily: 'Pretendard',
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              )
                            ),
                          ),
                      )
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(height: 59.0),
          ],
        ),
      ),
    );
  }
}
