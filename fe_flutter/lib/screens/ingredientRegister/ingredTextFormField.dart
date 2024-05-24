import 'package:flutter/material.dart';

enum InputType { text, number, date }

Widget ingredTextFormField({
  required TextEditingController controller,
  required String labelText,
  required String hintText,
  InputType inputType = InputType.text,
  validator,

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
      keyboardType = TextInputType.text; // 날짜 입력 시 키보드 사용하지 않음
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
      /*onTap: () async {
        // 달력에서 날짜 선택
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          // 선택한 날짜를 텍스트 필드에 입력
          controller.text = pickedDate.toString();
        }
      },*/
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
