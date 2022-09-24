import 'package:flutter/material.dart';
import 'package:frontend/models/pantryitem.dart';
import 'package:frontend/util/palette.dart';
import 'package:frontend/util/utils.dart';

class ExpiringTile extends StatefulWidget {
  const ExpiringTile({super.key, required this.item});

  final PantryItem item;

  @override
  State<ExpiringTile> createState() => _ExpiringTileState();
}

class _ExpiringTileState extends State<ExpiringTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.item.name,
          style: const TextStyle(fontSize: 16, color: Palette.highEmphasis),
        ),
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
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          Utils.stringifyDate(widget.item.useBy),
          style: const TextStyle(color: Palette.highlight),
        ),
      ],
    );
  }
}
