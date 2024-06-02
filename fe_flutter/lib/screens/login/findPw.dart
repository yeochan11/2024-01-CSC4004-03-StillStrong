import 'package:flutter/material.dart';
import 'package:fe_flutter/screens/login/buildTextFormField.dart';
import 'package:fe_flutter/service/userServer.dart';
import 'package:fe_flutter/model/userModel.dart';

class FindPwPage extends StatefulWidget {
  @override
  _FindPwPageState createState() => _FindPwPageState();
}

class _FindPwPageState extends State<FindPwPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nicknameController = TextEditingController();

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
                  Text('비밀번호 찾기',
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text('가입한 이메일과 닉네임을 입력해주세요.',
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
                            controller: _emailController,
                            labelText: '이메일',
                            hintText: '이메일을 입력하세요'
                        ),
                        SizedBox(height: 15,),
                        buildTextFormField(
                            controller: _nicknameController,
                            labelText: '닉네임',
                            hintText: '닉네임을 입력하세요'
                        ),
                        SizedBox(height: 23,),
                        Container(
                          width: 300,
                          height: 30,
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save(); // 입력값 가져오기
                                User user = User(
                                  secretEmail: _emailController.text,
                                  userNickname: _nicknameController.text,
                                );
                                findPw(user); // 사용자 인증 api
                                print('email: ${user.secretEmail}\n nickname: ${user.userNickname}');
                                Navigator.pushNamed(context, '/updatepw');
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