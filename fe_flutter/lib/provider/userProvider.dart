import 'package:flutter/material.dart';
import 'package:fe_flutter/model/userModel.dart';

// 유저 정보 관리
class UserProvider extends ChangeNotifier {
  User? _user; // 현재 유저 정보 저장 변수

  User? get user => _user; // 현재 유저 정보 반환

  // 유저 정보 설정
  void setUser(User user) {
    _user = user; // 받은 유저 정보 _user에 업데이트
    notifyListeners(); // 정보 변경 알림
  }
  // 유저 로그아웃
  void clearUser() {
    _user = null;
    notifyListeners();
  }
}