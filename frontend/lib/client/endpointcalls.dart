import 'dart:convert';

import 'package:frontend/models/food.dart';
import 'package:http/http.dart' as http;

class Client {
  static const String baseUrl = "http://10.23.226.16/api/";

  static Future<List<Food>> fetchFoods(String query) async {
    http.Response response = await http.get(
        Uri.parse(
          baseUrl + "search?term=$query&offset=0&limit=10",
        ),
        headers: {"Content-Type": "application/json"});

    print(response.statusCode);

    List<dynamic> json = jsonDecode(response.body);

    return json.map((element) => Food.fromJson(jsonData: element)).toList();
  }

  static Future<String> fetchImageUrlForQuery(String query) async {
    http.Response response = await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=1"),
        headers: {
          "Authorization":
              "563492ad6f91700001000001ff5847c3775c4e659d58ab8b6e5b312b"
        });

    Map<String, dynamic> jsonData = jsonDecode(response.body);

    print(jsonData);

    return jsonData["photos"][0]["src"]["original"];
  }
}
