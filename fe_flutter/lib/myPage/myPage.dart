import 'package:flutter/material.dart';

class MyPage extends StatelessWidget { //재료 상세 정보 페이지
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('마이 페이지'),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20,),
                Image.asset('assets/images/profileImage.png',
                  width: 122,
                  height: 122,
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
                          labelText: '내꿈은요리사',
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
                            labelText: 'example.com',
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
                                labelText: '남 여',
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
                                labelText: '20',
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
                            labelText: 'O X',
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
      ),
    );
  }
}