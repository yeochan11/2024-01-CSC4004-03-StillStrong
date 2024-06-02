class User {
  String? userId;
  String? secretEmail;
  bool? gender;
  String? userNickname;
  String? secretPassword;
  int? userAge;
  List<String>? userFavorites;
  List<String>? userAllergies;
  String? userImage;
  bool? alarm;

  User(
      {this.userId,
        this.secretEmail,
        this.gender,
        this.userNickname,
        this.secretPassword,
        this.userAge,
        this.userFavorites,
        this.userAllergies,
        this.userImage,
        this.alarm,
      });

  // json 데이터로 유저 정보 생성
  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    secretEmail = json['secretEmail'];
    gender = json['gender'];
    userNickname = json['userNickname'];
    secretPassword = json['secretPassword'];
    userAge = json['userAge'];
    userFavorites = json['favorites'] != null ? List<String>.from(json['favorites']) : null;
    userAllergies = json['allergies'] != null ? List<String>.from(json['allergies']) : null;
    userImage = json['userImage'];
    alarm = json['alarm'];
  }

  // 유저 정보 json 형식으로 변환
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['secretEmail'] = this.secretEmail;
    data['gender'] = this.gender;
    data['userNickname'] = this.userNickname;
    data['secretPassword'] = this.secretPassword;
    data['userAge'] = this.userAge;
    data['favorites'] = this.userFavorites;
    data['allergies'] = this.userAllergies;
    data['userImage'] = this.userImage;
    data['alarm'] = this.alarm;
    return data;
  }
}