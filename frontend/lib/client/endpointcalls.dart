import 'dart:convert';

import 'package:frontend/models/food.dart';
import 'package:frontend/models/recipe.dart';
import 'package:http/http.dart' as http;

class Client {
  static const String baseUrl = "http://10.23.226.16/api/";

  static Future<List<Food>> fetchFoods(String query, DateTime expiry) async {
    http.Response response = await http.get(
        Uri.parse(
          baseUrl + "search?term=$query&offset=0&limit=10",
        ),
        headers: {"Content-Type": "application/json"});

    print(response.statusCode);

    List<dynamic> json = jsonDecode(response.body);

    return json
        .map((element) => Food.fromJson(jsonData: element, expiry: expiry))
        .toList();
  }

  static Future<List<Food>> fetchPantry() async {
    http.Response response = await http.get(
        Uri.parse(
          baseUrl + "pantry",
        ),
        headers: {"Content-Type": "application/json"});

    print(response.statusCode);

    List<dynamic> json = jsonDecode(response.body);

    return json
        .map((element) => Food.fromPantryJson(jsonData: element))
        .toList();
  }

  static Future<List<Recipe>> fetchPantryRecipes(List<String> filters) async {
    Map<String, String> mappings = {
      "Vegetarian": "vegetarian",
      "Halal": "halal",
      "Non-beef": "nonbeef",
      "Coeliac": "coeliac",
    };

    String filterString = filters.map((e) => mappings[e]).join(",");

    http.Response response = await http.get(
        Uri.parse(
          baseUrl +
              ((filters.length == 0)
                  ? "pantryrecipes"
                  : "pantryrecipes?diet=$filterString"),
        ),
        headers: {"Content-Type": "application/json"});

    print(response.statusCode);

    List<dynamic> json = jsonDecode(response.body);

    return json.map((element) => Recipe.fromJson(element)).toList();
    // .map((element) => Food.fromPantryJson(jsonData: element))
  }

  static Future<String> fetchImageUrlForQuery(String query) async {
    http.Response response = await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=1"),
        headers: {
          "Authorization":
              "563492ad6f91700001000001ff5847c3775c4e659d58ab8b6e5b312b"
        });

    Map<String, dynamic> jsonData = jsonDecode(response.body) ?? {};

    print(jsonData);

    return jsonData["photos"] == null
        ? ""
        : jsonData["photos"][0]["src"]["original"];
  }
}
