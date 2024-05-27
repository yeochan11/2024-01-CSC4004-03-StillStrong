
class mainPageModel {
  String MainRecipeImage = "http//~/";
  List<String> SubRecipeImage = ["http//~/1", "http//~/2", "http//~/3", "http//~/4", "http//~/5"];
  List<String> SubRecipeCategory = ["한식", "일식", "중식", "양식", "일식"];
  List<String> SubRecipeName = ["김치찌개", "초밥", "짜장면", "파스타", "라멘"];

  mainPageModel(Map<String, dynamic>? data) {
    // MainRecipeImage = data?['MainRecipeImage'];
    // SubRecipeImage = data?['SubRecipeImage'];
    // SubRecipeCategory = data?['SubRecipeCategory'];
    // SubRecipeName = data?['SubRecipeName'];
    MainRecipeImage = data?['body'];
  }
}