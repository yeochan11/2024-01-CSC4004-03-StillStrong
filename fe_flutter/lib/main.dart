import 'package:flutter/material.dart';
import 'signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(),
      routes: {
        '/signup': (context) => SignupPage(),
      },
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 10), () {
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
                  Text("냉장고를 털고 싶을 땐?", style: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white)),
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
