import 'package:flutter/material.dart';
import 'package:recipe/components/meal_item.dart';
import 'package:recipe/models/meals.dart';

class FavoriteScreens extends StatelessWidget {
  final List<Meal> favoriteMeals;
  const FavoriteScreens({super.key, required this.favoriteMeals});

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(child: Text('Nenhuma refeição foi favoritada!'));
    } else {
      return ListView.builder(
        itemCount: favoriteMeals.length,
        itemBuilder: (ctx, index) {
          return MealItem(meal: favoriteMeals[index]);
        },
      );
    }
  }
}
