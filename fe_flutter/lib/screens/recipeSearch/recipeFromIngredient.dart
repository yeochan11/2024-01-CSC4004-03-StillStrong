import 'package:fe_flutter/widget/recipeListWidget.dart';
import 'package:flutter/material.dart';

import '../../model/recipeSearchModel.dart';
import '../../service/recipeSearchServer.dart';

class RecipeFromIngredient extends StatefulWidget {
  final int usedId;
  final List<String> ingredientList;
  const RecipeFromIngredient({required this.usedId, required this.ingredientList});

  @override
  State<RecipeFromIngredient> createState() => _RecipeFromIngredientState();
}

class _RecipeFromIngredientState extends State<RecipeFromIngredient> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Image.asset('assets/images/yorijori.png', scale: 1.5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },),
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: postRecipeFromIngredient(widget.usedId, widget.ingredientList),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                      height: 400,
                      width: 400,
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      )
                  );
                }
                else {
                  RecipeSearchModel info = RecipeSearchModel(snapshot.data);
                  if (info.recipeNames.isEmpty) {
                    return const SizedBox(
                        height: 400,
                        width: 400,
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '레시피를 검색할 수 없습니다.',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        )
                    );
                  } else {
                    return Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            for (int i = 0; i < info.recipeNames.length; ++i)
                              makeRecipeList(
                                  info.recipeNames[i],
                                  info.recipeMainImages[i],
                                  info.recipeIngredients[i]!,
                                context
                              )
                          ],
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
