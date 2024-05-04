import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomIconButton extends StatelessWidget {
  final String buttonText;
  final Widget icon;
  final VoidCallback onPressed;

  const CustomIconButton({
    required this.buttonText,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Column(
        children: [
          icon,
          Text(
            buttonText,
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 17.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      style: IconButton.styleFrom(
        foregroundColor: const Color(0xffF6A90A),
      ),
    );
  }
}

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final _categoryKey = GlobalKey<ScaffoldState>();
  final isSelected = List.generate(9, (index) => false);
  List<String> selectedCategory = [];

  @override
  void initState() {
    super.initState();
  }

  void toggleSelection(int index) {
    setState(() {
      isSelected[index] = !isSelected[index];
    });
  }

  void confirmSelection() {
    bool hasSelected = isSelected.contains(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/yorijori.png',
          height: 30.0,
        ),
        centerTitle: true,
      ),
      body: Center(
            child: Column(
              children: [
                SizedBox(height: 103.0,),
                Text('선호하는\n음식이 무엇인가요?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text('모두 선택해주세요!',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height:20.0),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget> [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              
                            });
                          },
                          child: CustomIconButton(
                              buttonText: '한식',
                              icon: Image.asset('assets/images/food/koreanfood.png', width: 80, height: 80,),
                              onPressed: () {},
                          ),
                        ),
                        SizedBox(width: 15.0),
                        CustomIconButton(
                          buttonText: '일식',
                          icon: Image.asset('assets/images/food/japanesefood.png', width: 80, height: 80,),
                          onPressed: () {},
                        ),
                        SizedBox(width: 15.0),
                        CustomIconButton(
                          buttonText: '중식',
                          icon: Image.asset('assets/images/food/chinesefood.png', width: 80, height: 80,),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget> [
                        CustomIconButton(
                          buttonText: '양식',
                          icon: Image.asset('assets/images/food/westernfood.png', width: 80, height: 80,),
                          onPressed: () {},
                        ),
                        SizedBox(width: 15.0),
                        CustomIconButton(
                          buttonText: '아시안',
                          icon: Image.asset('assets/images/food/asianfood.png', width: 80, height: 80,),
                          onPressed: () {},
                        ),
                        SizedBox(width: 15.0),
                        CustomIconButton(
                          buttonText: '찜•탕',
                          icon: Image.asset('assets/images/food/hotfood.png', width: 80, height: 80,),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget> [
                        CustomIconButton(
                          buttonText: '고기',
                          icon: Image.asset('assets/images/food/meat.png', width: 80, height: 80,),
                          onPressed: () {},
                        ),
                        SizedBox(width: 15.0),
                        CustomIconButton(
                          buttonText: '죽',
                          icon: Image.asset('assets/images/food/porridge.png', width: 80, height: 80,),
                          onPressed: () {},
                        ),
                        SizedBox(width: 15.0),
                        CustomIconButton(
                          buttonText: '채소',
                          icon: Image.asset('assets/images/food/salad.png', width: 80, height: 80,),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      width: 300.0,
                      height: 30.0,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/register/allergy');
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xffF6A90A),
                          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          '확인',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Pretendard',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/register/allergy');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('assets/images/noselection.png'),
                          SizedBox(width: 3),
                          Text('없어요',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Pretendard',
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 30),
                        ],
                      )
                  )
                  ],
                ),
            ],

          ),
        ),
    );
  }
}