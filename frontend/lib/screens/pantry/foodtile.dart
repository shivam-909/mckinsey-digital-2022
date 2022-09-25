import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/client/endpointcalls.dart';
import 'package:frontend/models/food.dart';
import 'package:frontend/util/palette.dart';
import 'package:frontend/util/utils.dart';
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
                  child: CachedNetworkImage(
                    imageUrl: snapshot.data!,
                    cacheKey: "food${widget.data.id}",
                    placeholder: ((context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[800]!,
                          highlightColor: Colors.white,
                          enabled: true,
                          child: SizedBox(
                              height: 80,
                              width: 80,
                              child: Container(color: Colors.grey[100]!)
                              // Image.network(
                              //   widget.data.url,
                              //   fit: BoxFit.fill,
                              // ),
                              ),
                        )),
                  ),
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
        const SizedBox(
          width: 16,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.data.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          ],
        )),
        Text(
          Utils.stringifyDate(widget.data.useBy),
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Palette.highlight),
        )
      ],
    );
  }
}
