
class RecipeSearchModel {
  List<String> recipeNames = [];
  List<String> recipeMainImages = ["http://www.foodsafetykorea.go.kr/uploadimg/cook/10_00028_1.png", 'https://recipe1.ezmember.co.kr/cache/recipe/2022/09/30/8e7eb8e3019532a8dc6d39a9a325aad41.jpg','https://recipe1.ezmember.co.kr/cache/recipe/2022/09/30/8e7eb8e3019532a8dc6d39a9a325aad41.jpg'];
  List<List<String>?> recipeIngredients = [
    ["연두부", "새우", "달걀"],
    ["생크림", "설탕", "버터"],
    ["시금치"]
  ];

  RecipeSearchModel(Map<String, dynamic>? data) {
    recipeNames = _convertToStringList(data?['recipeNames']) ?? ["새우 두부 계란찜", "김치찌개", "스파게티", "스파게티"];
    recipeMainImages = _convertToStringList(data?['recipeMainImages']) ?? ["http://www.foodsafetykorea.go.kr/uploadimg/cook/10_00028_1.png", 'https://recipe1.ezmember.co.kr/cache/recipe/2022/09/30/8e7eb8e3019532a8dc6d39a9a325aad41.jpg','https://recipe1.ezmember.co.kr/cache/recipe/2022/09/30/8e7eb8e3019532a8dc6d39a9a325aad41.jpg'];
    recipeIngredients = _convertToListList(data?['recipeIngredients']) ?? [
      ["연두부", "새우", "달걀"],
      ["생크림", "설탕", "버터"],
      ["시금치"]
    ];
  }

  List<String>? _convertToStringList(List<dynamic>? list) {
    if (list == null) return null;
    return list.map((item) => item.toString()).toList();
  }

  List<List<String>?>? _convertToListList(List<dynamic>? list) {
    if (list == null) return null;
    return list.map((item) => _convertToStringList(item)).toList();
  }
}