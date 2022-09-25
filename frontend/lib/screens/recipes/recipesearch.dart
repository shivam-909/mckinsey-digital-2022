import 'package:flutter/material.dart';
import 'package:frontend/client/endpointcalls.dart';
import 'package:frontend/models/recipe.dart';
import 'package:frontend/screens/recipes/filtertag.dart';
import 'package:frontend/screens/recipes/recipetile.dart';
import 'package:frontend/util/palette.dart';

class RecipeGenerator extends StatefulWidget {
  const RecipeGenerator({super.key});

  @override
  State<RecipeGenerator> createState() => _RecipeGeneratorState();
}

class _RecipeGeneratorState extends State<RecipeGenerator> {
  Map<String, bool> filterTags = {
    "Vegetarian": false,
    "Halal": false,
    "Non-beef": false,
    "Coeliac": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Recipe Generator",
          style: TextStyle(fontSize: 24, color: Palette.highEmphasis),
        ),
        centerTitle: true,
        backgroundColor: Palette.background,
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
        ),
        FutureBuilder<List<Recipe>>(
            future: Client.fetchPantryRecipes(filterTags.keys
                .where((element) => filterTags[element]!)
                .toList()),
            builder: ((context, snapshot) {
              print(snapshot.connectionState);
              if (snapshot.hasData) {
                // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                //   setState(() {});
                // });
                final Set ids = Set();
                List<Recipe> data = snapshot.data!
                    .where((element) => ids.add(element.id))
                    .toList();

                print(snapshot.data!.length);
                // print(data.length)

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      // child: ListView.builder(
                      //     shrinkWrap: true,
                      //     scrollDirection: Axis.vertical,
                      //     itemCount: snapshot.data!.length,
                      //     itemBuilder: ((context, index) => RecipeTile(
                      //         recipe: snapshot.data!.elementAt(index)))),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List<Widget>.generate(
                            snapshot.data!.length,
                            (index) => RecipeTile(
                                recipe: snapshot.data!.elementAt(index)),
                          )),
                    ),
                  ),
                );
              } else {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }

                return const Center(
                  child: CircularProgressIndicator(color: Palette.primary),
                );
              }
            }))
      ]),
    );
  }
}
