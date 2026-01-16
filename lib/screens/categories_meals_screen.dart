import 'package:flutter/material.dart';
import 'package:recipe/components/meal_item.dart';
import 'package:recipe/models/category.dart';
import 'package:recipe/models/meals.dart';

class CategoriesMealsScreen extends StatelessWidget {

  final List<Meal> meals;

  const CategoriesMealsScreen(this.meals, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as Category;

    final categoryMeals = meals.where((meal) {
    return meal.categories.contains(category.id);
  }).toList();
  
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (ctx, index) {
          return MealItem(meal: categoryMeals[index]);
        },
        ),
    );
  }
}
