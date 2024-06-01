import 'package:flutter/material.dart';

enum InputType { text, number, date }

Widget ingredTextFormField({
  required TextEditingController controller,
  required String labelText,
  required String hintText,
  InputType inputType = InputType.text,
  validator,
  onTap,
  decoration,
  bool readOnly = false,

}) {
  TextInputType keyboardType;

  switch (inputType) {
    case InputType.text:
      keyboardType = TextInputType.text;
      break;
    case InputType.number:
      keyboardType = TextInputType.number;
      break;
    case InputType.date:
      keyboardType = TextInputType.datetime;
      break;
  }

  return Container(
    width: 280.0,
    height: 36.0,
    child: TextFormField(
      controller: controller,
      validator: validator != null
          ? (value) {
        // 내부, 외부 validator 모두 수행
        final internalResult = validator!(value);
        if (internalResult != null) {
          return internalResult;
        }
        if (value == null || value.isEmpty) {
          return '$labelText을 입력해주세요.';
        }
        return null;
      }
          : (value) {
        if (value == null || value.isEmpty) {
          return '$labelText을 입력해주세요.';
        }
        return null;
      },
      onTap: onTap,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: const Color(0xff98A3B3),
        ),
        hintStyle: TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 13.0,
          fontWeight: FontWeight.w500,
          color: const Color(0xff98A3B3),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: const Color(0xffEEEEEE), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
            color: const Color(0xffEEEEEE), width: 2
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 19.0),
      ),
    ),
  );
}
