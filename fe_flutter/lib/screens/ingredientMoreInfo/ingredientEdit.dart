import 'package:fe_flutter/model/ingredientMoreInfoModel.dart';
import 'package:flutter/material.dart';
import '../../service/ingredInfoServer.dart';

class IngredientEdit extends StatefulWidget {
  final IngredientMoreInfoModel info;
  final int refrigeId;
  IngredientEdit({required this.info, required this.refrigeId});

  @override
  State<IngredientEdit> createState() => _IngredientEditState();
}

class _IngredientEditState extends State<IngredientEdit> {
//TEST
  late IngredientMoreInfoModel info;
  late int refrigeId;
  final List<bool> _isSelected = [false, false, false];
  final List<String> _ingredientPlaceList = ["냉장", "냉동", "실내"];
  @override
  void initState() {
    super.initState();
    info = widget.info;
    refrigeId = widget.refrigeId;
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 3; i++) { // 초기 보관 상태 지정하는 부분
      if (info.ingredientPlace.compareTo(_ingredientPlaceList[i]) == 0) {
        _isSelected[i] = true;
      }
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('재료 편집'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },),
      ),
      body: Center(
        child:
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  width: 350,
                  height: 550,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
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
                                ToggleButtons( // 보관 장소 지정 버튼
                                  disabledColor: Colors.white,
                                  renderBorder: false,
                                  borderRadius: BorderRadius.circular(10),
                                  borderWidth: 0,
                                  borderColor: Colors.white,
                                  fillColor: Colors.white,
                                  color: Colors.grey,
                                  selectedColor: Colors.amber,
                                  isSelected: _isSelected,
                                  onPressed: (int index) {
                                    setState(() {
                                      for (int buttonIndex = 0; buttonIndex <
                                          _isSelected.length; buttonIndex++) {
                                        if (buttonIndex == index) {
                                          _isSelected[buttonIndex] = true;
                                          info.ingredientPlace =
                                          _ingredientPlaceList[buttonIndex];
                                        } else {
                                          _isSelected[buttonIndex] = false;
                                        }
                                      }
                                    });
                                  },
                                  children: const [
                                    Text('냉장', style: TextStyle(
                                      fontWeight: FontWeight.bold,),),
                                    Text('냉동', style: TextStyle(
                                      fontWeight: FontWeight.bold,),),
                                    Text('실내', style: TextStyle(
                                      fontWeight: FontWeight.bold,),),
                                  ],
                                ),
                                const SizedBox(height: 60,),
                              ],
                            )
                          ]
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 15),
                          TextFormField( // 이름 버튼
                            initialValue: info.ingredientName,
                            onChanged: (value) {
                              setState(() {
                                info.ingredientName = value;
                              });
                            },
                            decoration: const InputDecoration(
                                prefixText: '  ',
                                suffixText: '이름    ',
                                suffixStyle: TextStyle(fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.amber,
                                    )
                                )
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 60,
                            width: 330,
                            decoration: BoxDecoration(
                                border: Border.all(width: 2.0, color: Colors.grey),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 70,
                                      child: Text('     ${info.ingredientNum}개',
                                        style: const TextStyle(fontSize: 16),),
                                    ),
                                    Container(width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              100.0)),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white24,
                                              shape: const CircleBorder(),
                                              padding: const EdgeInsets.all(0)
                                          ),
                                          onPressed: () {
                                            if (info.ingredientNum - 1 == 0) {

                                            } else {
                                              setState(() {
                                                info.ingredientNum =
                                                    info.ingredientNum - 1;
                                              });
                                            }
                                          },
                                          child: const Icon(
                                            Icons.remove, color: Colors.black,
                                            size: 20.0,)
                                      ),),
                                    const SizedBox(width: 5,),
                                    Container(width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              100.0)),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white24,
                                              shape: const CircleBorder(),
                                              padding: const EdgeInsets.all(0)
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              info.ingredientNum =
                                                  info.ingredientNum + 1;
                                            });
                                          },
                                          child: const Icon(
                                            Icons.add, color: Colors.black,
                                            size: 20.0,)
                                      ),),
                                  ],
                                ),
                                const Text('수량      ', style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber),),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),
                          OutlinedButton(onPressed: () async { // 등록날짜 버튼
                            final DateTime? selectDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.parse(info.createdDate),
                              firstDate: DateTime(1950),
                              lastDate: DateTime.now(),
                            );
                            if (selectDate != null) {
                              setState(() {
                                info.createdDate =
                                    selectDate.toString().substring(0, 10);
                              });
                            }
                          },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.grey,
                                    width: 2.0),
                                fixedSize: const Size(350, 60),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(info.createdDate,
                                      style: const TextStyle(color: Colors.black)),
                                  const SizedBox(height: 50, width: 155),
                                  const Text('등록날짜', style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber)),
                                ],
                              )
                          ),
                          const SizedBox(height: 10),
                          OutlinedButton(onPressed: () async { // 유통기한 버튼
                            final DateTime? selectDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.parse(info.ingredientDeadLine),
                              firstDate: DateTime.parse(info.createdDate),
                              lastDate: DateTime(2100),
                            );
                            if (selectDate != null) {
                              setState(() {
                                info.ingredientDeadLine =
                                    selectDate.toString().substring(0, 10);
                              });
                            }
                          },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.grey,
                                    width: 2.0),
                                fixedSize: const Size(350, 60),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(info.ingredientDeadLine,
                                      style: const TextStyle(color: Colors.black)),
                                  const SizedBox(height: 50, width: 155),
                                  const Text('유통기한', style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber)),
                                ],
                              )
                          ),
                          const SizedBox(height: 10,),
                          TextFormField(
                            initialValue: info.ingredientMemo,
                            onChanged: (value) {
                              setState(() {
                                info.ingredientMemo = value;
                              });
                            },
                            maxLength: 40,
                            maxLines: 2,
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                                prefixText: '  ',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.amber,
                                    )
                                )
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                ElevatedButton( //완료 버튼
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color(0xffFFC94A)),
                      minimumSize: MaterialStateProperty.all(const Size(350, 40)),
                    ),
                    onPressed: () async {
                      try {
                        await patchIngredient(info, refrigeId);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Patch failed: $e'),),
                        );
                      }
                      // 값 변경 테스트용
                      debugPrint('Current Place : ${info.ingredientPlace}');
                      debugPrint('Current Name : ${info.ingredientName}');
                      debugPrint('Current Number : ${info.ingredientNum}');
                      debugPrint('Current CreatedDate : ${info.createdDate.toString()}');
                      debugPrint('Current DeadLine : ${info.ingredientDeadLine.toString()}');
                      debugPrint('Current Memo : ${info.ingredientMemo.toString()}');
                      Navigator.pop(context);
                    },
                    child: const Text(
                        '완료',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,)
                    )
                ),
              ],
            ),
          )
      ),
    );
  }
}
