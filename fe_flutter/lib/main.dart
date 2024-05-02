import 'package:fe_flutter/MyRefrigerator/myRefrigerator.dart';
import 'package:flutter/material.dart';
import 'MyRefrigerator/myRefrigerator.dart';
//import 'signup.dart';

void main() {
  runApp(MyRefrigerator());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          toolbarHeight: 58.0,
          backgroundColor: const Color(0xffFFC94A),
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )
        ),
      ),
      routes: {
        //'/signup': (context) => SignupPage(),
      },
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context,'/signup');
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
                  Text("냉장고를 털고 싶을 땐?", style: TextStyle(fontFamily: 'Pretendard', fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
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
