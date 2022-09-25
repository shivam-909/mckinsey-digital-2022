import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/client/endpointcalls.dart';
import 'package:frontend/models/recipe.dart';
import 'package:frontend/util/palette.dart';
import 'package:frontend/util/utils.dart';
import 'package:http/http.dart' as http;

class RecipePage extends StatefulWidget {
  const RecipePage({super.key, required this.recipe});

  final Recipe recipe;

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          widget.recipe.title,
          style: TextStyle(fontSize: 24, color: Palette.highEmphasis),
        ),
        centerTitle: true,
        backgroundColor: Palette.background,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Net CO2 Emissions Saved ${widget.recipe.emissions.toString()} g",
              style: TextStyle(fontSize: 18),
            )
          ]),
        ),
        Container(
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(color: Colors.grey[800]!),
          child: ListView(shrinkWrap: true, children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: const Text(
                "Ingredients",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ...widget.recipe.unusedIngredients.map((Ingredient e) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${e.amount} ${e.unit}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      e.name,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    )
                  ],
                ))
          ]),
        ),
        Container(
          padding: EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: Text(
            "Recipe Instructions",
            style: TextStyle(
                fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: FutureBuilder<http.Response>(
              future: http.get(Uri.parse(
                  Client.baseUrl + "recipebyid?id=${widget.recipe.id}")),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic> json = jsonDecode(snapshot.data!.body);

                  return Text(Utils.parseHtmlString(json["instructions"]));
                } else {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                  }
                  return CircularProgressIndicator();
                }
              })),
        )
      ]),
    );
  }
}
