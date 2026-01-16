import 'package:flutter/material.dart';
import 'package:recipe/components/drawer.dart';
import 'package:recipe/models/meals.dart';
import 'package:recipe/screens/categories_screen.dart';
import 'package:recipe/screens/favorite_screens.dart';

class TabsScreens extends StatefulWidget {
  final List<Meal> favoriteMeals;
  const TabsScreens({super.key, required this.favoriteMeals});

  @override
  State<TabsScreens> createState() => _TabsScreensState();
}

class _TabsScreensState extends State<TabsScreens> {
  int _selectedScreensIndex = 0;
  late List<Map<String, Object>> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      {'title': 'Lista de Categorias', 'screen': CategoriesScreen()},
      {
        'title': 'Favoritos',
        'screen': FavoriteScreens(favoriteMeals: widget.favoriteMeals),
      },
    ];
  }

  _selectScreen(int index) {
    setState(() {
      _selectedScreensIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          _screens[_selectedScreensIndex]['title'] as String,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      drawer: AppDrawer(),
      body: _screens[_selectedScreensIndex]['screen'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber,
        currentIndex: _selectedScreensIndex,
        onTap: _selectScreen,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritos'),
        ],
      ),
    );
  }
}
