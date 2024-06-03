import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:fe_flutter/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:fe_flutter/service/shareRefrigeServer.dart';
import 'package:flutter/widgets.dart';


class ShareRefrigePage extends StatefulWidget {
  @override
  _ShareRefrigePageState createState() => _ShareRefrigePageState();
}

class _ShareRefrigePageState extends State<ShareRefrigePage> {
  final _formKey = GlobalKey<FormState>();
  late String _searchName;
  final _searchNameController = TextEditingController();
  static bool isUserSearched = false;
  String? _selectedRefrige;
  int? _selectedRefrigeId;
  String? _searchUserImage;
  List<String>? _refrigeNames;
  List<int>? _refrigeIds;


  // 아래 세 줄은 임시 데이터
  //String _searchUserImage = 'https://lh4.googleusercontent.com/proxy/bQv_EtcQG0meeYE0BAKd83kzayElQTnqCxfAp0BRZef5NFYq9EhZdRlClAg0Myr-FVEdwQL3x4eNtvnRJoU7Suk2SuHLiGc_bhNCF2OrkBQ-Mu78ggZfvdxarEjxnnziV3bHCUq_13FG9uGooD5RX8UBEfAAElV8vr5OI958-5bOVQ';
  //List<String> _refrigeNames = ['냉장고1', '냉장고2'];
  //List<int> _refrigeIds = [1, 2];


  @override
  void dispose() {
    _searchNameController.dispose();
    super.dispose();
  }

  @override
  void _updateSelectedRefrige(String? selectedRefrige) {
    setState(() {
      _selectedRefrige = selectedRefrige;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? userId = Provider.of<UserProvider>(context, listen: false).user?.userId;
    int _userId = int.parse(userId!);
    return Scaffold(
      appBar: AppBar(
          title: Text('냉장고 공유하기'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.chevron_left,
              color: Colors.white,
              size: 30,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              width: 343,
              height: 56,
              padding: EdgeInsets.only(left: 16, bottom: 5),
              decoration: BoxDecoration(
                color: const Color(0xffF2F4F7),
                borderRadius: BorderRadius.circular(15)
              ),
                child: Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _searchNameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                            border: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: '닉네임 검색',
                            labelStyle: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              _searchName = _searchNameController.text;
                              print(_searchName); // 입력한 닉네임 출력 (확인용)
                              setState(() {
                                isUserSearched = true;
                              });
                              // 검색한 유저 정보 불러오기
                              searchUser(_searchNameController.text).then((value) {
                                if (value != null) {
                                  setState(() {
                                    _searchUserImage = value['searchUserImage'];
                                    _refrigeNames = value['refrigeNames'];
                                    _refrigeIds = value['refrigeIds'];
                                    _searchName = _searchNameController.text;
                                    isUserSearched = true;
                                  });
                                } else {
                                  // 유저 정보 없을 경우
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: const Color(0xffF6A90A),
                                      content: Text('일치하는 사용자를 찾을 수 없습니다.',
                                        style: TextStyle(
                                          fontFamily: 'Pretendard',
                                          fontSize: 13.0,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 1000),
                                    ),
                                  );
                                }
                              });
                            }
                          },
                          icon: Icon(Icons.search, size: 30,),
                      ),
                    ],
                  ),
                ),
            ),
          SizedBox(height: 10,),
          if (isUserSearched)
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 45,),
                    ClipOval(
                      child: Image.network(
                        '${_searchUserImage}',
                        width: 122,
                        height: 122,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16,),
                    Text('$_searchName',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 343,
                      height: 67,
                      padding: EdgeInsets.only(left: 16, top: 5),
                      decoration: BoxDecoration(
                          color: const Color(0xffF2F4F7),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('초대할 냉장고',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            width: 311,
                            child: DropdownButton<String>(
                              hint: Text('냉장고 선택',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              value: _selectedRefrige,
                              items: _refrigeNames!.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value)
                                );
                              }).toList(),
                              onChanged: _updateSelectedRefrige,
                              isExpanded: true,
                              isDense: true,
                              underline: SizedBox(),
                              padding: EdgeInsets.only(top: 7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 169,),
                    Container(
                      width: 211,
                      height: 30,
                      child: TextButton(
                        onPressed: () {
                          _selectedRefrigeId = _refrigeNames!.indexOf(_selectedRefrige!) + 1;
                          print('선택한 냉장고 : $_selectedRefrigeId');
                          print('user id : $_userId');
                          sharePost(_selectedRefrigeId!, _userId, _searchName);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xffF6A90A),
                          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text('공유하기',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 211,
                      height: 30,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xffF6A90A),
                          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text('공유 요청 보기',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}