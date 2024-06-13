import 'package:fe_flutter/screens/mainPage.dart';
import 'package:fe_flutter/screens/myPage/myPage.dart';
import 'package:fe_flutter/screens/myRefrigerator.dart';
import 'package:flutter/material.dart';
import '../screens/MyRefrigerator/myRefrig.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({super.key});

  @override
  BottomMenuState createState() => BottomMenuState();
}

class BottomMenuState extends State<BottomMenu> {
  int _selectedIndex = 1;

  final List<Widget> _navIndex = [
    MyRefrigPage(),
    MainPage(),
    MyPage(),
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navIndex.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xffFFC94A),
        fixedColor: Colors.black,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.kitchen), label: 'MY 냉장고',),
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label:  '홈',),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이 페이지'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
      ),
    );
  }
}