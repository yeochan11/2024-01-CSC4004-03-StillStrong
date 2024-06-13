import 'package:flutter/material.dart';

import '../screens/recipeSearch/recipeMoreInfo.dart';

Widget makeRecipeList(String recipeName, String recipeMainImage, List<String> recipeIngredients, BuildContext context) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        width: 370,
        height: 150,
        decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: const Color(0xffc7deff), width: 2.0) ,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 0,
                  blurRadius: 5.0,
                  offset: const Offset(0,10)
              )
            ]
        ),
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: 115,
                  height: 115,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(recipeMainImage, fit: BoxFit.cover),
                  )
              ),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Container(
                    width: 200,
                    height: 30,
                    alignment: const Alignment(-1, 0),
                    child: Text(
                      recipeName,
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: 200,
                    height: 40,
                    padding: const EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.amber, width: 2.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 140,
                          height: 40,
                          alignment: const Alignment(-1, 0),
                          child: Text(
                            recipeIngredients.length == 1?
                            recipeIngredients[0]
                                :'${recipeIngredients[0]} 외 ${recipeIngredients.length-1}개 재료',
                            style: const TextStyle(
                              fontSize: 15.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(Icons.arrow_drop_down, color: Colors.amber),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>
                    RecipeMoreInfo(recipeName: recipeName))
            );
          },
        ),
      )
  );
}