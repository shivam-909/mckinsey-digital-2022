import 'package:flutter/material.dart';
import 'package:frontend/client/endpointcalls.dart';
import 'package:frontend/models/food.dart';
import 'package:frontend/screens/pantry/additemsearch.dart';
import 'package:frontend/screens/pantry/foodtile.dart';
import 'package:frontend/util/palette.dart';
import 'package:shimmer/shimmer.dart';

class Pantry extends StatefulWidget {
  const Pantry({super.key});

  @override
  State<Pantry> createState() => _PantryState();
}

class _PantryState extends State<Pantry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Pantry",
            style: TextStyle(fontSize: 24, color: Palette.highEmphasis),
          ),
          centerTitle: true,
          backgroundColor: Palette.background,
        ),
        body: Column(
          children: [
            AddItemSearch(),
            FutureBuilder<List<Food>>(
                future: Client.fetchPantry(),
                builder: ((context, snapshot) {
                  print(snapshot.connectionState);
                  if (snapshot.hasData) {
                    return Wrap(
                        children: List<Widget>.generate(
                      snapshot.data!.length,
                      (index) => GestureDetector(
                        child: FoodTile(data: snapshot.data!.elementAt(index)),
                        onTap: () {
                          Navigator.pop(
                              context, snapshot.data!.elementAt(index));
                        },
                      ),
                    ));
                  } else {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                    }

                    return const Center(
                      child: CircularProgressIndicator(color: Palette.primary),
                    );
                  }
                }))
          ],
        ));
  }
}
