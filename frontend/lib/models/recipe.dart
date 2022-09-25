class Recipe {
  final String title;
  final String imageUrl;
  final int id;
  final List<Ingredient> missedIngredients;
  final List<Ingredient> usedIngredients;
  final List<Ingredient> unusedIngredients;
  final int calories;
  final int emissions;

  Recipe(
      {required this.title,
      required this.calories,
      required this.emissions,
      required this.imageUrl,
      required this.id,
      required this.missedIngredients,
      required this.usedIngredients,
      required this.unusedIngredients});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<Ingredient> missed = (json["missedIngredients"] as List<dynamic>)
        .map((element) => Ingredient.fromJson(element))
        .toList();
    List<Ingredient> used = (json["usedIngredients"] as List<dynamic>)
        .map((element) => Ingredient.fromJson(element))
        .toList();
    List<Ingredient> unused = (json["unusedIngredients"] as List<dynamic>)
        .map((element) => Ingredient.fromJson(element))
        .toList();

    return Recipe(
        calories: json["calories"],
        emissions: json["emissions"],
        title: json["title"],
        imageUrl: json["image"],
        id: json["id"],
        missedIngredients: missed,
        usedIngredients: used,
        unusedIngredients: unused);
  }
}

class Ingredient {
  final int id;
  final String amount;
  final String unit;
  final String name;
  final String imageUrl;

  Ingredient(
      {required this.id,
      required this.amount,
      required this.unit,
      required this.name,
      required this.imageUrl});

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
      id: json["id"],
      amount: json["amount"].toString(),
      unit: json["unitShort"],
      name: json["originalName"],
      imageUrl: json["image"]);
}
