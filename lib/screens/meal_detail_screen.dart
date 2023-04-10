import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  final Function toggleFavorite;
  final Function isFavorite;
  final ScrollController controller = ScrollController();

  Widget buildSectionTitle(String text, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      height: 150,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)!.settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text(meal.name)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: 220,
                width: double.infinity,
                child: Image.network(
                  meal.imageUrl,
                  fit: BoxFit.cover,
                )),
            buildSectionTitle('Ingredients', context),
            buildContainer(
              Scrollbar(
                controller: controller,
                child: ListView.builder(
                  controller: controller,
                  itemBuilder: ((context, index) {
                    return Card(
                        color: Colors.white,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(meal.ingredients[index]),
                        ));
                  }),
                  itemCount: meal.ingredients.length,
                ),
              ),
            ),
            buildSectionTitle('Steps', context),
            buildContainer(
              Scrollbar(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                child: Text('# ${(index + 1)}'),
                              ),
                              title: Text(meal.steps[index]),
                            ),
                            const Divider()
                          ],
                        ));
                  },
                  itemCount: meal.steps.length,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          toggleFavorite(meal.id);
        },
        child:
            Icon(isFavorite(meal.id) ? Icons.favorite : Icons.favorite_border),
      ),
    );
  }
}
