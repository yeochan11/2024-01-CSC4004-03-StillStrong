import 'package:flutter/material.dart';

final List<String> selectedButtons = [];

class IngredIconButton extends StatefulWidget {
  final String buttonText;
  final int expDate;
  final Widget icon;
  final Function(bool, String) onPressed;

  IngredIconButton({
    required this.buttonText,
    required this.expDate,
    required this.icon,
    required this.onPressed
  });

  @override
  _IngredIconButtonState createState() => _IngredIconButtonState();
}

class _IngredIconButtonState extends State<IngredIconButton> {
  bool isPressed = false;
  final Map<String, bool> buttonStates = {};

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isPressed = !isPressed;
          if (isPressed == true) {
            if (!selectedButtons.contains(widget.buttonText)) {
              selectedButtons.add(widget.buttonText);
            }
          } else {
            selectedButtons.remove(widget.buttonText);
          }
          buttonStates[widget.buttonText] = isPressed;
        });
        widget.onPressed(isPressed, widget.buttonText);
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


