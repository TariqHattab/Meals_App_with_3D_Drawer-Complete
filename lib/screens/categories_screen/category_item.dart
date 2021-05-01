import 'package:flutter/material.dart';
import 'package:meals_app_2/dummy_data.dart';
import 'package:meals_app_2/providers/available_list.dart';
import 'package:meals_app_2/screens/meals_screen/meals_screen.dart';
import 'package:provider/provider.dart';
import '../../models/category.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key key,
    @required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Consumer<AvailableList>(
      builder: (ctx, avlist, ch) {
        return InkWell(
            onTap: () {
              var categoryMeals = avlist.availableList
                  .where((meal) => meal.categories.contains(category.id))
                  .toList();
              Navigator.of(context)
                  .pushNamed(MealsScreen.routeName, arguments: {
                'id': category.id,
                'title': category.title,
                'meals': categoryMeals,
              });
            },
            borderRadius: BorderRadius.circular(15),
            child: ch);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
              colors: [category.color.withOpacity(.7), category.color]),
        ),
        padding: const EdgeInsets.only(top: 10, left: 10),
        child: Text(
          category.title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
