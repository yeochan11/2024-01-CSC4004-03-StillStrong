import 'package:flutter/material.dart';
import 'myRefrigeratorDropdown.dart';
import 'ingredientSearch.dart';

class MyRefrigerator extends StatelessWidget {
  const MyRefrigerator({super.key});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            leading: Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: 30,
            ),
            title: Text('MY 냉장고',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: true,
            backgroundColor: Color(0Xffffc94a),
          ),
          body: Container(
            child: Column(
              children: [
                Text('기본 냉장고'),
                DropdownExample(),
                IngredientSearch(),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0Xffffbc3b),
                        ),
                        child: Text('재료 선택', style: TextStyle(color: Colors.white),)
                    ),
                  ],
                ),
                SizedBox(
                  child: Row(
                    children: [
                      ImageCheckBox(),
                      ImageCheckBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.star), label: 'home'),
              BottomNavigationBarItem(icon: Icon(Icons.star), label: 'star'),
              BottomNavigationBarItem(icon: Icon(Icons.star), label: 'iiii'),
            ],
          )
        )
    );
  }
}

class ImageCheckBox extends StatefulWidget {
  @override
  _ImageCheckBoxState createState() => _ImageCheckBoxState();
}

class _ImageCheckBoxState extends State<ImageCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 202,
              width: 122,
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
            ),
            Image.asset(
              'images/welcomelogo.png',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              alignment: AlignmentDirectional.topCenter,
            ),
            if (isChecked)
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
          ],
        ),
      ),
    );
  }
}