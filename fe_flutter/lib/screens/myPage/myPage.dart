import 'package:flutter/material.dart';
import 'package:fe_flutter/service/userServer.dart';
import 'package:fe_flutter/model/userModel.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
  }

class _MyPageState extends State<MyPage> {
  //User? user;
  // TODO : 임시 유저 정보 생성. api 연결시 해제
  static User user = User(
    userId: 1,
    secretEmail: 'example.com',
    userNickname: '내꿈은요리사',
    userAge: 22,
    gender: true,
    userImage: 'https://lh4.googleusercontent.com/proxy/bQv_EtcQG0meeYE0BAKd83kzayElQTnqCxfAp0BRZef5NFYq9EhZdRlClAg0Myr-FVEdwQL3x4eNtvnRJoU7Suk2SuHLiGc_bhNCF2OrkBQ-Mu78ggZfvdxarEjxnnziV3bHCUq_13FG9uGooD5RX8UBEfAAElV8vr5OI958-5bOVQ',
    alarm: true,
  );

  // 유저 정보 가져오는 함수
  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    try {
      User userinfo = await getUserInfo();
      print('User info: $userinfo');
      setState(() {
        user = userinfo;
      });
    } catch (e) {
      print('Failed to get user info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('마이 페이지'),
      ),
      body: user == null ? _buildLoading() : _buildContent(),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20,),
                // 프로필 사진 표시
                ClipOval(
                  child: Image.network(
                    '${user!.userImage}',
                    width: 122,
                    height: 122,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                    width: 343,
                    height: 68,
                    color: const Color(0xffF2F4F7),
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('닉네임',textAlign: TextAlign.start,),
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: '${user!.userNickname}',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.symmetric(horizontal: 19.0),
                          ),
                        )
                      ],
                    )
                ),
                SizedBox(height: 8,),
                Container(
                    width: 343,
                    height: 68,
                    color: const Color(0xffF2F4F7),
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('이메일',textAlign: TextAlign.start,),
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: '${user!.secretEmail}',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.symmetric(horizontal: 19.0),
                          ),
                        )
                      ],
                    )
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 167,
                        height: 68,
                        color: const Color(0xffF2F4F7),
                        padding: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('성별',textAlign: TextAlign.start,),
                            TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: user!.gender ?? false ? '남' : '여',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                contentPadding: EdgeInsets.symmetric(horizontal: 19.0),
                              ),
                            )
                          ],
                        )
                    ),
                    SizedBox(width: 8,),
                    Container(
                        width: 167,
                        height: 68,
                        color: const Color(0xffF2F4F7),
                        padding: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('나이',textAlign: TextAlign.start,),
                            TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: '${user!.userAge}',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                contentPadding: EdgeInsets.symmetric(horizontal: 19.0),
                              ),
                            )
                          ],
                        )
                    )
                  ],
                ),
                SizedBox(height: 8,),
                Container(
                  width: 343,
                  height: 68,
                  color: const Color(0xffF2F4F7),
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('유통기한 알림 설정',textAlign: TextAlign.start,),
                      TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: user!.alarm ?? false ? 'O' : 'X',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: EdgeInsets.symmetric(horizontal: 19.0),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('알러지 정보 수정'),
                    ),
                    SizedBox(width: 8,),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/ShareRefrige');
                      },
                      child: Text('냉장고 공유하기'),
                    ),
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('회원정보 수정'),
                    ),
                    SizedBox(width: 8,),
                    TextButton(
                      onPressed: () {},
                      child: Text('로그아웃'),
                    ),
                  ],
                ),
              ],
            ),
          ),
      );
    }
  }
