class Food {
  final String name;
  final String type;
  final String id;
  final String url;
  final String servingSize;
  final Map<String, int> nutrition;

  Food(
      {required this.name,
      required this.type,
      required this.url,
      required this.servingSize,
      required this.nutrition,
      required this.id});

  // factory Food.fromJson(Map<String dynamic> json) => Food(name: json["food_name"], type: json["food_type"], url:  json[], servingSize, nutrition)
}
