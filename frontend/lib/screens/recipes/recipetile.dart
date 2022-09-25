import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/recipe.dart';
import 'package:frontend/screens/recipes/recipepage.dart';

class RecipeTile extends StatefulWidget {
  const RecipeTile({super.key, required this.recipe});

  final Recipe recipe;

  @override
  State<RecipeTile> createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  RecipePage(
                recipe: widget.recipe,
              ),
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
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(children: [
          SizedBox(
            height: 100,
            width: 100,
            child: CachedNetworkImage(
              imageUrl: widget.recipe.imageUrl,
              cacheKey: "recipe${widget.recipe.id}",
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.recipe.title.trim(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(widget.recipe.usedIngredients.map((e) => e.name).join(", "))
            ]),
          )
        ]),
      ),
    );
  }
}
