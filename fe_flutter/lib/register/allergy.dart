import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class AllergyPage extends StatefulWidget {
  @override
  _AllergyPageState createState() => _AllergyPageState();
}

class _AllergyPageState extends State<AllergyPage> {
  final MultiSelectController controller = MultiSelectController(); // Use camelCase for variable naming
  String searchQuery = '';

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
              height: 45.0,
              child: MultiSelectDropDown(
                controller: controller, // Use the correct variable name
                onOptionSelected: (options) => debugPrint(options.toString()),
                options: const <ValueItem>[
                  ValueItem(label: '난류', value: '1'),
                  ValueItem(label: '갑각류', value: '2'),
                  ValueItem(label: '돼지고기', value: '3'),
                  ValueItem(label: '땅콩', value: '4'),
                ],
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(
                  wrapType: WrapType.scroll,
                  backgroundColor: Color(0xffF2F4F7),
                  deleteIconColor: Colors.black,
                  radius: 10,
                  labelColor: Colors.black,
                  labelStyle: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                dropdownHeight: 200,
                optionTextStyle: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff98A3B3),
                ),
                selectedOptionIcon: Icon(Icons.check, color: Color(0xffFFC94A)),
                borderColor: Color(0xffFFC94A),
                focusedBorderColor: Color(0xffFFC94A),
                borderRadius: 12.0,
                suffixIcon: Icon(Icons.arrow_drop_down, color: Color(0xffFFC94A)),
                hint: '알러지 유발식품 검색',
                hintColor: Color(0xff98A3B3),
                hintStyle: TextStyle(
                  fontFamily: 'Pretendard',
                ),
                hintFontSize: 13.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
