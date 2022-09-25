import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/client/endpointcalls.dart';
import 'package:frontend/models/food.dart';
import 'package:frontend/screens/pantry/foodtile.dart';
import 'package:frontend/util/palette.dart';
import 'package:dotted_border/dotted_border.dart';

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
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          !hasData
              ? GestureDetector(
                  onTap: () async {
                    Food result = await Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const DropDownsearch(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ));
                    setState(() {
                      data = result;
                      hasData = true;
                    });
                  },
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    strokeWidth: 2,
                    dashPattern: [8, 4],
                    child: Container(
                        padding: EdgeInsets.all(24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add),
                            Text(
                              "Add item",
                              style: TextStyle(fontSize: 24),
                            ),
                          ],
                        )),
                  ),
                )
              : (data == null
                  ? const SizedBox(
                      height: 0,
                    )
                  : addItemForm()),
        ],
      ),
    );
  }

  addItemForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: FoodTile(data: data!),
          ),
          TextButton(
              onPressed: () {},
              child: Row(
                children: [Icon(Icons.calendar_month), Text("Set expirty")],
                mainAxisSize: MainAxisSize.min,
              ))
        ],
      );
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

  DateTime expiryDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Palette.highEmphasis,
          ),
        ),
        automaticallyImplyLeading: true,
        title: const Text(
          "Add item to pantry",
          style: TextStyle(fontSize: 24, color: Palette.highEmphasis),
        ),
        centerTitle: true,
        backgroundColor: Palette.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Search"),
              controller: _inputController,
            ),
            TextButton(
                onPressed: () async {
                  DateTime newPick = (await showDatePicker(
                      context: context,
                      initialDate: expiryDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 5)))!;

                  setState(() {
                    expiryDate = newPick;
                  });
                },
                child: Row(
                  children: [Icon(Icons.calendar_month), Text("Set expiry")],
                  mainAxisSize: MainAxisSize.min,
                )),
            if (query.trim() != "")
              FutureBuilder<List<Food>>(
                  future: Client.fetchFoods(query, expiryDate),
                  builder: ((context, snapshot) {
                    print(snapshot.connectionState);
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: List<Widget>.generate(
                              snapshot.data!.length,
                              (index) => GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: FoodTile(
                                      data: snapshot.data!.elementAt(index)),
                                ),
                                onTap: () {
                                  Navigator.pop(
                                      context, snapshot.data!.elementAt(index));
                                },
                              ),
                            )),
                      );
                    } else {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                      }

                      return const Center(
                        child:
                            CircularProgressIndicator(color: Palette.primary),
                      );
                    }
                  }))
          ],
        ),
      ),
    );
  }
}
