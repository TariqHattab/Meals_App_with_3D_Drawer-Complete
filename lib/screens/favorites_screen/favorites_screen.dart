import 'package:flutter/material.dart';

import 'package:meals_app_2/dummy_data.dart';
import 'package:meals_app_2/models/meal.dart';
import 'package:meals_app_2/providers/favorite_list.dart';
import 'package:meals_app_2/screens/meals_screen/meal_item.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var favoritesList = Provider.of<FavoriteList>(context).favoritesList;
    return favoritesList.isEmpty
        ? Center(
            child: Text(
              'No favorites was selected, start choosing some favorites.',
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              var fav = favoritesList[index];
              return MealItem(meal: fav);
            },
            itemCount: favoritesList.length,
          );
  }
}
