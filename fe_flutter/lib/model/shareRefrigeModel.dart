class SharedList {
  List<SharedData> pendingRequests;
  List<SharedData> receivedRequests;
  List<SharedData> acceptedRequests;

  SharedList({
    required this.pendingRequests,
    required this.receivedRequests,
    required this.acceptedRequests,
  });

  factory SharedList.fromJson(Map<String, dynamic> json) {
    return SharedList(
      pendingRequests: List<SharedData>.from(json['pendingRequests'].map((x) => SharedData.fromJson(x))),
      receivedRequests: List<SharedData>.from(json['receivedRequests'].map((x) => SharedData.fromJson(x))),
      acceptedRequests: List<SharedData>.from(json['acceptedRequests'].map((x) => SharedData.fromJson(x))),
    );
  }
}

class SharedData {
  int shareId;
  String createUserNickname;
  String requestUserNickname;
  String refrigeName;
  bool status;

  SharedData({
    required this.shareId,
    required this.createUserNickname,
    required this.requestUserNickname,
    required this.refrigeName,
    required this.status,
  });

  factory SharedData.fromJson(Map<String, dynamic> json) {
    return SharedData(
      shareId: json['shareId'],
      createUserNickname: json['createUserNickname'],
      requestUserNickname: json['requestUserNickname'],
      refrigeName: json['refrigeName'],
      status: json['status'],
    );
  }
}
