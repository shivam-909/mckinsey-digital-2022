import 'package:flutter/material.dart';
import 'package:frontend/models/pantryitem.dart';
import 'package:frontend/screens/home/expiringtile.dart';
import 'package:frontend/util/palette.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(64),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.energy_savings_leaf_rounded,
                color: Palette.primary,
                size: 64,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                "Esca",
                style: TextStyle(color: Palette.primary, fontSize: 64),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Expiring soon!",
              style: TextStyle(color: Palette.highEmphasis, fontSize: 18),
            ),
          ),
        ),
        SingleChildScrollView(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                  PantryItem.placeholderList.length,
                  (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ExpiringTile(
                            item:
                                PantryItem.placeholderList.elementAt((index))),
                      ))),
        )
      ],
    );
  }
}
