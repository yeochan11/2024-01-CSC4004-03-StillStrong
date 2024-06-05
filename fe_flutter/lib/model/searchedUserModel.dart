class SearchedUser {
  String? searchedUserImage;
  List<String>? refrigeNames;
  List<int>? refrigeIds;

  SearchedUser(
    {this.searchedUserImage,
    this.refrigeNames,
    this.refrigeIds,
    });

  SearchedUser.fromJson(Map<String, dynamic> json) {
    searchedUserImage = json['searchedUserImage'];
    refrigeNames = json['refrigeNames'] != null ? List<String>.from(json['refrigeNames']) : null;
    refrigeIds = json['refrigeIds'] != null ? List<int>.from(json['refrigeIds']) : null;
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['searchedUserImage'] = this.searchedUserImage;
  data['refrigeNames'] = this.refrigeNames;
  data['refrigeIds'] = this.refrigeIds;
  return data;
  }

  Map<String, dynamic> toJsonForEdit() {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['searchedUserImage'] = searchedUserImage;
  data['refrigeNames'] = refrigeNames;
  data['refrigeIds'] = refrigeIds;

  return data;
  }
}