import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AllergyPage extends StatefulWidget {
  @override
  _AllergyPageState createState() => _AllergyPageState();
}

class _AllergyPageState extends State<AllergyPage> {
  final _allergy = ['난류', '가금류', '돼지고기', '땅콩'];
  List<String> _selectedAllergy = [];
  String? _currentItem;

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
            SizedBox(height: 103.0),
            Text(
              '알러지가 있으신가요?',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '모두 선택해주세요!',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 46.0),
            Container(
              width: 312.0,
              height: 200.0,
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: DropdownButtonFormField<String>(
                      value: _currentItem, // 현재 선택값
                      items: _allergy.map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (String? newItem) {
                        setState(() {
                          if (_selectedAllergy.contains(newItem)) {
                            _selectedAllergy.remove(newItem);
                          }
                          else {
                            _selectedAllergy.add(newItem!);
                          }
                          _currentItem = newItem;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: '알러지 유발식품 검색',
                        hintStyle: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff98A3B3),
                        ),
                        iconColor: const Color(0xffF6A90A),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                                color: const Color(0xffF6A90A),
                            ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: const Color(0xffF6A90A),
                          )
                        ),
                      ),
                      isExpanded: true,
                      selectedItemBuilder: (_) {
                        return _selectedAllergy.map<Widget>((e) {
                          return Text(e);
                        }).toList();
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Chip(
                    label: Text(${_selectedAllergy[0]}),
                    backgroundColor: Colors.grey,
                    deleteIcon: Icon(Icons.close),
                    onDeleted: () {
                      setState(() {
                        _selectedAllergy.remove(e);
                      });
                    },
                  ),
                  Text('Selected Items: ${_selectedAllergy.join(', ')}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
