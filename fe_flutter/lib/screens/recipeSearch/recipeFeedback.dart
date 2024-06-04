import 'package:flutter/material.dart';
import '../../service/recipeMoreInfoServer.dart';

void RecipeFeedback(BuildContext context) {
  bool satisfied = false;
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.all(5.0),
          elevation: 10.0,
          backgroundColor: Colors.white,
          actionsAlignment: MainAxisAlignment.center,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text( //텍스트 위치 조정
                "레시피 만족도는 어떤가요?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      satisfied = true;
                      try {
                        await postRecipeFeedback(satisfied);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Post failed: $e')),);
                      }
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      backgroundColor: const Color(0xFFFF8B37),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                    ),
                    child: Container(width: 90, height: 20, alignment: const Alignment(0, 0),
                      child: const Text('좋았어요!',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),),
                const SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () async {
                    satisfied = false;
                    try {
                      await postRecipeFeedback(satisfied);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Post failed: $e')),);
                    }
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      backgroundColor: const Color(0xFFF6A90A),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                  ),
                  child: Container(width: 90, height: 20, alignment: const Alignment(0, 0),
                    child: const Text('아쉬웠어요..',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),),
                const SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      backgroundColor: const Color(0xFFBCA16B),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                  ),
                  child: Container(width: 90, height: 20, alignment: const Alignment(0, 0),
                    child: const Text('잘못 눌렀어요',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),),
                const SizedBox(height: 10,),
              ],
            ),

          ],
        );
      }
  );
}