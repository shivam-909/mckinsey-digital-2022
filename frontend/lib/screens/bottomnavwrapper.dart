import 'package:flutter/material.dart';
import 'package:frontend/screens/home/home.dart';
import 'package:frontend/screens/pantry/pantry.dart';
import 'package:frontend/screens/recipes/recipesearch.dart';
import 'package:frontend/util/palette.dart';

class BottomNavWrapper extends StatefulWidget {
  const BottomNavWrapper({super.key});

  @override
  State<BottomNavWrapper> createState() => _BottomNavWrapperState();
}

class _BottomNavWrapperState extends State<BottomNavWrapper> {
  TextStyle optionStyle =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  BottomNavigationBarItem bottomIcon(IconData icon, String label) =>
      BottomNavigationBarItem(
        icon: Icon(
          icon,
          size: 48,
        ),
        label: label,
        backgroundColor: Colors.red,
      );

  late List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[
    bottomIcon(Icons.home, "Home"),
    bottomIcon(Icons.restaurant, "Recipes"),
    bottomIcon(Icons.cookie, "Pantry"),
    bottomIcon(Icons.handshake, "Help out"),
    bottomIcon(Icons.map, "Map"),
  ];

  static setPage(int pageNum) {}

  static int _selectedIndex = 0;

  late Map<int, Widget> bodyContents = {
    0: const Home(),
    // 0: placeholder("Home"),
    1: const RecipeGenerator(),
    2: const Pantry(),
    3: placeholder("Volunteering"),
    4: placeholder("Map")
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.background,
        body: bodyContents[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          fixedColor: Palette.primary,
          selectedFontSize: 16,
          unselectedFontSize: 14,
          items: items,
          onTap: (index) => _onItemTapped(index),
        ));
  }

  placeholder(String val) => Center(
        child: Text(
          val,
          style: TextStyle(fontSize: 24, color: Palette.highEmphasis),
        ),
      );
}
