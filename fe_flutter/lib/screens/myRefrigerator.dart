import 'package:fe_flutter/screens/ingredientMoreInfo/ingredientMoreInfo.dart';
import 'package:flutter/material.dart';

class MyRefrigerator extends StatelessWidget {
  const MyRefrigerator({super.key});
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
                  child: const Text('재료')),
            ],
          )
      ),
    );
  }
}