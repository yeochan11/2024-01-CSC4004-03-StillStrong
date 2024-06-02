import 'package:flutter/material.dart';
import 'package:fe_flutter/screens/login/buildTextFormField.dart';
import 'package:fe_flutter/service/userServer.dart';

class UpdatePwPage extends StatefulWidget {
  @override
  _UpdatePwPageState createState() => _UpdatePwPageState();
}

class _UpdatePwPageState extends State<UpdatePwPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordcheckController = TextEditingController();
  String updatePassword = '';
  String confirmPassword = '';


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
            height: 30,
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('비밀번호 재설정',
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text('변경할 비밀번호를 입력해주세요.',
                    style: TextStyle(
                      fontFamily: 'Pretendart',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 23,),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildTextFormField(
                            controller: _passwordController,
                            labelText: '비밀번호',
                            hintText: '비밀번호를 입력하세요',
                            isPassword: true,
                        ),
                        SizedBox(height: 15,),
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
                        SizedBox(height: 23,),
                        Container(
                          width: 300,
                          height: 30,
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save(); // 입력값 가져오기
                                updatePassword = _passwordController.text;
                                confirmPassword = _passwordcheckController.text;
                                updatePw(updatePassword, confirmPassword); // 비밀번호 재설정 api
                                print('updatepw: ${updatePassword}');
                                Navigator.pushReplacementNamed(context, '/login');
                              };
                            },
                            child: Text(
                              '비밀번호 재설정',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Pretendard',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
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
}