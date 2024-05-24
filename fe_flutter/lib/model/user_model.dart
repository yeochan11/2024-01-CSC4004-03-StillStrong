
class User {
  String? secretEmail;
  String? secretPassword;

  User({this.secretEmail, this.secretPassword});

  User.fromJson(Map<String, dynamic> json) {
    secretEmail = json['secretEmail'];
    secretPassword = json['secretPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['secretEmail'] = this.secretEmail;
    data['secretPassword'] = this.secretPassword;
    return data;
  }
}
