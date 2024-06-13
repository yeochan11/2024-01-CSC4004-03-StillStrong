
class mainPageModel {
  String MainRecipeImage = "http//~/";
  String MainRecipeName = "스파게티";
  List<String> SubRecipeImage = ["http//~/1", "http//~/2", "http//~/3", "http//~/4", "http//~/5"];
  List<String> SubRecipeCategory = ["한식", "일식", "중식", "양식", "일식"];
  List<String> SubRecipeName = ["김치찌개", "초밥", "짜장면", "파스타", "라멘"];

  mainPageModel(Map<String, dynamic>? data) {
    MainRecipeImage = data?['mainRecipeImage'] ?? "http//~/";
    MainRecipeName = data?['mainRecipeName'] ?? "스파게티";
    SubRecipeImage = _convertToStringList(data?['subRecipeImage']) ?? ["http//~/1", "http//~/2", "http//~/3", "http//~/4", "http//~/5"];
    SubRecipeCategory = _convertToStringList(data?['subRecipeCategory']) ?? ["한식", "일식", "중식", "양식", "일식"];
    SubRecipeName = _convertToStringList(data?['subRecipeName']) ?? ["김치찌개", "초밥", "짜장면", "파스타", "라멘"];
  }

  List<String>? _convertToStringList(List<dynamic>? list) {
    if (list == null) return null;
    return list.map((item) => item.toString()).toList();
  }
}