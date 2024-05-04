import 'package:flutter/material.dart';

void deleteIngredient(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text( //텍스트 위치 조정
              "정말로 삭제하시겠습니까?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () { // 재료 삭제 메소드 추가해야 함
            Navigator.popUntil(context , ModalRoute.withName('/BottomMenu'));
          },
              child: const Text("확인")),
          
          TextButton(onPressed: () {
            Navigator.of(context).pop();
          },
              child: const Text("취소"))
        ],
      );
    }
  );
}