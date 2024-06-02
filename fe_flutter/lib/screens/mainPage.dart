import 'package:fe_flutter/screens/recipeSearch/recipeMoreInfo.dart';
import 'package:fe_flutter/screens/recipeSearch/recipeSearchPage.dart';
import 'package:fe_flutter/service/mainPageServer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fe_flutter/provider/userProvider.dart';
import '../model/mainPageModel.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<UserProvider>(context).user; // 유저 정보 불러오기
    String searchRecipe = '';

    //API로 값을 가져왔다고 가정

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset('assets/images/yorijori.png', scale: 1.5),
      ),
      body: Center(
        child: FutureBuilder(
          future: fetchMainPageData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            } else {
              mainPageModel info = mainPageModel(snapshot.data); // API로 받은 데이터
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20,),
                    Padding( //레시피 검색 위젯
                      padding: const EdgeInsets.all(5.0),
                      child: SearchBar(
                        trailing: [
                          IconButton(
                            onPressed: () {
                              if (searchRecipe.isEmpty) {
                                print('NULL TEXT');
                              } else {
                                print(searchRecipe);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>
                                        RecipeSearchPage(search: searchRecipe))
                                );
                              }
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
                        hintText: '레시피 검색',
                        constraints: const BoxConstraints(maxHeight: 50, maxWidth: 330),
                        elevation: const MaterialStatePropertyAll(0),
                        onChanged: (value) {
                          searchRecipe = value;
                        },
                        onSubmitted: (value) {
                          searchRecipe = value;
                          if (searchRecipe.isEmpty) {
                            print('NULL TEXT');
                          } else {
                            print(searchRecipe);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    RecipeSearchPage(search: searchRecipe))
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20,),
                    InkWell(
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 400,
                            height: 300,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(
                                //TODO: API 주소 설정하면 이 값을 이용
                                info.MainRecipeImage,
                                //TODO: 임시 이미지입니다. API 주소 설정 후 주석 처리 해주세요.
                                //'https://recipe1.ezmember.co.kr/cache/recipe/2022/09/30/8e7eb8e3019532a8dc6d39a9a325aad41.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                              width: 400,
                              height: 100,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
                                color: Color(0x99000000),
                              ),
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '오늘의 추천요리',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    info.MainRecipeName,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                RecipeMoreInfo(recipeName: info.MainRecipeName))
                        );
                      },
                    ),
                    const SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 15,),
                        const Text(
                          '당신을 위한 레시피 ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.asset('assets/images/yorijori_eye.png', width: 27, height: 27),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      height: 350,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0; i < 5; ++i)
                              _makeSubRecipeBox(
                                  info.SubRecipeImage.elementAt(i),
                                  info.SubRecipeCategory.elementAt(i),
                                  info.SubRecipeName.elementAt(i),
                                  context
                              ),
                            const SizedBox(width: 20,)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50,)
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  // 서브 레시피 생성 함수
  Widget _makeSubRecipeBox(String subRecipeImage, String subRecipeCategory, String subRecipeName, BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20,),
        InkWell(
          child: Container(
            width: 230,
            height: 320,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 0,
                      blurRadius: 5.0,
                      offset: const Offset(0,10)
                  )
                ]
            ),
            child: Column(
              children: [
                Image.network(
                  //TODO: API 주소 설정하면 이 값을 이용
                  subRecipeImage,
                  //TODO: 임시 이미지입니다. API 주소 설정 후 주석 처리 해주세요.
                  //'https://recipe1.ezmember.co.kr/cache/recipe/2022/09/30/8e7eb8e3019532a8dc6d39a9a325aad41.jpg',
                  width: 230,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    const SizedBox(width: 10,),
                    Container(
                      alignment: Alignment.center,
                      width: 80,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      child: Text(
                        subRecipeCategory,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    subRecipeName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>
                    RecipeMoreInfo(recipeName: subRecipeName))
            );
          },
        )
      ],
    );
  }
}