import 'package:flutter/material.dart';
//임시 페이지입니다.
class MyPage extends StatelessWidget { //재료 상세 정보 페이지
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('마이 페이지'),
      ),
      body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('마이 페이지',),
            ],
          )
      ),
    );
  }
}