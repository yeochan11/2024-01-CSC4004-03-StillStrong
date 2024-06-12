import 'package:flutter/material.dart';

import 'package:fe_flutter/service/recipeServer.dart';
import 'package:fe_flutter/model/recipeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ingredientMoreInfo/ingredientMoreInfo.dart';
import '../MyRefrigerator/ingredIconButton.dart';
import '../recipeSearch/recipeFromIngredient.dart';

class IngredientSelect extends StatefulWidget {
  final Function onToggle;
  const IngredientSelect({super.key, required this.onToggle});

  @override
  State<IngredientSelect> createState() => _IngredientSelectState();
}

class _IngredientSelectState extends State<IngredientSelect> {
  static bool isIngredientSelect = false;

  void clearAllSelection(){
    setState(() {
      _IngredIconButtonState.buttonStates.updateAll((key, value) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
              onPressed:(){
                setState(() {
                  isIngredientSelect = !isIngredientSelect;
                });
                widget.onToggle();
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
                    onPressed: () {
                      setState(() {
                        //TODO : FIX 전체취소
                        selectedButtons.clear();
                        clearAllSelection();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0Xffffbc3b),
                    ),
                    child: Text('전체 취소', style: TextStyle(color: Colors.white),)
                ),
                ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0Xffffbc3b),
                    ),
                    child: Text('재료 삭제', style: TextStyle(color: Colors.white),)
                ),
              ],
            ),
        ]
    );
  }
}



class RecommendRecipeButton extends StatefulWidget {
  final Function(List<String> selectedButtons) onPressed;
  const RecommendRecipeButton({required this.onPressed});

  @override
  State<RecommendRecipeButton> createState() => _RecommendRecipeButtonState();
}

class _RecommendRecipeButtonState extends State<RecommendRecipeButton> {

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 142,
        height: 45,
        child: ElevatedButton(
            onPressed: () async {
              widget.onPressed(selectedButtons);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffffbc3b),
              padding: EdgeInsets.zero,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  children: [
                    TextSpan(
                        text: '선택한 재료로\n',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        )
                    ),
                    TextSpan(
                        text: '레시피 추천',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        )
                    )
                  ]
              ),
            )
        ),
      ),
    );
  }
}


List<String> selectedButtons = [];

class IngredIconButton extends StatefulWidget {
  final String buttonText;
  final int expDate;
  final Widget icon;
  final Function(bool, bool, String) onPressed;

  IngredIconButton({
    required this.buttonText, //재료 이름
    required this.expDate,
    required this.icon,
    required this.onPressed,
  });

  @override
  _IngredIconButtonState createState() => _IngredIconButtonState();
}

class _IngredIconButtonState extends State<IngredIconButton> {
  bool isPressed = false;
  bool isIngredientSelect = false;
  static final Map<String, bool> buttonStates = {};

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
                'D-${widget.expDate}',
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


