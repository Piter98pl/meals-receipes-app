import 'package:flutter/material.dart';
import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import './dummy_data.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = dummyMeals;

  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = dummyMeals.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final exisitingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (exisitingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(exisitingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          dummyMeals.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Raleway',
        colorSchemeSeed: Colors.green,
        appBarTheme: AppBarTheme().copyWith(
          centerTitle: true,
        ),
        textTheme: const TextTheme(
          bodySmall: TextStyle(
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
          ),
          bodyLarge: TextStyle(
            color: Colors.black,
          ),
          titleMedium: TextStyle(
            color: Color.fromRGBO(21, 22, 21, 1),
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            color: Color.fromRGBO(200, 71, 71, 1),
          ),
          titleLarge: TextStyle(
            color: Color.fromRGBO(15, 16, 15, 1),
          ),
        ),
        scrollbarTheme: const ScrollbarThemeData(
            thickness: MaterialStatePropertyAll(8),
            radius: Radius.circular(20),
            interactive: true),
      ),
      //home: CategoriesScreen(),

      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_setFilters, _filters),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.name);
      //   return MaterialPageRoute(
      //     builder: (ctx) {
      //       return CategoriesScreen();
      //     },
      //   );
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
