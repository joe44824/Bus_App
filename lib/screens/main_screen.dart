import 'package:bus_app/screens/favourite_screen.dart';
import 'package:bus_app/screens/home_screen.dart';
import 'package:bus_app/screens/routes_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const routeName = 'main_screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentNavIndex],
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  final screens = [
    const HomeScreen(),
    const FavoriteScreen(),
    const RoutesScreen()
  ];

  List<BottomNavigationBarItem> navItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.near_me), label: 'Nearby'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite_sharp), label: 'Favourite'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.map_outlined), label: 'Routes'),
  ];

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      items: navItems,
      currentIndex: currentNavIndex,
      selectedItemColor: const Color(0xff00ADB5),
      onTap: (index) => setState(() => currentNavIndex = index),
    );
  }
}
