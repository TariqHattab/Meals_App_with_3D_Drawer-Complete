import 'package:flutter/cupertino.dart';
import 'package:meals_app_2/models/meal.dart';

class FavoriteList extends ChangeNotifier {
  List<Meal> _favoritesList = [];
  List<Meal> get favoritesList {
    return _favoritesList;
  }

  void addFavorite(Meal meal) {
    print('add favorite');
    _favoritesList.add(meal);
    notifyListeners();
  }

  void removeFavorite(Meal meal) {
    print(_favoritesList);
    print('remove favorite');
    _favoritesList.remove(meal);
    notifyListeners();
  }

  bool isFavorite(Meal meal) {
    return _favoritesList.contains(meal);
  }
}
