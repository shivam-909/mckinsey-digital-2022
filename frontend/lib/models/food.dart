import 'dart:ffi';

import 'package:frontend/util/utils.dart';

class Food {
  final String name;
  final String type;
  final String id;
  final String url;
  final String servingSize;
  final Map<String, String> nutrition;
  DateTime useBy;

  Food(
      {required this.name,
      required this.type,
      required this.url,
      required this.servingSize,
      required this.nutrition,
      required this.id,
      required this.useBy});

  static Map<String, dynamic> parseDescription(String val) {
    List<String> descriptionSplit = val.split(" - ");
    String servingSize = descriptionSplit[0].split(" ")[1];
    Map<String, String> details = {
      for (var val in descriptionSplit[1].split(" | "))
        val.split(": ")[0]: val.split(": ")[1]
    };

    return {"servingSize": servingSize, "details": details};
  }

  factory Food.fromJson(
      {required Map<String, dynamic> jsonData, required DateTime expiry}) {
    Map<String, dynamic> parsedDesc =
        parseDescription(jsonData["food_description"]);

    return Food(
        name: jsonData["food_name"],
        type: jsonData["food_type"],
        url: jsonData["food_url"],
        servingSize: parsedDesc["servingSize"],
        nutrition: parsedDesc["details"],
        id: jsonData["food_id"],
        useBy: DateTime.now());
  }

  setUseBy(DateTime date) {
    this.useBy = date;
  }

  factory Food.fromPantryJson({required Map<String, dynamic> jsonData}) => Food(
      name: jsonData["short_name"],
      type: "Pantry Food",
      url: jsonData["image"],
      servingSize: "",
      // parsedDesc["servingSize"],
      nutrition: {},
      useBy: DateTime.parse(jsonData["best_by"]),
      // parsedDesc["details"],d
      id: jsonData["id"]);
}
