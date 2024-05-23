import 'package:fe_flutter/ingredientMoreinfo/deleteIngredient.dart';
import 'package:fe_flutter/ingredientMoreInfo/ingredientEdit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IngredientMoreInformation extends StatefulWidget {
  const IngredientMoreInformation({super.key});

  @override
  State<IngredientMoreInformation> createState() => _IngredientMoreInformationState();
}

class _IngredientMoreInformationState extends State<IngredientMoreInformation> {
//TEST API 연결 테스트 시 초기값 지정 X
  String ingredientPlace = "실내";
  String ingredientName = '사과';
  String createdDate = '2024-05-01';
  String ingredientDeadLine = '2024-05-06';
  int ingredientNum = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('재료 상세 정보'),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.white,), onPressed: () {Navigator.pop(context);},),
      ),
      body:
      Center(
        child: FutureBuilder(
          future: fetchIngredientsInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data found'));
            } else {
              //ingredientPlace = snapshot.data?['ingredientPlace'];
              //ingredientName = snapshot.data?['title'];
              //createdDate = snapshot.data?['createdDate'];
              //ingredientDeadLine = snapshot.data?['ingredientDeadLine'];
              // 주소 지정했으면 주석 해제
              ingredientNum = snapshot.data?['id']; //테스트용 개수가 1이면 정상
              return Column(
                children: <Widget>[
                  const SizedBox(height: 40),
                  Container( // 임시
                    width: 350,
                    height: 280,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width:2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child:
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container( // 재료 사진
                              width: 100,
                              height: 100,
                              color: Colors.grey,
                            ),
                            Column(
                              children: [
                                printIngredientPlace(ingredientPlace),
                                const SizedBox(height: 20,),
                                Text(
                                  ingredientName,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      textAlign: TextAlign.left,
                                      '잔여기한:  ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('D-${DateTime.parse(ingredientDeadLine).difference(DateTime.parse(createdDate)).inDays.toString()}',
                                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Text>[
                            const Text(
                              '수량',
                              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              '$ingredientNum개',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Text>[
                            const Text(
                              '구매일',
                              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              createdDate,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Text>[
                            const Text(
                              '유통기한',
                              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              ingredientDeadLine,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 200),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color(0xffFFC94A)),
                        minimumSize: MaterialStateProperty.all(const Size(350,40)),
                      ),
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => IngredientEdit(
                              ingredientPlace: ingredientPlace,
                              ingredientName: ingredientName,
                              createdDate: createdDate,
                              ingredientDeadLine: ingredientDeadLine,
                              ingredientNum: ingredientNum,
                            ))
                        );
                       // debugPrint("TEST AWAIT");
                        setState(() {
                          fetchIngredientsInfo();
                        });

                      },
                      child: const Text(
                          '재료 편집',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,)
                      )
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(const Size(350,40)),
                      ),
                      onPressed: (){
                        deleteIngredient(context);
                      },
                      child: const Text(
                          '재료 삭제',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,)
                      )
                  )
                ],
              );
            }
          }
        )
      ),
    );
  }

  Widget printIngredientPlace(ingredientPlace) {
    return Row(
      children: [
        Text('냉장',style: TextStyle(fontWeight: FontWeight.bold, color: ingredientPlace == '냉장' ? Colors.black : Colors.grey),),
        const SizedBox(width: 5,),
        Text('냉동',style: TextStyle(fontWeight: FontWeight.bold, color: ingredientPlace == '냉동' ? Colors.black : Colors.grey),),
        const SizedBox(width: 5),
        Text('실내',style: TextStyle(fontWeight: FontWeight.bold, color: ingredientPlace == '실내' ? Colors.black : Colors.grey),),
      ],
    );
  }

  Future<Map<String,dynamic>> fetchIngredientsInfo() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1')); //테스트 주소

    if (response.statusCode == 200) {
      final Map<String,dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}


