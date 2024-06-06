import 'package:fe_flutter/screens/login/buildTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fe_flutter/service/userServer.dart';
import 'package:fe_flutter/model/userModel.dart';
import 'package:fe_flutter/provider/userProvider.dart';

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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
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
                          fontFamily: 'NotoSans',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
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
                        fontFamily: 'NotoSans',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
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
                              _formKey.currentState!.save(); // 입력값 가져오기
                              // 유저 인스턴스 생성
                              User user = User(
                                secretEmail: _emailController.text,
                                secretPassword: _passwordController.text,
                              );
                              login(user).then((value) {
                                if (value != null) { // 로그인 성공
                                  Provider.of<UserProvider>(context, listen: false).setUser(user); // 유저 정보 provider에 설정
                                  print('id : ${user.secretEmail}\npw : ${user.secretPassword}'); // 유저 정보 콘솔 출력 (확인용)
                                  Navigator.pushNamed(context, '/BottomMenu');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: const Color(0xffF6A90A),
                                      content: Text('로그인에 실패했습니다. 다시 시도해주세요.'),
                                    ),
                                  );
                                }
                              });
                            }
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
                            width: 82.0,
                            height: 20.0,
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
                            width: 52.0,
                            height: 20.0,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/join');
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
                SizedBox(height: 45.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/snslogin.png',
                      height: 18.0,
                      width: 312.0,
                    ),
                    SizedBox(height: 38.0),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/googlelogin');
                      },
                      style: IconButton.styleFrom(
                        foregroundColor: const Color(0xffF6A90A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(7.0)
                          ),
                        ),
                      ),
                      icon: Image.asset(
                        'assets/images/googlelogin.png',
                        height: 35.0,
                        width: 236.0,
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/kakaologin');
                      },
                      style: IconButton.styleFrom(
                        foregroundColor: const Color(0xffF6A90A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(7.0)
                          ),
                        ),
                      ),
                      icon: Image.asset(
                        'assets/images/kakaologin.png',
                        height: 35.0,
                        width: 236.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
