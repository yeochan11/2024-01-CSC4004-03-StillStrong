import 'package:flutter/material.dart';

class IngredientSearch extends StatelessWidget {
  const IngredientSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 40,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          hintText: '식재료 검색',
          hintStyle: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0Xff98a3b3)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(
                color: Color(0Xffb4d4ff),
                width: 1.0,
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(
                color: Color(0Xffb4d4ff),
                width: 1.0,
              )
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(
                color: Color(0Xffb4d4ff),
                width: 1.0,
              )
          ),
        ),
      ),
    );
  }
}