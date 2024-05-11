import 'package:flutter/material.dart';

final List<String> selectedButtons = [];

class CustomIconButton extends StatefulWidget {
  final String buttonText;
  final Widget icon;
  final Function(bool, String) onPressed;

  CustomIconButton({
    required this.buttonText,
    required this.icon,
    required this.onPressed
  });

  @override
  _CustomIconButtonState createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
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
        print(selectedButtons);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 3),
        decoration: BoxDecoration(
          border: isPressed ? Border.all(
              color: const Color(0xffF6A90A), width: 1.5) : Border.all(
              color: Colors.transparent),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            widget.icon,
            Text(
              widget.buttonText,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


