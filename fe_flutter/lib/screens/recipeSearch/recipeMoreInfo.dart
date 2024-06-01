import 'dart:ui';

import 'package:fe_flutter/model/recipeMoreInfoModel.dart';
import 'package:fe_flutter/service/recipeSearchServer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../service/recipeMoreInfoServer.dart';

class RecipeMoreInfo extends StatefulWidget {
  final String recipeName;
  const RecipeMoreInfo({required this.recipeName});

  @override
  State<RecipeMoreInfo> createState() => _RecipeMoreInfoState();
}

class _RecipeMoreInfoState extends State<RecipeMoreInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('레시피 추천'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },),
      ),
      body: FutureBuilder(
          future: fetchRecipeMoreInfo(widget.recipeName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            } else {
              RecipeMoreInfoModel info = RecipeMoreInfoModel(snapshot.data);
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 400,
                      height: 350,
                      child: Image.network(
                        info.recipeMainImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: 400,
                      height: 50,
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        info.recipeName,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                    Container(
                      width: 400,
                      height: 40,
                      padding: const EdgeInsets.only(left: 10.0),
                      //color: Colors.red,
                      child: Row(
                        children: [
                          const Text('태그',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 17.0),),
                          const SizedBox(width: 20,),
                          Text(
                            info.recipeCategory,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 400,
                      height: 10,
                      color: Colors.grey,
                    ),
                    Container(
                      width: 400,
                      height: 30,
                      //color: Colors.red,
                      alignment: const Alignment(-1, 0),
                      padding: EdgeInsets.only(left: 10.0),
                      child: const Text('레시피 재료', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                      ),
                    const SizedBox(height: 10,),
                    Container(
                      width: 400,
                      height: 60,
                      color: const Color(0xfff2f4f7),
                      alignment: const Alignment(-0.7,0),
                      child: Text(
                        info.recipeIngredients.toString().substring(1,info.recipeIngredients.toString().length-1),
                        style: const TextStyle(fontSize: 15.0),
                      ),
                    ),
                    for (int i = 0; i < info.recipeDescriptions.length; ++i)
                      _makeRecipeDescription(
                          info.recipeDescriptions[i],
                          info.recipeImage[i],
                          i + 1)
                  ],
                ),
              );
            }
          },
        ),
    );
  }

  Widget _makeRecipeDescription(String recipeDescription, String recipeImage, int cnt) {
    return Container(
      width: 400,
      height: 150,
      //color: Colors.grey,
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          ClipRRect(
            child: Image.network(recipeImage),
          ),
          const SizedBox(width: 10,),
          Column(
            children: [
              Container(
                width: 50,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                alignment: const Alignment(0, 0),
                child: Text('Step $cnt'),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                width: 165,
                height: 100,
                child: Text(recipeDescription),
              ),
            ],
          )
        ],
      ),
    );
  }
}
