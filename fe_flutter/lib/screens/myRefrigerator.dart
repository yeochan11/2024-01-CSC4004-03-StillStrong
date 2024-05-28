import 'package:fe_flutter/screens/ingredientMoreInfo/ingredientMoreInfo.dart';
import 'package:flutter/material.dart';
// 임시 페이지입니다.
class MyRefrigerator extends StatelessWidget {
  const MyRefrigerator({super.key});
 //재료 상세 정보 페이지
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('My 냉장고'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IngredientMoreInformation(
                    refrigeId: 1,
                    ingredientName: 'TEST',
                  ))
                );
              },
                  child: const Text('재료')), // 재료 선택 페이지에서 재료를 클릭했을 경우.
              //const Text('My 냉장고',),
            ],
          )
      ),
    );
  }
}