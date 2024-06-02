import 'package:fe_flutter/model/recipeSearchModel.dart';
import 'package:fe_flutter/screens/recipeSearch/recipeMoreInfo.dart';
import 'package:fe_flutter/service/recipeSearchServer.dart';
import 'package:flutter/material.dart';

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
      resizeToAvoidBottomInset: false,
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
                        height: 600,
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
                        height: 600,
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
                      return Container(
                        height: 620,
                        width: 400,
                        alignment: const Alignment(0, -1),
                        child: SingleChildScrollView(
                              scrollDirection: Axis.vertical, 
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  for (int i = 0; i < info.recipeNames.length; ++i)
                                    _makeRecipeList(
                                        info.recipeNames[i], 
                                        info.recipeMainImages[i], 
                                        info.recipeIngredients[i]!
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

  Widget _makeRecipeList(String recipeName, String recipeMainImage, List<String> recipeIngredients) {
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
                  Text(
                    recipeName,
                    style: const TextStyle(
                      fontSize: 20.0,
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
                        Text(
                          recipeIngredients.length == 1?
                          recipeIngredients[0]
                              :'${recipeIngredients[0]} 외 ${recipeIngredients.length-1}개 재료',
                          style: const TextStyle(
                            fontSize: 15.0,
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
}
