import 'package:flutter/material.dart';
import 'package:frontend/models/pantryitem.dart';
import 'package:frontend/util/palette.dart';
import 'package:frontend/util/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ExpiringTile extends StatefulWidget {
  const ExpiringTile({super.key, required this.item});

  final PantryItem item;

  @override
  State<ExpiringTile> createState() => _ExpiringTileState();
}

class _ExpiringTileState extends State<ExpiringTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item.name,
              style: const TextStyle(
                  fontSize: 16,
                  color: Palette.background,
                  fontWeight: FontWeight.w600),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                  height: 120,
                  width: 120,
                  child: CachedNetworkImage(
                    imageUrl: widget.item.imageUrl,
                    cacheKey: widget.item.name,
                    fit: BoxFit.fill,
                  )
                  // Image.network(
                  //   widget.item.imageUrl,
                  //   fit: BoxFit.cover,
                  // ),
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              Utils.stringifyDate(widget.item.useBy),
              style: TextStyle(color: Colors.red[400]),
            ),
          ],
        ),
      ),
    );
  }
}
