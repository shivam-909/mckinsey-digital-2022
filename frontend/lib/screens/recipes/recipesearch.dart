import 'package:flutter/material.dart';
import 'package:frontend/screens/recipes/filtertag.dart';
import 'package:frontend/util/palette.dart';

class RecipeGenerator extends StatefulWidget {
  const RecipeGenerator({super.key});

  @override
  State<RecipeGenerator> createState() => _RecipeGeneratorState();
}

class _RecipeGeneratorState extends State<RecipeGenerator> {
  Map<String, bool> filterTags = {
    "Vegan": false,
    "Vegetarian": false,
    "Halal": false,
    "Kosher": false,
    "Non-beef": false,
    "Coeliac": false,
    "Diary-free": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Recipe Generator",
          style: TextStyle(fontSize: 24, color: Palette.background),
        ),
        centerTitle: true,
        backgroundColor: Palette.highEmphasis,
      ),
      body: Column(children: [
        Container(
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Palette.background, width: 1))),
          padding: const EdgeInsets.all(24),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List<Widget>.generate(
                filterTags.keys.length,
                ((index) => FilterTag(
                    active: filterTags[filterTags.keys.elementAt(index)]!,
                    name: filterTags.keys.elementAt(index),
                    onTap: () => setState(() {
                          filterTags[filterTags.keys.elementAt(index)] =
                              !(filterTags[filterTags.keys.elementAt(index)]!);
                        })))),
          ),
        )
      ]),
    );
  }
}
