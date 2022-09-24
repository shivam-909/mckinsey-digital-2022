import 'package:flutter/material.dart';
import 'package:frontend/util/palette.dart';

class FilterTag extends StatefulWidget {
  FilterTag(
      {super.key,
      required this.name,
      required this.active,
      required this.onTap});

  final String name;
  bool active;
  VoidCallback onTap;

  @override
  State<FilterTag> createState() => _FilterTagState();
}

class _FilterTagState extends State<FilterTag> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
            border: Border.all(
                color:
                    !widget.active ? Palette.background : Colors.transparent),
            borderRadius: BorderRadius.circular(12),
            color: !widget.active ? Palette.highEmphasis : Palette.primary),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(
            !widget.active ? Icons.add : Icons.close,
            color: widget.active ? Palette.highEmphasis : Palette.background,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            widget.name,
            style: TextStyle(
                color:
                    widget.active ? Palette.highEmphasis : Palette.background),
          )
        ]),
      ),
    );
  }
}
