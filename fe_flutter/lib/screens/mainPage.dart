import 'package:fe_flutter/service/mainPageServer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fe_flutter/provider/userProvider.dart';

import '../model/mainPageModel.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user; // 유저 정보 불러오기
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
              mainPageModel info = mainPageModel(snapshot.data);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding( //레시피 검색 위젯
                    padding: EdgeInsets.all(5.0),
                    child: SearchBar(
                      trailing: [
                        IconButton(
                          onPressed: () {
                            //TODO: 페이지 이동 추가
                            print('TEST');},
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
                      onSubmitted: (value) {
                        //TODO: 페이지 이동 추가
                        print(value);
                      },
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: 400,
                    height: 300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        /*info.MainRecipeImage*/'https://recipe1.ezmember.co.kr/cache/recipe/2022/09/30/8e7eb8e3019532a8dc6d39a9a325aad41.jpg',
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  
                ],
              );
            }
          },
        ),
          // child: user != null ? // 유저값이 null이 아닐 경우 내용 표시
          //   Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Text('메인 페이지\nEmail : ${user.secretEmail}\nPw : ${user.secretPassword}'), // 유저 정보 출력 (확인용)
          //     ],
          //   )
          //     : null,
          ),
      );
  }
}