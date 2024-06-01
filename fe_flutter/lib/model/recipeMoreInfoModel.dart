
class RecipeMoreInfoModel {
  String recipeName = "새우 두부 계란찜";
  String recipeCategory = "찜탕";
  String recipeMainImage = "http://www.foodsafetykorea.go.kr/uploadimg/cook/10_00028_1.png";
  List<String> recipeIngredients = ["연두부", "새우", "달걀", "생크림", "설탕", "버터", "시금치"];
  List<String> recipeDescriptions = [
    "1. 손질된 새우를 끓는 물에 데쳐 건진다.a",
    "2. 연두부, 달걀, 생크림, 설탕에 녹인 무염버터를 믹서에 넣고 간 뒤 새우(1)를 함께 섞어 그릇에 담는다.b",
    "3. 시금치를 잘게 다져 혼합물 그릇(2)에 뿌리고 찜기에 넣고 중간 불에서 10분 정도 찐다.c"
  ];
  List<String> recipeImage = [
    "http://www.foodsafetykorea.go.kr/uploadimg/cook/20_00028_1.png",
    "http://www.foodsafetykorea.go.kr/uploadimg/cook/20_00028_2.png",
    "http://www.foodsafetykorea.go.kr/uploadimg/cook/20_00028_3.png"
  ];

  RecipeMoreInfoModel(Map<String, dynamic>? data) {
    // TODO: API 주소 설정했으면 밑에 주석 해제해주세요.
    // recipeName = data?['recipeName'];
    // recipeCategory = data?['recipeCategory'];
    // recipeMainImage = data?['recipeMainImage'];
    // recipeIngredients = _convertToStringList(data?['recipeIngredients']) ?? [""];
    // recipeDescriptions = _convertToStringList(data?['recipeDescriptions']) ?? [""];
    // recipeImage = _convertToStringList(data?['recipeImage']) ?? [""];
  }
  List<String>? _convertToStringList(List<dynamic>? list) {
    if (list == null) return null;
    return list.map((item) => item.toString()).toList();
  }
}