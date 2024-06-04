import 'package:fe_flutter/model/recipeSearchModel.dart';
import 'package:fe_flutter/screens/recipeSearch/recipeMoreInfo.dart';
import 'package:fe_flutter/service/recipeSearchServer.dart';
import 'package:flutter/material.dart';

import '../../widget/recipeListWidget.dart';

class RecipeSearchPage extends StatefulWidget {
  final String search;

  const RecipeSearchPage({required this.search});

  @override
  State<RecipeSearchPage> createState() => _RecipeSearchPageState();
}

class _RecipeSearchPageState extends State<RecipeSearchPage> {
  late TextEditingController _searchController;
  late String searchRecipe = widget.search;


  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: searchRecipe);
  }

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
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: SearchBar(
                trailing: [
                  IconButton(
                    onPressed: () {
                      print(searchRecipe);
                      setState(() {
                        fetchRecipeSearchData(searchRecipe);
                      });
                    },
                    icon: const Icon(Icons.search),)
                ],
                shape: MaterialStateProperty.all(ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
                backgroundColor: const MaterialStatePropertyAll(Colors.white),
                side: MaterialStateProperty.all(
                    const BorderSide(color: Color(0xffc7deff), width: 1.5)
                ),
                controller: _searchController,
                hintText: '레시피 검색',
                constraints: const BoxConstraints(maxHeight: 50, maxWidth: 330),
                elevation: const MaterialStatePropertyAll(0),
                onSubmitted: (value) {
                  searchRecipe = value;
                  print(searchRecipe);
                  setState(() {
                    fetchRecipeSearchData(searchRecipe);
                  });
                },
              ),
            ),
            FutureBuilder(
                future: fetchRecipeSearchData(searchRecipe),
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
