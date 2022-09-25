import 'package:flutter/material.dart';
import 'package:frontend/screens/pantry/additemsearch.dart';
import 'package:shimmer/shimmer.dart';

class Pantry extends StatefulWidget {
  const Pantry({super.key});

  @override
  State<Pantry> createState() => _PantryState();
}

class _PantryState extends State<Pantry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        AddItemSearch(),
      ],
    ));
  }
}
