import 'package:flutter/material.dart';
import 'login/login.dart';
import 'login/join.dart';
import 'register/category.dart';
import 'register/allergy.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            toolbarHeight: 58.0,
            backgroundColor: Color(0xffFFC94A),
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
        ),
      ),
      routes: {
        '/login': (context) => LoginPage(),
        '/join': (context) => JoinPage(),
        '/register/category': (context) => CategoryPage(),
        '/register/allergy': (context) => AllergyPage(),
      },
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/register/category');
    });
    return Scaffold(
      backgroundColor: const Color(0xffFFC94A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/welcomelogo.png'),
                SizedBox(height: 20),
                Text("냉장고를 털고 싶을 땐?",
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                SizedBox(height: 3),
                Image.asset('assets/images/yorijori.png'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
