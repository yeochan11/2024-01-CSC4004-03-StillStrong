import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fe_flutter/provider/userProvider.dart';

//임시 페이지입니다.
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user; // 유저 정보 불러오기
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset('assets/images/yorijori.png', scale: 1.5),

      ),
      body: Center(
          child: user != null ? // 유저값이 null이 아닐 경우 내용 표시
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('메인 페이지\n'
                    'Email : ${user.secretEmail}\n'
                    'Pw : ${user.secretPassword}\n'
                    'Favorites : ${user.userFavorites}\n'
                    'Allergies: ${user.userAllergies}'), // 유저 정보 출력 (확인용)
              ],
            )
              : null,
          ),
      );
  }
}