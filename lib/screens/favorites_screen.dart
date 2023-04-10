import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen(this.favoriteMeals);

  final List<Meal> favoriteMeals;

  @override
  Widget build(BuildContext context) {
    return favoriteMeals.isEmpty
        ? Center(
            child: Text(
            'You have no favorites yet',
            style: Theme.of(context).textTheme.titleLarge,
          ))
        : ListView.builder(
            itemBuilder: (context, index) {
              return MealItem(favoriteMeals[index]);
            },
            itemCount: favoriteMeals.length,
          );
  }
}
