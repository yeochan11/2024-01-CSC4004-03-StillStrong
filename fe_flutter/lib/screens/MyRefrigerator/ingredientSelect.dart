import 'package:flutter/material.dart';

class IngredientSelect extends StatefulWidget {
  const IngredientSelect({super.key});

  @override
  State<IngredientSelect> createState() => _IngredientSelectState();
}

class _IngredientSelectState extends State<IngredientSelect> {
  static bool isIngredientSelect = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
            onPressed:(){
              setState(() {
                isIngredientSelect = !isIngredientSelect;
                if(!isIngredientSelect){
                  _ImageCheckBoxState.isChecked = false;
                }
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0Xffffbc3b),
            ),
            child:
              Text('재료 선택', style: TextStyle(
                  color: isIngredientSelect ? Colors.black : Colors.white),
              )
        ),
        if (isIngredientSelect)
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0Xffffbc3b),
                  ),
                  child: Text('전체 취소', style: TextStyle(color: Colors.white),)
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0Xffffbc3b),
                  ),
                  child: Text('재료 삭제', style: TextStyle(color: Colors.white),)
              ),
            ],
          )
      ]
    );
  }
}

final List<String> selectedButtons = [];

class IngredIconButton extends StatefulWidget {
  final String buttonText;
  final int expDate;
  final Widget icon;
  final Function(bool, bool, String) onPressed;

  IngredIconButton({
    required this.buttonText, //재료 이름
    required this.expDate,
    required this.icon,
    required this.onPressed
  });

  @override
  _IngredIconButtonState createState() => _IngredIconButtonState();
}

class _IngredIconButtonState extends State<IngredIconButton> {
  bool isPressed = false;
  bool isIngredientSelect = false;
  final Map<String, bool> buttonStates = {};

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        isIngredientSelect = _IngredientSelectState.isIngredientSelect;
        setState(() {
          if(_IngredientSelectState.isIngredientSelect) {
            isPressed = !isPressed;
          }
          if (isPressed == true) {
            if (!selectedButtons.contains(widget.buttonText)) {
              selectedButtons.add(widget.buttonText);
            }
          } else {
            selectedButtons.remove(widget.buttonText);
          }
          buttonStates[widget.buttonText] = isPressed;
        });
        widget.onPressed(isIngredientSelect, isPressed, widget.buttonText);
        //print(selectedButtons);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 3),
        decoration: BoxDecoration(
          border: isPressed ? Border.all(
              color: const Color(0xffF6A90A), width: 1.5) : Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            widget.icon,
            Positioned(
              top: 9,
              left: 18,
              child:
              Text(
                'D+${widget.expDate}',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 90,
              child: Text(
                widget.buttonText,
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageCheckBox extends StatefulWidget {
  @override
  _ImageCheckBoxState createState() => _ImageCheckBoxState();
}

class _ImageCheckBoxState extends State<ImageCheckBox> {
  static bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if(_IngredientSelectState.isIngredientSelect) {
            isChecked = !isChecked;
          }
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
              'assets/images/welcomelogo.png',
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
