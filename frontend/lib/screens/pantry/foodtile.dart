import 'package:flutter/material.dart';
import 'package:frontend/client/endpointcalls.dart';
import 'package:frontend/models/food.dart';
import 'package:shimmer/shimmer.dart';

class FoodTile extends StatefulWidget {
  const FoodTile({super.key, required this.data});

  final Food data;

  @override
  State<FoodTile> createState() => _FoodTileState();
}

class _FoodTileState extends State<FoodTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FutureBuilder<String>(
            future: Client.fetchImageUrlForQuery(widget.data.name),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: 80,
                  width: 80,
                  child: Image.network(snapshot.data!),
                );
              } else {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                return Shimmer.fromColors(
                  baseColor: Colors.grey[800]!,
                  highlightColor: Colors.white,
                  enabled: true,
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.network(
                      widget.data.url,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              }
            })),
        Expanded(
            child: Column(
          children: [Text(widget.data.name)],
        ))
      ],
    );
  }
}
