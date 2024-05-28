class User {
  String? secretEmail;
  bool? gender;
  String? userNickname;
  String? secretPassword;
  int? userAge;
  List<String>? userFavorites;

  User(
      {this.secretEmail,
        this.gender,
        this.userNickname,
        this.secretPassword,
        this.userAge,
        this.userFavorites});

  // json 데이터로 유저 정보 생성
  User.fromJson(Map<String, dynamic> json) {
    secretEmail = json['secretEmail'];
    gender = json['gender'];
    userNickname = json['userNickname'];
    secretPassword = json['secretPassword'];
    userAge = json['userAge'];
    userFavorites = json['favorites'] != null ? List<String>.from(json['favorites']) : null;
  }

  // 유저 정보 json 형식으로 변환
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['secretEmail'] = this.secretEmail;
    data['gender'] = this.gender;
    data['userNickname'] = this.userNickname;
    data['secretPassword'] = this.secretPassword;
    data['userAge'] = this.userAge;
    data['favorites'] = this.userFavorites;
    return data;
  }
}
