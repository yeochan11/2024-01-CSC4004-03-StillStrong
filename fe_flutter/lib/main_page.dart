import 'package:flutter/material.dart';
//임시 페이지입니다.
class MainPage extends StatelessWidget { //재료 상세 정보 페이지
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/yorijori.png', scale: 1.5),


      ),
      body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('메인 페이지'),
            ],
          )
      ),
    );
  }
}