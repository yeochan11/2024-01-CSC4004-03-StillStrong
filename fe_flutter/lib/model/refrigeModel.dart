class Refrige {
  List<RefrigeList>? refrigeList;

  Refrige({this.refrigeList});

  Refrige.fromJson(Map<String, dynamic> json) {
    if (json['refrigeList'] != null) {
      refrigeList = <RefrigeList>[];
      json['refrigeList'].forEach((v) {
        refrigeList!.add(new RefrigeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.refrigeList != null) {
      data['refrigeList'] = this.refrigeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }


}

class RefrigeList {
  int? refrigeId;
  String? refrigeName;
  bool? share;
  List<String>? ingredientNames;

  RefrigeList({this.refrigeId, this.refrigeName, this.share});

  RefrigeList.fromJson(Map<String, dynamic> json) {
    refrigeId = json['refrigeId'];
    refrigeName = json['refrigeName'];
    share = json['share'];
    ingredientNames = json['ingredientNames'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refrigeId'] = this.refrigeId;
    data['refrigeName'] = this.refrigeName;
    data['share'] = this.share;
    data['ingredientNames'] = this.ingredientNames;
    return data;
  }
}
