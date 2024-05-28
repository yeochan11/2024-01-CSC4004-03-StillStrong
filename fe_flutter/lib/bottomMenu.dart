import 'package:fe_flutter/screens/mainPage.dart';
import 'package:fe_flutter/screens/myPage.dart';
import 'package:fe_flutter/screens/myRefrigerator.dart';
import 'package:flutter/material.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({super.key});

  @override
  BottomMenuState createState() => BottomMenuState();
}

class BottomMenuState extends State<BottomMenu> {
  int _selectedIndex = 1;

  final List<Widget> _navIndex = [ //하단 바에서 선택할 페이지
    MyRefrigerator(),
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
        fixedColor: Colors.black, //선택한 아이콘 색상
        unselectedItemColor: Colors.white, //선택 안 된 아이콘 색상
        showUnselectedLabels: true, // 선택 안 된 아이콘 표시
        type: BottomNavigationBarType.fixed, // 하단 바 고정
        items: const [ // 하단 바에 표시될 아이콘
          BottomNavigationBarItem(icon: Icon(Icons.kitchen), label: 'MY 냉장고',), //index 0
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label:  '홈',), //index 1
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이 페이지'), //index 2
        ],
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
      ),
    );
  }
}