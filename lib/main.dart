import 'package:flutter/material.dart';
import 'package:recipe/models/settings.dart';
import 'package:recipe/screens/categories_meals_screen.dart';
import 'package:recipe/screens/meal_detail_screen.dart';
import 'package:recipe/screens/settings_screen.dart';
import 'package:recipe/screens/tabs_screens.dart';
import 'utils/app_routes.dart';
import 'models/meals.dart';
import 'data/dummy_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();

  List<Meal> _availableMeals = dummyMeals;
  List<Meal> _favoriteMeals = [];

  void filterMeal(Settings settings) {
    setState(() {
      this.settings = settings;
      _availableMeals = dummyMeals.where((meal) {
        final filterGlutten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;
        return !filterGlutten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  void _toogleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primaryColor: Colors.blue,
        fontFamily: 'Raleway',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ).copyWith(surface: Color.fromRGBO(255, 254, 229, 1)),
        textTheme: ThemeData.light().textTheme.copyWith(
          titleLarge: TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed'),
        ),
      ),
      routes: {
        AppRoutes.HOME: (ctx) => TabsScreens(favoriteMeals: _favoriteMeals),
        AppRoutes.CATEGORIES_MEALS: (ctx) =>
            CategoriesMealsScreen(_availableMeals),
        AppRoutes.Meal_Detail: (ctx) =>
            MealDetailScreen(onToggleFavorite: _toogleFavorite, isFavorite: _isFavorite),
        AppRoutes.SETTINGS: (ctx) =>
            SettingsScreen(settings: settings, onSettingsChanged: filterMeal),
      },
    );
  }
}
