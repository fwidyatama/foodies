class Meals {
  List<MealsItem> meals;

  Meals({
    this.meals,
  });

  factory Meals.fromJson(Map<String, dynamic> json) => new Meals(
    meals: List<MealsItem>.from(json["meals"].map((v) => MealsItem.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "meals": new List<dynamic>.from(meals.map((v) => v.toJson())),
  };
}

class MealsItem {
  String idMeal;
  String strMeal;
  String strCategory;
  String strInstructions;
  String strMealThumb;
  String strIngredient1;
  String strIngredient2;
  String strIngredient3;
  String strIngredient4;
  String strIngredient5;

  MealsItem({
    this.idMeal,
    this.strMeal,
    this.strCategory,
    this.strInstructions,
    this.strMealThumb,
    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient3,
    this.strIngredient4,
    this.strIngredient5,
  });

  factory MealsItem.fromJson(Map<String, dynamic> json) => MealsItem(
    idMeal: json["idMeal"],
    strMeal: json["strMeal"],
    strCategory: json["strCategory"],
    strInstructions: json["strInstructions"],
    strMealThumb: json["strMealThumb"],
    strIngredient1: json["strIngredient1"],
    strIngredient2: json["strIngredient2"],
    strIngredient3: json["strIngredient3"],
    strIngredient4: json["strIngredient4"],
    strIngredient5: json["strIngredient5"],
  );

  Map<String, dynamic> toJson() => {
    "idMeal": idMeal,
    "strMeal": strMeal,
    "strCategory": strCategory,
    "strInstructions": strInstructions,
    "strMealThumb": strMealThumb,
    "strIngredient1": strIngredient1,
    "strIngredient2": strIngredient2,
    "strIngredient3": strIngredient3,
    "strIngredient4": strIngredient4,
    "strIngredient5": strIngredient5,
  };
}