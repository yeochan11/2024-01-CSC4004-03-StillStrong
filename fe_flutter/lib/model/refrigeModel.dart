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

  Map<String, dynamic> toJson() {
    return {
      'refrigeList': refrigeList.map((refrige) => refrige.toJson()).toList(),
      'currentRefrigeName': currentRefrigeName,
    };
  }
}

class Refrige {
  final int refrigeId;
  final String refrigeName;
  final bool share;
  final List<String> ingredientNames;
  final List<int> ingredientDeadlines;


  Refrige({required this.refrigeId, required this.refrigeName, required this.share, required this.ingredientNames, required this.ingredientDeadlines});

  factory Refrige.fromJson(Map<String, dynamic> json) {
    return Refrige(
      refrigeId: json['refrigeId'],
      refrigeName: json['refrigeName'],
      share: json['share'],
      ingredientNames: List<String>.from(json['ingredientNames']),
      ingredientDeadlines: List<int>.from(json['ingredientDeadlines'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refrigeId': refrigeId,
      'refrigeName': refrigeName,
      'share': share,
      'ingredientNames': ingredientNames,
      'ingredientDeadlines' : ingredientDeadlines
    };
  }
}
