import 'package:flutter/material.dart';

import 'package:meals_app_2/models/meal.dart';
import 'package:meals_app_2/screens/meals_screen/meal_item.dart';

class MealsScreen extends StatelessWidget {
  static const routeName = '/meals_screen';
  final String categoryName;
  final String categoryId;
  final List<Meal> availableMeals;
  MealsScreen(this.categoryId, this.categoryName, this.availableMeals);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryName'),
      ),
      body: ListView.builder(
          itemCount: availableMeals.length,
          itemBuilder: (ctx, index) {
            var meal = availableMeals[index];

            return MealItem(meal: meal);
          }),
    );
  }
}
