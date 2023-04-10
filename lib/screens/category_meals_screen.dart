import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../dummy_data.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  // const CategoryMealsScreen(
  //     {required this.categoryId, required this.categoryName});
  // final String categoryId;
  // final String categoryName;
  static const routeName = '/category-meals';
  const CategoryMealsScreen(this.availableMeals);

  final List<Meal> availableMeals;

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? _categoryTitle;
  List<Meal>? _displayedMeals;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = routeArgs['id'];
    _categoryTitle = routeArgs['title'];
    _displayedMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(categoryId))
        .toList();
  }

  void _removeMeal(String mealId) {
    setState(() {
      _displayedMeals!.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_categoryTitle Receipes'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(_displayedMeals![index]);
        },
        itemCount: _displayedMeals!.length,
      ),
    );
  }
}
