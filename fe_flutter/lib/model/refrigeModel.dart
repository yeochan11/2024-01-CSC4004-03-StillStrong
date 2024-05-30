class RefrigeData {
  final List<Refrige> refrigeList;
  final String currentRefrigeName;

  RefrigeData({required this.refrigeList, required this.currentRefrigeName});

  factory RefrigeData.fromJson(Map<String, dynamic> json) {
    var list = json['refrigeList'] as List;
    List<Refrige> refrigeList = list.map((i) => Refrige.fromJson(i)).toList();

    return RefrigeData(
      refrigeList: refrigeList,
      currentRefrigeName: json['currentRefrigeName'],
    );
  }
}

class RefrigeList {
  List<Refrige>? refrigeList;

  RefrigeList({this.refrigeList});

  RefrigeList.fromJson(Map<String, dynamic> json) {
    if (json['refrigeList'] != null) {
      refrigeList = <Refrige>[];
      json['refrigeList'].forEach((v) {
        refrigeList!.add(new Refrige.fromJson(v));
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

class Refrige {
  int? refrigeId;
  String? refrigeName;
  bool? share;
  List<String>? ingredientNames;

  Refrige({this.refrigeId, this.refrigeName, this.share});

  Refrige.fromJson(Map<String, dynamic> json) {
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
