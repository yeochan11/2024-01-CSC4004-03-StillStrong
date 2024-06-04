import 'package:fe_flutter/provider/userProvider.dart';
import 'package:fe_flutter/widget/bottomMenu.dart';
import 'package:flutter/material.dart';
import 'package:fe_flutter/screens/MyRefrigerator/myRefrig.dart';
import 'package:provider/provider.dart';
import 'screens/ingredientMoreInfo/ingredientMoreInfo.dart';
import 'screens/login/login.dart';
import 'screens/login/join.dart';
import 'screens/login/findPw.dart';
import 'screens/login/updatePw.dart';
import 'screens/register/category.dart';
import 'screens/register/allergy.dart';
import 'screens/ingredientRegister/ingredientRegister.dart';
import 'screens/mainPage.dart';
import 'screens/MyRefrigerator/myRefrig.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
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
          '/findpw': (context) => FindPwPage(),
          '/updatepw': (context) => UpdatePwPage(),
          '/category': (context) => CategoryPage(),
          '/allergy': (context) => AllergyPage(),
          '/BottomMenu': (context) => BottomMenu(),
          //'/IngredReg': (context) => IngredRegPage(),
          '/Mainpage': (context) => MainPage(), //메인페이지 생기면
          //'/IngredientMoreInformation': (context) => IngredientMoreInformation(),
        },
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/login');
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