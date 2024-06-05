import 'package:fe_flutter/model/searchedUserModel.dart';
import 'package:flutter/material.dart';
import 'package:fe_flutter/service/shareRefrigeServer.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
  int? _userId;
  SearchedUser? searched_user = SearchedUser();

  // 아래 세 줄은 임시 데이터
  //String _searchUserImage = 'https://lh4.googleusercontent.com/proxy/bQv_EtcQG0meeYE0BAKd83kzayElQTnqCxfAp0BRZef5NFYq9EhZdRlClAg0Myr-FVEdwQL3x4eNtvnRJoU7Suk2SuHLiGc_bhNCF2OrkBQ-Mu78ggZfvdxarEjxnnziV3bHCUq_13FG9uGooD5RX8UBEfAAElV8vr5OI958-5bOVQ';
  //List<String> _refrigeNames = ['냉장고1', '냉장고2'];
  //List<int> _refrigeIds = [1, 2];

  // userId 받아오기
  Future<int?> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _userId = pref.getInt("userId");
    print("user id : $_userId");

    if (_userId != null) {
      return _userId;
    } else {
      return null;
    }
  }

  // 검색한 유저 정보 받아오기
  @override
  void getSearchedUserInfo(String searchName) async {
    try {
      SearchedUser searchedUserInfo = await searchUser(searchName);
      if (searchedUserInfo.searchedUserImage != null)
        setState(() {
          searched_user = searchedUserInfo;
        });
      else
        setState(() {
          searched_user!.searchedUserImage = null;
          searched_user!.refrigeIds = [];
          searched_user!.refrigeNames = [];
        });
    } catch (e) {
      print('Failed to get searched user info: $e');
    }
  }

  @override
  void dispose() {
    _searchNameController.dispose();
    super.dispose();
  }

  void _updateSelectedRefrige(String? selectedRefrige) {
    setState(() {
      _selectedRefrige = selectedRefrige;
    });
  }

  @override
  Widget build(BuildContext context) {
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

                          getSearchedUserInfo(_searchName); // 검색한 유저 정보
                          setState(() {
                            isUserSearched = false;
                          });
                          if (searched_user!.searchedUserImage != null) {
                            setState(() {
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
                        }
                      },
                      icon: Icon(Icons.search, size: 30,),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            if (isUserSearched && searched_user != null)
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 45,),
                    ClipOval(
                      child: searched_user!.searchedUserImage != "" && searched_user!.searchedUserImage != null// image값이 있을 경우
                          ? Image.network(
                        searched_user?.searchedUserImage?.isNotEmpty == true
                            ? searched_user!.searchedUserImage!
                            : 'https://lh4.googleusercontent.com/proxy/bQv_EtcQG0meeYE0BAKd83kzayElQTnqCxfAp0BRZef5NFYq9EhZdRlClAg0Myr-FVEdwQL3x4eNtvnRJoU7Suk2SuHLiGc_bhNCF2OrkBQ-Mu78ggZfvdxarEjxnnziV3bHCUq_13FG9uGooD5RX8UBEfAAElV8vr5OI958-5bOVQ',
                        width: 122,
                        height: 122,
                        fit: BoxFit.cover,
                      )
                          : Image.network('https://w7.pngwing.com/pngs/981/645/png-transparent-default-profile-united-states-computer-icons-desktop-free-high-quality-person-icon-miscellaneous-silhouette-symbol.png',
                        width: 122,
                        height: 122,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16,),
                    Text('${_searchName}',
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
                              items: (searched_user!.refrigeNames)!.map<DropdownMenuItem<String>>((String value) {
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
                          int selectedRefrigeId = (searched_user!.refrigeNames)!.indexOf(_selectedRefrige!) + 1;
                          print('선택한 냉장고 : $selectedRefrigeId');
                          print('user id : $_userId');
                          sharePost(selectedRefrigeId, _userId!, _searchName);
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