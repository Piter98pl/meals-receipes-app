import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    required this.id,
    required this.title,
    required this.color,
  });
  final String id;
  final String title;
  final Color color;

  void selectCategory(BuildContext context) {
    Navigator.pushNamed(
      context,
      CategoryMealsScreen.routeName,
      arguments: {
        'id': id,
        'title': title,
      },
    );
  }
  // void selectCategory(BuildContext context) {
  //   Navigator.push(context, MaterialPageRoute(builder: (_) {
  //     return CategoryMealsScreen(categoryId: id, categoryName: title);
  //   }));
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        selectCategory(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            color.withOpacity(0.7),
            color,
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
