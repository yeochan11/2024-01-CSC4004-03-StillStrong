import 'package:flutter/material.dart';

class IngredientSelect extends StatefulWidget {
  const IngredientSelect({super.key});

  @override
  State<IngredientSelect> createState() => _IngredientSelectState();
}

class _IngredientSelectState extends State<IngredientSelect> {
  bool isIngredientSelect = false;

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
