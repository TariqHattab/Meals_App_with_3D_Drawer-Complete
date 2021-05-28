import 'package:flutter/material.dart';
import 'package:meals_app_2/dummy_data.dart';
import 'package:meals_app_2/screens/categories_screen/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemCount: DUMMY_CATEGORIES.length,
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (ctx, index) {
          var category = DUMMY_CATEGORIES[index];
          return CategoryItem(category: category);
        });
  }
}
