import 'package:flutter/material.dart';
import 'package:frontend/models/pantryitem.dart';
import 'package:frontend/util/palette.dart';
import 'package:frontend/util/utils.dart';

class IngredientTile extends StatefulWidget {
    const IngredientTile({super.key, required this.item});

    final PantryItem item;

    @override
    State<IngredientTile> createState() => _IngredientTileState();
}

class _IngredientTileState extends State<IngredientTile> {
    @override
    Widget build(BuildContext context) {
        return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
                Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(
                            widget.item.imageUrl,
                            fit: BoxFit.cover,
                        ),
                    ),
                )
            ]
        )
    }
}