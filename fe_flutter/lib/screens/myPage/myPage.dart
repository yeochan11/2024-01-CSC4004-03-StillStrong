import 'package:fe_flutter/screens/myPage/myPageEdit.dart';
import 'package:flutter/material.dart';
import 'package:fe_flutter/service/userServer.dart';
import 'package:fe_flutter/model/userModel.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
  }

class _MyPageState extends State<MyPage> {
  //User? user;
  static User user = User(
    userId: "1",
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
                SizedBox(height: 60,),
                // 프로필 사진 표시
                ClipOval(
                  child: Image.network(
                    '${user!.userImage}',
                    width: 122,
                    height: 122,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                    width: 343,
                    height: 68,
                    padding: EdgeInsets.only(left: 16, top: 5),
                    decoration: BoxDecoration(
                        color: const Color(0xffF2F4F7),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('닉네임',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: '${user!.userNickname}',
                            labelStyle: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.zero,
                          ),
                        )
                      ],
                    )
                ),
                SizedBox(height: 16,),
                Container(
                    width: 343,
                    height: 68,
                    padding: EdgeInsets.only(left: 16, top: 5),
                    decoration: BoxDecoration(
                        color: const Color(0xffF2F4F7),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('이메일',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: '${user!.secretEmail}',
                            labelStyle: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.zero,
                          ),
                        )
                      ],
                    )
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 167,
                        height: 68,
                        padding: EdgeInsets.only(left: 16, top: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xffF2F4F7),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('성별',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: user!.gender ?? false ? '남' : '여',
                                labelStyle: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                contentPadding: EdgeInsets.zero,
                              ),
                            )
                          ],
                        )
                    ),
                    SizedBox(width: 9,),
                    Container(
                        width: 167,
                        height: 68,
                        padding: EdgeInsets.only(left: 16, top: 5),
                        decoration: BoxDecoration(
                            color: const Color(0xffF2F4F7),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('나이',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: '${user!.userAge}',
                                labelStyle: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                contentPadding: EdgeInsets.zero,
                              ),
                            )
                          ],
                        )
                    )
                  ],
                ),
                SizedBox(height: 16,),
                Container(
                  width: 343,
                  height: 68,
                  padding: EdgeInsets.only(left: 16, top: 5),
                  decoration: BoxDecoration(
                      color: const Color(0xffF2F4F7),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('유통기한 알림 설정',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: user!.alarm ?? false ? 'O' : 'X',
                          labelStyle: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 138,
                      height: 30,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xffF6A90A),
                          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text('알러지 정보 수정',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8,),
                    Container(
                      width: 138,
                      height: 30,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/ShareRefrige');
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xffF6A90A),
                          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text('냉장고 공유하기',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 138,
                      height: 30,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                                  MyPageEdit(user: user))
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text('회원정보수정',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),),
                      ),
                    ),
                    SizedBox(width: 8,),
                    Container(
                      width: 138,
                      height: 30,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text('로그아웃',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //SizedBox(height: 20,)
              ],
            ),
          ),
      );
    }
  }
