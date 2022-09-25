import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/client/endpointcalls.dart';
import 'package:frontend/models/food.dart';
import 'package:frontend/screens/pantry/foodtile.dart';
import 'package:frontend/util/palette.dart';

class AddItemSearch extends StatefulWidget {
  const AddItemSearch({super.key});

  @override
  State<AddItemSearch> createState() => _AddItemSearchState();
}

class _AddItemSearchState extends State<AddItemSearch> {
  bool hasData = false;
  Food? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        !hasData
            ? TextButton(
                onPressed: () async {
                  Food result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => DropDownsearch())));
                  setState(() {
                    data = result;
                    hasData = true;
                  });
                },
                child: Text("Add recipe"))
            : (data == null
                ? const SizedBox(
                    height: 0,
                  )
                : FoodTile(data: data!)),
      ],
    );
  }
}

class DropDownsearch extends StatefulWidget {
  const DropDownsearch({super.key});

  @override
  State<DropDownsearch> createState() => _DropDownsearchState();
}

class _DropDownsearchState extends State<DropDownsearch> {
  final TextEditingController _inputController = TextEditingController();
  String query = "";

  @override
  void initState() {
    super.initState();
    _inputController.addListener(() {
      setState(() {
        query = _inputController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: _inputController,
          ),
          if (query.trim() != "")
            FutureBuilder<List<Food>>(
                future: Client.fetchFoods(query),
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
      ),
    );
  }
}
