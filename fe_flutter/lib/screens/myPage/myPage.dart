import 'package:flutter/material.dart';
import 'package:fe_flutter/service/userServer.dart';
import 'package:fe_flutter/model/userModel.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
  }

class _MyPageState extends State<MyPage> {
  //User? user;
  // 임시 유저 정보 생성. api 연결시 해제
  static User user = User(
    userId: 1,
    secretEmail: 'example.com',
    userNickname: '내꿈은요리사',
    userAge: 22,
    gender: true,
    userImage: 'https://cdn.pixabay.com/photo/2017/12/10/13/37/christmas-3009949_1280.jpg',
    alarm: true,
  );

  // 유저 정보 가져오는 함수
  @override
  void initState() {
    super.initState();
    print('user : $user');
    getUser();
  }

void getUser() async {
    User userinfo = await getUserInfo(); // 비동기로 유저 정보를 가져옴
    setState(() {
      user = userinfo; // 상태를 업데이트하여 UI가 변경됨
    });
    print('User info: $user'); // 테스트용 출력
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
                    '${user.userImage}',
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
                            labelText: '${user.userNickname}',
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
                            labelText: '${user.secretEmail}',
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
                                labelText: user.gender ?? false ? '남' : '여',
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
                                labelText: '${user.userAge}',
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
                          labelText: user.alarm ?? false ? 'O' : 'X',
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
