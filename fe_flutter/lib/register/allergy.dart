import 'package:flutter/material.dart';

class AllergyPage extends StatefulWidget {
  @override
  _AllergyPageState createState() => _AllergyPageState();
}

class _AllergyPageState extends State<AllergyPage> {
  final List<String> _allergyList = ['난류', '갑각류', '돼지고기', '땅콩'];
  List<String> _selectedAllergy = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/yorijori.png',
          height: 30.0,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 103.0,),
            Text('알러지가 있으신가요?',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text('모두 선택해주세요!',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 46.0,),
            Container(
              width: 300.0,
              height: 53.0,
              child: DropdownButtonFormField(
                isExpanded: true,
                isDense: true,
                value: null, //사용자가 선택한 항목
                items: _allergyList.map((allergy) => DropdownMenuItem(
                  value: allergy,
                  child: SizedBox(
                    width: 300.0,
                    //height: 46.0,
                    child : Text(allergy),
                  ),
                ))
                    .toList(),
                hint: Text('알러지 유발식품 검색', style:
                TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff98A3B3),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff98A3B3),
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: Color(0xffFFC94A),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 18.0)
                ),
                onChanged: (selectedItem) {
                  setState(() {
                    _selectedAllergy.clear();
                    _selectedAllergy.add(selectedItem.toString()); //선택된 항목 추가
                  });
                },
                selectedItemBuilder: (BuildContext context) {
                  return _allergyList.map<Widget>((String item) {
                    return Text(item);
                  }).toList();
                },
              ),
            ),


          ],

        ),
      ),
    );
  }
}