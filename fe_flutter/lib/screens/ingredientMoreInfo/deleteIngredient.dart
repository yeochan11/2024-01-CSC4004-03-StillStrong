import 'package:flutter/material.dart';
import '../../service/db_server.dart';

void deleteIngredient(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        actionsPadding: EdgeInsets.all(5.0),
        elevation: 10.0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text( //텍스트 위치 조정
              "정말 삭제하시겠습니까?",
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () async {
            try {
              await deleteIngredientInfo();
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Delete failed: $e')),);
              }
            Navigator.popUntil(context , ModalRoute.withName('/BottomMenu'));
          },
              child: const Text("확인", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))),
          
          TextButton(onPressed: () {
            Navigator.of(context).pop();
          },
              child: const Text("취소", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)))
        ],
      );
    }
  );
}

