import 'package:fe_flutter/ingredientMoreinfo/deleteIngredient.dart';
import 'package:fe_flutter/ingredientMoreInfo/ingredientEdit.dart';
import 'package:flutter/material.dart';

class IngredientMoreInformation extends StatefulWidget {
  const IngredientMoreInformation({super.key});

  @override
  State<IngredientMoreInformation> createState() => _IngredientMoreInformationState();
}

class _IngredientMoreInformationState extends State<IngredientMoreInformation> {
//TEST
  String ingredientPlace = "실내";
  String ingredientName = '사과';
  String createdDate = '2024-05-01';
  String ingredientDeadLine = '2024-05-06';
  int ingredientNum = 5;

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
        child:
          Column(
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const IngredientEdit())
                    );
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
          ),
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
}
