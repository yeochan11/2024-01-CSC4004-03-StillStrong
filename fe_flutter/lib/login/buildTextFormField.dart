import 'package:flutter/material.dart';

Widget buildTextFormField({
  required TextEditingController controller,
  required String labelText,
  required String hintText,
  bool isPassword = false,
}) {
  return Container(
    width: 300.0,
    child: TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 13.0,
          fontWeight: FontWeight.bold,
          color: const Color(0xff98A3B3),
        ),
        hintStyle: TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          color: const Color(0xff98A3B3),
        ),
        filled: true,
        fillColor: const Color(0xffF2F4F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: const Color(0xffFFC94A),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 19.0),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$labelText을 입력해주세요.';
        }
        return null;
      },
    ),
  );
}
