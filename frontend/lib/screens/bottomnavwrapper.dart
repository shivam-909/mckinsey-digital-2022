import 'package:flutter/material.dart';
import 'package:frontend/screens/home.dart';
import 'package:frontend/util/palette.dart';

class BottomNavWrapper extends StatefulWidget {
  const BottomNavWrapper({super.key});

  @override
  State<BottomNavWrapper> createState() => _BottomNavWrapperState();
}

class _BottomNavWrapperState extends State<BottomNavWrapper> {
  TextStyle optionStyle =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<BottomNavigationBarItem> items = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
      backgroundColor: Colors.red,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.restaurant),
      label: 'Recipes',
      backgroundColor: Colors.red,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.handshake),
      label: 'Volunteering',
      backgroundColor: Colors.red,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.map),
      label: 'Map',
      backgroundColor: Colors.red,
    ),
  ];

  int _selectedIndex = 0;

  late Map<int, Widget> bodyContents = {
    // 0: const Home(),
    0: placeholder("Home"),
    1: placeholder("Recipies"),
    2: placeholder("Volunteering"),
    3: placeholder("Map")
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
