class Recipe {
  String? recipeName;
  String? recipeCategory;
  String? recipeMainImage;
  List<List<String>>? recipeIngredients;
  List<String>? recipeDescriptions;
  List<String>? recipeImage;

  Recipe(
    {
      this.recipeName,
      this.recipeCategory,
      this.recipeMainImage,
      this.recipeIngredients,
      this.recipeDescriptions,
      this.recipeImage
    }
  );

  Recipe.fromJson(Map<String, dynamic> json) {
    recipeName = json['recipeName'];
    recipeCategory = json['recipeCategory'];
    recipeMainImage = json['recipeMainImage'];
    recipeIngredients = json['recipeIngredients'] != null
        ? List<List<String>>.from(json['recipeIngredients'])
        : null;
    recipeDescriptions = json['recipeDescriptions'] != null
        ? List<String>.from(json['recipeDescriptions'])
        : null;
    recipeImage = json['recipeImage'] != null
        ? List<String>.from(json['recipeImage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recipeName'] = this.recipeName;
    data['recipeCategory'] = this.recipeCategory;
    data['recipeMainImage'] = this.recipeMainImage;
    data['recipeIngredients'] = this.recipeIngredients;
    data['recipeDescriptions'] = this.recipeDescriptions;
    data['recipeImage'] = this.recipeImage;
    return data;
  }
}

class RecommendedRecipe{
  List<String>? recipeNames;
  List<String>? recipeMainImages;
  List<List<String>>? recipeIngredients;

  RecommendedRecipe(
    {
      this.recipeNames,
      this.recipeMainImages,
      this.recipeIngredients
    }
  );

  RecommendedRecipe.fromJson(Map<String, dynamic> json) {
    recipeNames = json['recipeNames'] != null
        ? List<String>.from(json['recipeNames'])
        : null;
    recipeMainImages = json['recipeMainImages'] != null
        ? List<String>.from(json['recipeMainImages'])
        : null;
    recipeIngredients = json['recipeIngredients'] != null
        ? List<List<String>>.from(json['recipeIngredients'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recipeNames'] = this.recipeNames;
    data['recipeMainImages'] = this.recipeMainImages;
    data['recipeIngredients'] = this.recipeIngredients;
    return data;
  }
}