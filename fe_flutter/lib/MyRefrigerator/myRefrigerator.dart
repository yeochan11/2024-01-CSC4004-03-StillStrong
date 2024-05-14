import 'package:flutter/material.dart';
import 'myRefrigeratorDropdown.dart';
import 'ingredientSearch.dart';
import 'ingredientSelect.dart';

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
                  DropdownRefrige(),
                  IngredientSearch(),
                  IngredientSelect(),
                  Row(
                    children: [
                      SizedBox(),
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
            floatingActionButton: Builder(
              builder: (context) => FloatingActionButton(
                  onPressed: () async {
                    final RenderBox button = context.findRenderObject() as RenderBox;
                    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
                    final RelativeRect position = RelativeRect.fromRect(
                      Rect.fromPoints(
                        button.localToGlobal(Offset.zero, ancestor: overlay),
                        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
                      ),
                      Offset.zero & overlay.size,
                    );
                    final selectedValue = await showMenu<int>(
                      context: context,
                      position: position,
                      items: [
                        PopupMenuItem<int>(
                          value: 1,
                          child: Text('재료 등록'),
                        ),
                        PopupMenuItem<int>(
                          value: 2,
                          child: Text('영수증 인식하기'),
                        ),
                        PopupMenuItem<int>(
                          value: 3,
                          child: Text('직접 입력하기'),
                        ),
                      ],
                    );

                    if(selectedValue != null){
                      switch (selectedValue){
                        case 1:
                          break;
                        case 2:
                          break;
                        case 3:
                          break;
                      }
                    }
                  },
                  shape: CircleBorder(),
                  child: Icon(Icons.add),
                  backgroundColor: Color(0Xffffc94a),
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


